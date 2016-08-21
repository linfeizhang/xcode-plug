//
//  ZLFStudent.h
//  归档
//
//  Created by zhanglf on 16/3/17.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLFStudent : NSObject<NSCoding>
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * sex;
@property (nonatomic,assign) int age;
- (instancetype)initStudentWithDict:(NSDictionary *)dict;
+ (instancetype)studentWithDict:(NSDictionary *)dict;
@end
