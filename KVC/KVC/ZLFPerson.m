//
//  ZLFPerson.m
//  KVC
//
//  Created by zhanglf on 15/12/20.
//  Copyright © 2015年 zhanglf. All rights reserved.
//

#import "ZLFPerson.h"

@implementation ZLFPerson
//+(ZLFPerson *)initWithDictionary:(NSDictionary *)dict
//{
//    ZLFPerson * per=[[ZLFPerson alloc]init];
//    per.name=dict[@"name"];
//    per.age=[dict[@"age"] intValue];
//    return per;
//
//}
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)messageWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}





@end
