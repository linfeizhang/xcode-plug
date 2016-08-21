//
//  ZLFDetailTableViewCell.h
//  chatSoftware
//
//  Created by zhanglf on 16/4/1.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLFMssageFrame;
@interface ZLFDetailTableViewCell : UITableViewCell
@property (nonatomic, strong) ZLFMssageFrame * messageFrame;

+(instancetype)messageCellWithTableView:(UITableView *)tableView;
@end
