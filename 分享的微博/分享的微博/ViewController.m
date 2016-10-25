//
//  ViewController.m
//  分享的微博
//
//  Created by zhanglf on 16/3/17.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ViewController.h"
#import "WeiboSDK.h"
@interface ViewController ()
- (IBAction)shareTap:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareTap:(id)sender {
    WBMessageObject * message = [WBMessageObject message];
    message.text = @"发送出去了!";
    WBSendMessageToWeiboRequest * request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    [WeiboSDK sendRequest:request];
}
@end
