//
//  ZLFLoginViewController.h
//  chatSoftware
//
//  Created by zhanglf on 16/3/24.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLFRegisterViewController.h"
@interface ZLFLoginViewController : UIViewController
@property (nonatomic, strong) ZLFRegisterViewController * registerController;
@property (nonatomic, assign, getter=isSelect) BOOL select;

- (void)showMainView;
@end
