//
//  ZLFMessageViewController.m
//  chatSoftware
//
//  Created by zhanglf on 16/3/26.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ZLFMessageViewController.h"
#import "ZLFMessage.h"
#import "ZLFDetailMessageViewController.h"
#import "ZLFNavigationController.h"
@interface ZLFMessageViewController ()
@property (nonatomic, strong) NSMutableArray * messages;
@end
@implementation ZLFMessageViewController
#pragma mark - /********** 懒加载 **********/
- (NSMutableArray *)messages
{
    if (_messages == nil) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}
- (void)showNumber
{
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    FMDatabase * db = app.db;
    NSString * sql = @"select count(*) from messages where flag = 0 and type = 1";
    FMResultSet * result = [db executeQuery:sql];
    [result next];
    int num = [result intForColumnIndex:0];
    if (num > 0) {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",num];
    }else{
        self.tabBarItem.badgeValue = nil;
    }
    [result close];
    sql = @"select username from messages group by username";
    [self.messages removeAllObjects];
    result = [db executeQuery:sql];
    while ([result next]) {
        ZLFMessage * message = [[ZLFMessage alloc]init];
        message.username = [result stringForColumnIndex:0];
//        NSLog(@"username = %@",message.username);
        sql = @"select message from messages where username = ? order by time desc limit 0,1";
        FMResultSet * rs = [db executeQuery:sql,message.username];
        [rs next];
        message.time = [rs stringForColumnIndex:1];
        message.text = [rs stringForColumnIndex:2];
        [rs close];
        [self.messages addObject:message];
    }
    [result close];
//    NSLog(@"count = %lu",self.messages.count);
    [self.tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self showNumber];
}
- (void)viewDidLoad{
    [super viewDidLoad];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"message_cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor redColor];
    
    ZLFMessage * message = self.messages[indexPath.row];
    cell.textLabel.text = message.username;
    cell.detailTextLabel.text = message.text;
    cell.imageView.image = [UIImage imageNamed:@"16"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZLFDetailMessageViewController * detailMessageViewController = [[ZLFDetailMessageViewController alloc]init];
    ZLFMessage * message = self.messages[indexPath.row];
    detailMessageViewController.username = message.username;
    ZLFNavigationController * nav = [[ZLFNavigationController alloc]initWithRootViewController:detailMessageViewController];
    [self presentViewController:nav animated:YES completion:nil];
}













@end
