//
//  ViewController.h
//  音乐播放
//
//  Created by zhanglf on 15/12/19.
//  Copyright © 2015年 zhanglf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController : UIViewController<AVAudioPlayerDelegate>

{
    AVAudioPlayer * player;
    UIButton * playBtn;
    int current;
    UIImageView * imageView;
    UISlider * proSlider;
}
@property (strong,nonatomic) NSArray * images;
@property (strong,nonatomic) NSArray * songs;
@end

