//
//  ZLFStudent.m
//  归档
//
//  Created by zhanglf on 16/3/17.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ZLFStudent.h"

@implementation ZLFStudent
@synthesize age,name,sex;
- (instancetype)initStudentWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)studentWithDict:(NSDictionary *)dict
{
    return [[self alloc]initStudentWithDict:dict];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSLog(@"zoule");
    [aCoder encodeObject:name forKey:@"NAME"];
    [aCoder encodeInt:age forKey:@"AGE"];
    [aCoder encodeObject:sex forKey:@"SEX"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.name = [aDecoder decodeObjectForKey:@"NAME"];
    self.age = [aDecoder decodeIntForKey:@"AGE"];
    self.sex = [aDecoder decodeObjectForKey:@"SEX"];
    return self;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@,age = %d,sex = %@",name,age,sex];
}
@end
