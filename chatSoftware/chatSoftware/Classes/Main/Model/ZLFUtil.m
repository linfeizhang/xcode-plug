//
//  ZLFUtil.m
//  chatSoftware
//
//  Created by zhanglf on 16/3/26.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ZLFUtil.h"
#import "ZLFMessageViewController.h"
static ZLFMessageViewController * messageViewController = nil;
@implementation ZLFUtil
+ (void)alertWithTitle:(NSString *)title targe:(UIViewController *)controller
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"友情提示!" message:title preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil]];
    [controller presentViewController:alert animated:YES completion:nil];
}

+(void)alertWithMessage:(NSString *)msg 
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:msg delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    [alert show];
}

+ (void)setMessageViewController:(ZLFMessageViewController *)_messageViewController
{
    messageViewController = _messageViewController;
}
+ (ZLFMessageViewController *)messageViewController
{
    return messageViewController;
}

@end
