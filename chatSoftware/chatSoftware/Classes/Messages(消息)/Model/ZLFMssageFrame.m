//
//  ZLFMssageFrame.m
//  chatSoftware
//
//  Created by zhanglf on 16/4/1.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ZLFMssageFrame.h"
#import "ZLFMessage.h"

@implementation ZLFMssageFrame
- (void)setMessage:(ZLFMessage *)message
{
    _message = message;
    // 设置统一的间距
    CGFloat margin = 5;
    
    // 计算时间Label的frame
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeW = SCREEN_WIDTH;
    CGFloat timeH = 15;
    if (!_message.hideTime) {
        _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    }else{
        _timeFrame = CGRectMake(0, 0, 0, 0);
    }
    
    // 计算头像的frame
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    CGFloat iconX = message.type == ZLFMessageTypeMe ? SCREEN_WIDTH - margin - iconW : margin;
    CGFloat iconY = CGRectGetMaxY(_timeFrame);
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 计算消息正文的frame
    CGSize textSize = [message.text sizeOfTextWithMaxSize:CGSizeMake(200, MAXFLOAT) font:textFont];
    CGFloat textW = textSize.width + 40;
    CGFloat textH = textSize.height + 30;
    
    CGFloat textY = iconY;
    CGFloat textX = message.type == ZLFMessageTypeOther ? CGRectGetMaxX(_iconFrame) : SCREEN_WIDTH - margin - iconW - textW;
    _textFrame = CGRectMake(textX, textY, textW, textH);
    
    CGFloat maxY = MAX(CGRectGetMaxY(_iconFrame), CGRectGetMaxY(_textFrame));
    _rowHeight = maxY + margin;
   
    
    
    
}
@end
