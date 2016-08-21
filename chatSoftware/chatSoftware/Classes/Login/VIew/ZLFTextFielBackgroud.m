//
//  ZLFTextFielBackgroud.m
//  chatSoftware
//
//  Created by zhanglf on 16/3/24.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ZLFTextFielBackgroud.h"

@implementation ZLFTextFielBackgroud


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置画笔的宽度
    CGContextSetLineWidth(context, 0.2);
    // 启动画笔
    CGContextBeginPath(context);
    // 将画笔移动到指定点
    CGContextMoveToPoint(context, 5, 50);
    // 开始画线到指定的点
    CGContextAddLineToPoint(context, self.frame.size.width - 10, 50);
    // 停止画笔
    CGContextClosePath(context);
    
    [[UIColor grayColor] setStroke];
    CGContextStrokePath(context);
    // 获取上下文
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    // 设置画笔的宽度
    CGContextSetLineWidth(context1, 0.2);
    // 启动画笔
    CGContextBeginPath(context1);
    // 将画笔移动到指定点
    CGContextMoveToPoint(context1, 5, 100);
    // 开始画线到指定的点
    CGContextAddLineToPoint(context1, self.frame.size.width - 10, 100);
    // 停止画笔
    CGContextClosePath(context1);
    
    [[UIColor grayColor] setStroke];
    CGContextStrokePath(context1);
    
    
}

@end
