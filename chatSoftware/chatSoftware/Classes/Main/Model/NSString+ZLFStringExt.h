//
//  NSString+ZLFStringExt.h
//  chatSoftware
//
//  Created by zhanglf on 16/4/1.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZLFStringExt)

- (CGSize)sizeOfTextWithMaxSize:(CGSize)size font:(UIFont *)font;
+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)size font:(UIFont *)font;
@end
