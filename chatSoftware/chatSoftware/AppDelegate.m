//
//  AppDelegate.m
//  chatSoftware
//
//  Created by zhanglf on 16/3/24.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "AppDelegate.h"
#import "ZLFLoginViewController.h"
#import "ZLFMessageViewController.h"
@interface AppDelegate ()
@property (nonatomic, strong) ZLFLoginViewController * login;

@end

@implementation AppDelegate
@synthesize xmppStream;
- (void)setupStream
{
    xmppStream = [[XMPPStream alloc]init];
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.login = [[ZLFLoginViewController alloc]init];
    self.window.rootViewController = self.login;
    // 安装xmppStream流
    [self setupStream];
    
    // 对数据库的操作
    // 1. 获得路径
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"db.sqlite"];
    NSLog(@"%@",path);
    // 2. 创建数据库对象
    self.db = [FMDatabase databaseWithPath:path];
    BOOL result = [self.db open];
    if (!result) {
        [ZLFUtil alertWithMessage:@"不好意思，打开数据库失败!"];
    }
    NSString * sql = @"create table if not exists messages(username text,time text,message text,flag int,type int)";
    result = [self.db executeUpdate:sql];
    if (!result) {
        [ZLFUtil alertWithMessage:@"不好意思，创建表格失败!"];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark - /********** 与服务器对接 **********/
// 链接服务器
- (BOOL)connectWithUsername:(NSString *)uname password:(NSString *)upass
{
    // 判断是否已经连接
    if (![xmppStream isDisconnected]) {
        return YES;
    }
    // 配置一个JID  就是 用户名@域名
    NSString * myJID = [NSString stringWithFormat:@"%@@115.159.1.248",uname ];
    // 对JID和密码进行简单的验证
    if (myJID == nil || upass == nil) {
        return NO;
    }
    // 设置流里的JID 为我们的JID
    [xmppStream setMyJID:[XMPPJID jidWithString:myJID]];
    // 保存密码
    self.password = upass;
    self.username = uname;
    NSError * error;
    
    // 链接服务器
    if (![xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
        [ZLFUtil alertWithMessage:@"连接服务器失败!"];
        return NO;
    }
    [SVProgressHUD showWithStatus:@"正在连接服务器..." maskType:SVProgressHUDMaskTypeBlack];
    return YES;
}
// 连接服务器成功
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSError * error;
    if (self.regist == NO) {
        [SVProgressHUD setStatus:@"正在登录..."];
        // 验证用户的信息
        if (![xmppStream authenticateWithPassword:self.password error:&error]) {
            [ZLFUtil alertWithMessage:@"无法进行登陆，请稍候再试!"];
        }
    }else{
        [SVProgressHUD setStatus:@"正在注册..."];
        if (![xmppStream registerWithPassword:self.password error:&error]) {
            [ZLFUtil alertWithMessage:@"无法进行注册，请稍后再试!"];
        }
    }
}
// 与服务器断开连接
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    [SVProgressHUD dismiss];
    if (error) {// 出现异常
        [ZLFUtil alertWithMessage:@"不好意思,已经断开与服务器连接!"];
    }
}
#pragma mark - /********** 用户验证 **********/
//用户验证失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    NSLog(@"用户验证失败!%@",error);
    [SVProgressHUD dismiss];
    //断开数据流，不然数据流不能继续验证
    [xmppStream disconnect];
//    [ZLFUtil alertWithMessage:@"登陆失败，请检查用户名或密码!"];
    [ZLFUtil alertWithTitle:@"登陆失败，请检查用户名或密码!" targe:self.login];
}
//用户验证成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"用户验证成功!");
    [SVProgressHUD dismiss];
    //发在线信息(可以接受到信息)
    [self goOnline];
    
    if (self.login.select){
        [[NSUserDefaults standardUserDefaults] setObject:[self.username trimingWithString] forKey:@"USERNAME"];
        [[NSUserDefaults standardUserDefaults] setObject:[self.password trimingWithString] forKey:@"PASSWORD"];
    }else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USERNAME"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"PASSWORD"];
    }
    //显示聊天主界面
    [self.login showMainView];
}
#pragma mark - /********** 用户注册 **********/
//注册失败事件
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    //NSLog(@"register is error(%@)!",error);
    [SVProgressHUD dismiss];
    [xmppStream disconnect];
//    [ZLFUtil alertWithMessage:@"当前用户已存在，请更换用户名!"];
    [ZLFUtil alertWithTitle:@"当前用户已存在，请更换用户名!" targe:self.login];
}
//注册成功事件
-(void)xmppStreamDidRegister:(XMPPStream *)sender
{
    [SVProgressHUD dismiss];
//    [ZLFUtil alertWithMessage:@"恭喜你，注册成功!"];
    [ZLFUtil alertWithTitle:@"恭喜你，注册成功!" targe:self.login];
    [self disconnect];
    //关闭当前视图
    [self.login.registerController dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark - /********** 给服务器发信息 **********/
// 发送在线的信息
- (void)goOnline
{
    //创建一个在线对象
    XMPPPresence * presence=[XMPPPresence presence];
    //发在线信息
    [[self xmppStream]sendElement:presence];
}
//发送离线消息给服务器
- (void)goOffline
{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [[self xmppStream] sendElement:presence];
}
//断开与服务器的连接
-(void)disconnect
{
    //发离线消息
    [self goOffline];
    //与服务器断开
    [xmppStream disconnect];
}
#pragma mark - /********** 对数据库操作 **********/
//发送消息给用户
-(void)sendMessage:(NSString *)_msg to:(NSString *)_to
{
    //创建一个xml
    //根元素
    NSXMLElement * message=[NSXMLElement elementWithName:@"message"];
    //定义跟元素 增加属性
    [message addAttributeWithName:@"type" stringValue:@"chat"];
    [message addAttributeWithName:@"to" stringValue:[NSString stringWithFormat:@"%@@115.159.1.248",_to]];
    [message addAttributeWithName:@"from" stringValue:[NSString stringWithFormat:@"%@@115.159.1.248",self.username]];
    NSXMLElement * body=[NSXMLElement elementWithName:@"body"];
    [body setStringValue:_msg];
    [message addChild:body];
    [xmppStream sendElement:message];
    NSLog(@"%@",message);
    
}
//获得离线消息的时间
-(NSDate *)getDelayStampTime:(XMPPMessage *)message
{
    //获得xml中的delay标签
    XMPPElement * delay=(XMPPElement *)[message elementForName:@"delay"];
    if (delay)
    {
        //获得时间戳
        NSString * timeString=[[(XMPPElement *)[message elementForName:@"delay"]attributeForName:@"stamp"]stringValue];
        //时间格式化对象
        NSDateFormatter * dateFormatter=[[NSDateFormatter alloc] init];
        //设定时间的具体格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm"];
        //拆分到数组
        NSArray * arr=[timeString componentsSeparatedByString:@"T"];
        //日期
        NSString * dateStr=[arr objectAtIndex:0];
        NSString * timeStr=[[[arr objectAtIndex:1] componentsSeparatedByString:@"."] objectAtIndex:0];
        //构建一个日期对象 这个对象里的时区是0
        NSDate * localDate=[dateFormatter dateFromString:[NSString stringWithFormat:@"%@T%@+0000",dateStr,timeStr]];
        return localDate;
    }
    else
    {
        return nil;
    }
}
//接收消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSLog( @"来消息了!(%@)",message);
    NSDate * date=[self getDelayStampTime:message];
    if (date==nil)
    {
        date=[NSDate date];
    }
    //时间格式化对象
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    //设定时间的具体格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //消息的时间
    NSString * strDate=[dateFormatter stringFromDate:date];
    NSLog(@"消息的时间是:%@",strDate);
    XMPPJID * jid=[message from];
    //消息的内容
    NSString * body=[[message elementForName:@"body"] stringValue];
    //用户名
    NSString * uname=[jid user];
    NSLog(@"用户名称:%@",uname);
    //body=[NSString stringWithFormat:@"(%@)%@:%@",strDate,[jid user],body];
    NSLog(@"提取后的消息内容:%@",body);
    
    BOOL b=[self.db executeUpdate:@"insert into messages values(?,?,?,?,?)",uname,strDate,body,@0,@1];
    if (!b)
    {
        [ZLFUtil alertWithMessage:@"保存消息失败!"];
    }
    
    //创建一个通知
    NSNotification * note=[[NSNotification alloc]initWithName:@"COMEMSG" object:[NSString stringWithFormat:@"%@,%@,%@",uname,strDate,body] userInfo:nil];
    //发通知 向通知中心传送数据
    [[NSNotificationCenter defaultCenter] postNotification:note];
    
    ZLFMessageViewController * messageController = [ZLFUtil messageViewController];
    [messageController showNumber];
}






- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.zhanglf.chatSoftware" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"chatSoftware" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"chatSoftware.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
