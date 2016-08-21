//
//  ViewController.m
//  音乐播放
//
//  Created by zhanglf on 15/12/19.
//  Copyright © 2015年 zhanglf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int width=self.view.frame.size.width;
    current=1;
    NSLog(@"width=%d---%f",width,self.view.frame.size.width);
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake((width-300)/2, 40, 300, 300)];
    
    imageView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:imageView];
    
    UIButton * beforeBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    beforeBtn.frame=CGRectMake((width-300)/2, 360, 80, 40);
    beforeBtn.layer.cornerRadius=10;
    
    beforeBtn.backgroundColor=[UIColor redColor];
    
    [beforeBtn setTitle:@"上一首" forState:UIControlStateNormal];
    [beforeBtn addTarget:self action:@selector(before) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beforeBtn];
    
    UIButton * nextBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextBtn.frame=CGRectMake((width/2+70), 360, 80, 40);
    nextBtn.layer.cornerRadius=10;
    nextBtn.backgroundColor=[UIColor redColor];
    [nextBtn setTitle:@"下一首" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    playBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    playBtn.frame=CGRectMake(width/2-40, 360, 80, 40);
    playBtn.layer.cornerRadius=10;
    playBtn.backgroundColor=[UIColor redColor];
    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(player:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    
    self.images=[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"a"],[UIImage imageNamed:@"b"],[UIImage imageNamed:@"c"], nil];
    NSString * path1=[[NSBundle mainBundle]pathForResource:@"a" ofType:@"mp3"];
    NSURL * url1=[NSURL fileURLWithPath:path1];
    NSString * path2=[[NSBundle mainBundle]pathForResource:@"b" ofType:@"mp3"];
    NSURL * url2=[NSURL fileURLWithPath:path2];
    NSString * path3=[[NSBundle mainBundle]pathForResource:@"c" ofType:@"mp3"];
    NSURL * url3=[NSURL fileURLWithPath:path3];
    self.songs=[[NSArray alloc]initWithObjects:url1,url2,url3, nil];
    [imageView setImage:self.images[current]];
    player=[[AVAudioPlayer alloc]initWithContentsOfURL:self.songs[current] error:nil];
    
    proSlider=[[UISlider alloc]initWithFrame:CGRectMake((width-300)/2, 420, 300, 40)];
    [proSlider addTarget:self action:@selector(proChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:proSlider];
    proSlider.minimumValue=0.0;
    proSlider.maximumValue=player.duration;
    
    player.delegate=self;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTime:) userInfo:nil repeats:YES];
    
}
-(void)onTime:(id)sender
{
    proSlider.value=player.currentTime;
}
-(void)proChange:(UISlider * )sender
{
    player.currentTime=proSlider.value;
}
-(void)player:(UIButton *)sender
{
    NSString * str=sender.titleLabel.text;
    if ([str isEqualToString:@"播放"]) {
        [player play];
        [playBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }
    else
    {
        [player stop];
        [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    }
}
-(void)before
{
    if (current==0) {
        return;
    }
    else
    {
        current--;
    }
    player=[[AVAudioPlayer alloc]initWithContentsOfURL:self.songs[current] error:nil];
    imageView.image=self.images[current];
    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
}
-(void)next
{
    if(current<self.songs.count-1)
    {
        current++;
    }
    else
    {
        return;
    }
    player=[[AVAudioPlayer alloc]initWithContentsOfURL:self.songs[current] error:nil];
    imageView.image=self.images[current];
    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
}
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
