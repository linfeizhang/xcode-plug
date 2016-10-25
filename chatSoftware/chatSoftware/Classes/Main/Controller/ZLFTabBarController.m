//
//  ZLFTabBarController.m
//  chatSoftware
//
//  Created by zhanglf on 16/3/26.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ZLFTabBarController.h"
#import "ZLFNavigationController.h"
#import "ZLFMessageViewController.h"
#import "ZLFFriendViewController.h"
#import "ZLFFoundViewController.h"
#import "ZLFSettingViewController.h"

@implementation ZLFTabBarController
- (void)viewDidLoad{
    [super viewDidLoad];
    ZLFMessageViewController * messageController = [[ZLFMessageViewController alloc]init];
    [self addChildViewController:messageController title:@"消息" imageName:@"tab1"];
    [ZLFUtil setMessageViewController:messageController];
    
    ZLFFriendViewController * friendController = [[ZLFFriendViewController alloc]init];
    [self addChildViewController:friendController title:@"好友" imageName:@"tab2"];
    ZLFFoundViewController * foundController = [[ZLFFoundViewController alloc]init];
    [self addChildViewController:foundController title:@"发现" imageName:@"tab3"];
    ZLFSettingViewController * settingController = [[ZLFSettingViewController alloc]init];
    [self addChildViewController:settingController title:@"设置" imageName:@"tab4"];
    
}
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName
{
    childController.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    ZLFNavigationController * nav = [[ZLFNavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:nav];
}


















@end
