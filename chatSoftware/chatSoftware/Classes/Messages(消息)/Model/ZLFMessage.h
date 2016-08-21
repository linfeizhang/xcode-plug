//
//  ZLFMessage.h
//  chatSoftware
//
//  Created by zhanglf on 16/3/28.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ZLFMessageTypeMe = 0,     //表示自己
    ZLFMessageTypeOther = 1   //表示对方
}ZLFMessageType;
@interface ZLFMessage : NSObject
@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * time;
@property (nonatomic, copy) NSString * text;
@property (nonatomic, assign) int flag;
@property (nonatomic, assign) ZLFMessageType type;
@property (nonatomic, assign) BOOL hideTime;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (ZLFMessage *)messageWithDict:(NSDictionary *)dict;

@end
