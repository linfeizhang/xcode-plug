//
//  NSString+ZLFStringExt.m
//  chatSoftware
//
//  Created by zhanglf on 16/4/1.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "NSString+ZLFStringExt.h"

@implementation NSString (ZLFStringExt)
- (CGSize)sizeOfTextWithMaxSize:(CGSize)size font:(UIFont *)font
{
    NSDictionary * attrs = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)size font:(UIFont *)font
{
    return [text sizeOfTextWithMaxSize:size font:font];
}
@end
