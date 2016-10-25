//
//  ZLFPerson.h
//  KVC
//
//  Created by zhanglf on 15/12/20.
//  Copyright © 2015年 zhanglf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLFPerson : NSObject
@property (strong,nonatomic) NSString * name;
@property (assign,nonatomic) int age;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)messageWithDict:(NSDictionary *)dict;
@end
