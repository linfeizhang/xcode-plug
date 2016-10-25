//
//  ZLFMessage.m
//  chatSoftware
//
//  Created by zhanglf on 16/3/28.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ZLFMessage.h"

@implementation ZLFMessage
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (ZLFMessage *)messageWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
