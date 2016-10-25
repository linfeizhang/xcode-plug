//
//  ZLFUtil.h
//  chatSoftware
//
//  Created by zhanglf on 16/3/26.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZLFMessageViewController;
@interface ZLFUtil : NSObject

+ (void)alertWithTitle:(NSString *)title targe:(UIViewController *)controller;
+ (void)alertWithMessage:(NSString *)msg;

+ (void)setMessageViewController:(ZLFMessageViewController *)_messageViewController;
+ (ZLFMessageViewController *)messageViewController;
@end
