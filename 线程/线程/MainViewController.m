//
//  MainViewController.m
//  线程
//
//  Created by zhanglf on 15/12/20.
//  Copyright © 2015年 zhanglf. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor greenColor];
    //创建一个拖拽手势识别器
    UIPanGestureRecognizer * pgr=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(drag:)];
    //加到要用这个手势识别的视图上
    [self.view addGestureRecognizer:pgr];
    UIButton * btn=[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 40, 40)];
    btn.backgroundColor=[UIColor redColor];
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)action:(id)sender
{
    ViewController * view=[[ViewController alloc]init];
    [self presentViewController:view animated:NO completion:^{
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:3];
//        self.view.alpha=0;
//        [UIView commitAnimations];
    }];
}
-(void)drag:(UIPanGestureRecognizer *)sender
{
    CGPoint piont=[sender translationInView:self.view];
    sender.view.center=CGPointMake(sender.view.center.x+piont.x, sender.view.center.y+piont.y);
    [sender setTranslation:CGPointZero inView:self.view];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
