//
//  NSString+triming.m
//  chatSoftware
//
//  Created by zhanglf on 16/3/25.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "NSString+triming.h"

@implementation NSString (triming)
- (NSString *)trimingWithString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
@end
