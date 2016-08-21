//
//  ZLFDetailMessageViewController.m
//  chatSoftware
//
//  Created by zhanglf on 16/3/31.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ZLFDetailMessageViewController.h"
#import "ZLFMessage.h"
#import "ZLFMssageFrame.h"
#import "ZLFDetailTableViewCell.h"
@interface ZLFDetailMessageViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * messageFrames;
@property (nonatomic,weak) UITextField * textFeild;
@end
@implementation ZLFDetailMessageViewController
#pragma mark - /********** 懒加载 **********/
- (NSMutableArray *)messageFrames{
    if (!_messageFrames) {
        _messageFrames = [NSMutableArray array];
    }
    
    return _messageFrames;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = self.username;
    NSLog(@"%g",self.navigationController.navigationBar.frame.size.height);
    // 监听键盘的弹出事件
    // 1. 创建一个NSNotificationCenter对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    // 2. 监听键盘的弹出通知
    [center addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(comeMsg:) name:@"COMEMSG" object:nil];
    // 创建UI
    [self createUI];
    // 加载数据
    [self loadMesaage];
}
#pragma mark - /********** 键盘监听事件 **********/
-(void)keyboardWillChangeFrame:(NSNotification *)noteInfo
{
    //    NSLog(@"通知名称：%@",noteInfo.name);
    //
    //    NSLog(@"通知的发布者：%@",noteInfo.object);
    //
    //    NSLog(@"通知的具体内容：%@",noteInfo.userInfo);
    // 1. 获取当键盘显示完毕或者隐藏完毕后的Y值
    CGRect rectEnd = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat keyboardY = rectEnd.origin.y;
    
    // 用键盘的Y值减去屏幕的高度计算出平移的值
    // 1.如果是键盘弹出事件，那么计算出的值就是负的键盘的高度
    // 2.如果是键盘的隐藏事件，那么计算出的值就是零，因为键盘在隐藏以后，键盘的Y值就等于屏幕的高度
    CGFloat transformValue = keyboardY - self.view.frame.size.height;
    
    [UIView animateWithDuration:2.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformValue);
    }];
    
    
    // 让UITableView的最后一行滚动到最上面
    NSIndexPath * lastRowIndexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastRowIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
#pragma mark - /********** 监听消息 **********/
-(void)comeMsg:(id)sender
{
    //NSLog(@"-----%@-----",[sender object]);
    NSString * str = [sender object];
    NSArray * arrary = [str componentsSeparatedByString:@","];
    NSString * username = arrary[0];
    NSString * time = arrary[1];
    NSString * text = arrary[2];
    if ([username isEqualToString:self.username]) {
        ZLFMessage * msg = [[ZLFMessage alloc]init];
        msg.username = username;
        msg.time = time;
        msg.text = text;
        msg.type = ZLFMessageTypeOther;
        msg.flag = 1;
        ZLFMessage * lastMessage = (ZLFMessage *)[[self.messageFrames lastObject] message];
        if ([msg.time isEqualToString:lastMessage.time]) {
            msg.hideTime = YES;
        }
        ZLFMssageFrame * messageFrame = [[ZLFMssageFrame alloc]init];
        messageFrame.message = msg;
        [self.messageFrames addObject:messageFrame];
        AppDelegate * app=(AppDelegate *)[UIApplication sharedApplication].delegate;
        FMDatabase * db=app.db;
        [db executeUpdate:@"update messages set flag=1 where username=? and time=? and message=?",username,time,text];
        [self.tableView reloadData];
        NSIndexPath * lastRowIndexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:lastRowIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}
#pragma mark - /********** 加载数据 **********/
- (void)loadMesaage
{
    [self.messageFrames removeAllObjects];
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    FMDatabase * db = app.db;
    NSString * sql = @"select * from messages where username=?";
    FMResultSet * result = [db executeQuery:sql,self.username];
    while ([result next]) {
        ZLFMessage * model = [[ZLFMessage alloc]init];
        model.username = [result stringForColumnIndex:0];
        model.time = [result stringForColumnIndex:1];
        model.text = [result stringForColumnIndex:2];
        model.type = [result intForColumnIndex:4];
        ZLFMessage * lastModel = (ZLFMessage *)[[self.messageFrames lastObject] message];
        if ([model.time isEqualToString:lastModel.time]) {
            model.hideTime = YES;
        }
        ZLFMssageFrame * messageFrame = [[ZLFMssageFrame alloc]init];
        messageFrame.message = model;
        [self.messageFrames addObject:messageFrame];
        [db executeUpdate:@"update messages set flag = 1 where username =?",self.username];
    }
    [result close];
}
#pragma mark - /********** 创建UI **********/
- (void)createUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-44) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView.backgroundColor = [UIColor redColor];
    // 设置UITableView的背景色
    self.tableView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    
    // 设置UITableView不允许被选中
    self.tableView.allowsSelection = NO;
    [self.view addSubview:self.tableView];
    UIBarButtonItem * item =[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = item;
    [self creatTextFeild];
}
// 创建TextFeil
- (void)creatTextFeild
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIButton * yuyin = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [yuyin setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
    [yuyin setImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateHighlighted];
    [view addSubview:yuyin];
    UITextField * textFeild = [[UITextField alloc]initWithFrame:CGRectMake(44, 0, SCREEN_WIDTH - 44*3, 44)];
    self.textFeild = textFeild;
    self.textFeild.delegate = self;
    [view addSubview:textFeild];
    UIButton * smallButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textFeild.frame), 0, 44, 44)];
    [smallButton setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
    [smallButton setImage:[UIImage imageNamed:@"chat_bottom_smile_press"] forState:UIControlStateHighlighted];
    [view addSubview:smallButton];
    UIButton * addButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(smallButton.frame), 0, 44, 44)];
    [addButton setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
    [addButton setImage:[UIImage imageNamed:@"chat_bottom_up_press"] forState:UIControlStateHighlighted];
    [view addSubview:addButton];
}
#pragma mark - /********** TextFeild的代理方法 **********/
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    NSString * text = textField.text;
    text=[text trimingWithString];
    if ([text isEqualToString:@""])
    {
        [ZLFUtil alertWithTitle:@"消息不能为空!" targe:self];
    }
    else
    {
        AppDelegate * app=(AppDelegate *)[UIApplication sharedApplication].delegate;
        //发送消息
        [app sendMessage:text to:self.username];
        //保存消息
        FMDatabase * db=[app db];
        NSString * sql=@"insert into messages values(?,?,?,?,?)";
        NSDate * date=[NSDate date];
        //时间格式化对象
        NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
        //设定时间的具体格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        //消息时间
        NSString * strDate=[dateFormatter stringFromDate:date];
        
        [db executeUpdate:sql,self.username,strDate,text,@1,@1];
        ZLFMessage * message=[[ZLFMessage alloc]init];
        message.username=self.username;
        message.time=strDate;
        message.text=text;
        message.type=ZLFMessageTypeMe;
        ZLFMessage * lastMessage = (ZLFMessage *)[[self.messageFrames lastObject] message];
        if ([message.time isEqualToString:lastMessage.time]) {
            message.hideTime = YES;
        }
        ZLFMssageFrame * messageFrame = [[ZLFMssageFrame alloc]init];
        messageFrame.message = message;
        [self.messageFrames addObject:messageFrame];
        [self.tableView reloadData];
        
        NSIndexPath * lastRowIndexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:lastRowIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    self.textFeild.text=@"";
    [self.textFeild becomeFirstResponder];
    return YES;
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - /********** tableView的数据源方法 **********/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageFrames.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZLFMssageFrame * messageFrame = self.messageFrames[indexPath.row];
    return messageFrame.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZLFMssageFrame * modelFrame = self.messageFrames[indexPath.row];
    ZLFDetailTableViewCell * cell = [ZLFDetailTableViewCell messageCellWithTableView:tableView];
    cell.messageFrame = modelFrame;
    return cell;
}





- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
