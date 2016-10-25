//
//  ZLFDetailTableViewCell.m
//  chatSoftware
//
//  Created by zhanglf on 16/4/1.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ZLFDetailTableViewCell.h"
#import "ZLFMessage.h"
#import "ZLFMssageFrame.h"
@interface ZLFDetailTableViewCell ()

@property (nonatomic, weak) UILabel * lblTime;
@property (nonatomic, weak) UIImageView * imgViewIcon;
@property (nonatomic, weak) UIButton * btnText;
@end
@implementation ZLFDetailTableViewCell


#pragma mark - /********** 重写initWithStyle方法 **********/
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建子控件
        
        // 显示时间的label
        UILabel * lblTime = [[UILabel alloc]init];
        //lblTime.backgroundColor = [UIColor redColor];
        // 设置文字大小
        lblTime.font = [UIFont systemFontOfSize:12];
        // 设置文字居中
        lblTime.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lblTime];
        self.lblTime = lblTime;
        
        
        // 显示头像的UIImageView
        UIImageView * imgViewIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:imgViewIcon];
        self.imgViewIcon = imgViewIcon;
        
        
        // 显示正文的按钮
        UIButton * btnText = [[UIButton alloc]init];
        //btnText.backgroundColor = [UIColor greenColor];
        //btnText.titleLabel.backgroundColor = [UIColor yellowColor];
        // 设置正文的字体大小
        btnText.titleLabel.font = textFont;
        // 修改按钮的正文文字颜色
        [btnText setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        // 设置按钮中的label的文字可以换行
        btnText.titleLabel.numberOfLines = 0;
        
        // 设置按钮的内边距
        btnText.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
        
        [self.contentView addSubview:btnText];
        self.btnText = btnText;
    }
    
    // 设置单元格的背景颜色为无色
    self.backgroundColor = [UIColor clearColor];
    return self;
}

#pragma mark - /********** 重写frame 模型的set 方法 **********/
-(void)setMessageFrame:(ZLFMssageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    
    // 获取数据模型
    ZLFMessage * message = messageFrame.message;
    
    // 分别设置每个子控件的数据和frame
    
    // 设置“时间Label”的数据和frame
    self.lblTime.text = message.time;
    self.lblTime.frame = messageFrame.timeFrame;
    self.lblTime.hidden = message.hideTime;
    
    
    
    // 设置 头像
    //根据消息类型判断应该使用哪张图片
    NSString * iconImg = message.type == ZLFMessageTypeMe ?@"me" :@"other";
    self.imgViewIcon.image = [UIImage imageNamed:iconImg];
    self.imgViewIcon.frame = messageFrame.iconFrame;
    
    
    // 设置消息正文
    [self.btnText setTitle:message.text forState:UIControlStateNormal];
    self.btnText.frame = messageFrame.textFrame;
    
    
    // 设置正文的背景图
    NSString * nor,* highlighted;
    if (message.type == ZLFMessageTypeMe) {
        // 自己发的消息
        nor = @"chat_send_nor";
        highlighted = @"chat_send_press_pic";
        
        // 设置正文的文字颜色为白色
        [self.btnText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        // 对方发的消息
        nor = @"chat_recive_nor";
        highlighted = @"chat_recive_press_pic";
        
        // 设置正文的文字颜色为黑色
        [self.btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    // 加载图片
    UIImage * imgNor = [UIImage imageNamed:nor];
    UIImage * imgHighlighted = [UIImage imageNamed:highlighted];
    
    // 用平铺的方式拉伸图片
    imgNor = [imgNor stretchableImageWithLeftCapWidth:imgNor.size.width* 0.5 topCapHeight:imgNor.size.height * 0.5];
    imgHighlighted = [imgHighlighted stretchableImageWithLeftCapWidth:imgHighlighted.size.width* 0.5 topCapHeight:imgHighlighted.size.height * 0.5];
    
    // 设置背景图
    [self.btnText setBackgroundImage:imgNor forState:UIControlStateNormal];
    [self.btnText setBackgroundImage:imgHighlighted forState:UIControlStateHighlighted];
    
}



+(instancetype)messageCellWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"message_cell";
    ZLFDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZLFDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
@end
