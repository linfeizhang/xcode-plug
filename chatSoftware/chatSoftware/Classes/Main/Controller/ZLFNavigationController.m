//
//  ZLFNavigationController.m
//  chatSoftware
//
//  Created by zhanglf on 16/3/26.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ZLFNavigationController.h"

@implementation ZLFNavigationController
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, 20)];
    view.backgroundColor = [UIColor blackColor];
    [self.navigationBar addSubview:view];
    self.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationBar.alpha = 0.8;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
