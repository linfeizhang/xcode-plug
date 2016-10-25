//
//  ZLFMssageFrame.h
//  chatSoftware
//
//  Created by zhanglf on 16/4/1.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#define textFont [UIFont systemFontOfSize:14]

@class ZLFMessage;
@interface ZLFMssageFrame : NSObject

@property (nonatomic, strong) ZLFMessage * message;

@property (nonatomic,assign,readonly) CGRect iconFrame;
@property (nonatomic,assign,readonly) CGRect timeFrame;
@property (nonatomic,assign,readonly) CGRect textFrame;
@property (nonatomic,assign,readonly) CGFloat rowHeight;
@end
