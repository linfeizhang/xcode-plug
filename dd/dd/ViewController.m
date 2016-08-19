//
//  ViewController.m
//  dd
//
//  Created by inhandnetworks on 16/8/18.
//  Copyright © 2016年 inhandnetworks. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIWebView *_webView;
    UIWebView *_webView1;
    NSMutableArray * timeArr;
    NSMutableArray * valueArr;
    NSMutableArray * allArr;
    
}

@end
@implementation ViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    timeArr = [NSMutableArray array];
    valueArr = [NSMutableArray array];
    allArr = [NSMutableArray array];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
//    NSDate * dateTime = [dateformatter dateFromString:@"10:53"];
    NSDate * date = [NSDate date];
    for (int i = 0; i < 55; i ++) {
        NSDate *newDate = [date dateByAddingTimeInterval:-60*2*i];
        NSString * time = [dateformatter stringFromDate: newDate];
        [timeArr addObject:time];
        [valueArr addObject:[NSNumber numberWithInt:rand()%100 -50]];
        NSArray * aa = [NSArray arrayWithObjects:time,[NSNumber numberWithInt:rand()%100 -50], nil];
        [allArr addObject:aa];
    }
    
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width,260)];
    _webView.backgroundColor = [UIColor redColor];
    _webView.delegate = self;
    _webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:_webView];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"chart_bar" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    _webView1 = [[UIWebView alloc]initWithFrame:CGRectMake(0, 330, self.view.frame.size.width,260)];
    _webView1.backgroundColor = [UIColor redColor];
    _webView1.delegate = self;
    _webView1.scrollView.scrollEnabled = NO;
    [self.view addSubview:_webView1];
    
    [_webView1 loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
}

//webview加载完成后加载图表数据
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    if(webView == _webView){
//        NSLog(@"111111");
//        //传值标题
//        NSString * setTitle = @"setTitle('数量(吨)')";
//        [_webView stringByEvaluatingJavaScriptFromString:setTitle];
//        
//        NSData * jsonTime = [NSJSONSerialization dataWithJSONObject:timeArr options:NSJSONWritingPrettyPrinted error:nil];
//        NSString * timeString = [[NSString alloc]initWithData:jsonTime encoding:NSUTF8StringEncoding];
//        //传值X轴
//        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"setData(%@)",timeString]];
//        NSData * jsonValue = [NSJSONSerialization dataWithJSONObject:valueArr options:NSJSONWritingPrettyPrinted error:nil];
//        NSString * valueString = [[NSString alloc]initWithData:jsonValue encoding:NSUTF8StringEncoding];
//        //柱状图
//        NSString *setValueData = [NSString stringWithFormat:@"setValueData(%@)",valueString];
//        
//        //传值Y轴数据
//        [_webView stringByEvaluatingJavaScriptFromString:setValueData];
//    }else{
//        NSLog(@"2222");
//        //传值标题
//        NSString * setTitle = @"setTitle('数量(吨)')";
//        [_webView1 stringByEvaluatingJavaScriptFromString:setTitle];
//        
//        NSData * jsonTime = [NSJSONSerialization dataWithJSONObject:timeArr options:NSJSONWritingPrettyPrinted error:nil];
//        NSString * timeString = [[NSString alloc]initWithData:jsonTime encoding:NSUTF8StringEncoding];
//        //传值X轴
//        [_webView1 stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"setData(%@)",timeString]];
//        NSData * jsonValue = [NSJSONSerialization dataWithJSONObject:valueArr options:NSJSONWritingPrettyPrinted error:nil];
//        NSString * valueString = [[NSString alloc]initWithData:jsonValue encoding:NSUTF8StringEncoding];
//        //柱状图
//        NSString *setValueData = [NSString stringWithFormat:@"setValueData(%@)",valueString];
//        
//        //传值Y轴数据
//        [_webView1 stringByEvaluatingJavaScriptFromString:setValueData];
//    }
    
    
    
    
}

@end
