//
//  ViewController.m
//  线程
//
//  Created by zhanglf on 15/12/17.
//  Copyright © 2015年 zhanglf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    NSThread * thread=[[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    
    [thread start];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"线程二");
    });
    NSTimer * timer=[NSTimer timerWithTimeInterval:2 target:self selector:@selector(run) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
    UIButton * btn=[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 40, 40)];
    btn.backgroundColor=[UIColor redColor];
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    UIPinchGestureRecognizer * pgr=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    [self.view addGestureRecognizer:pgr];
    
}
-(void)pinch:(UIPinchGestureRecognizer *)sender
{
    
    sender.view.transform=CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
    sender.scale=1;
//    sender.view.frame=CGRectMake(sender.view.frame.origin.x+(sender.view.frame.size.width-sender.view.frame.size.width*sender.scale),sender.view.frame.origin.y+(sender.view.frame.size.height-sender.view.frame.size.height*sender.scale),sender.view.frame.size.width*sender.scale, sender.view.frame.size.height*sender.scale);
    
}
-(void)action:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:^{
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:3];
//        self.view.alpha=0;
//        [UIView commitAnimations];
    }];
}
-(void)run
{
    
    NSLog(@"xianchengyi");
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
