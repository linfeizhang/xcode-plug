//
//  ViewController.m
//  ios9请求数据代理事件
//
//  Created by zhanglf on 16/3/15.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDataDelegate>
<<<<<<< HEAD
=======

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

>>>>>>> 355055e7e62ec917204ab1d9c862f61e92d9568c
@property (nonatomic, strong) NSMutableData * recvData1;
@property (nonatomic, strong) NSMutableData * recvData2;
@property (nonatomic, strong) NSURLSessionDataTask * task1;
@property (nonatomic, strong) NSURLSessionDataTask * task2;
@property (nonatomic, strong) NSMutableArray * arr1;
@property (nonatomic, strong) NSMutableArray * arr2;
@end

@implementation ViewController
//- (NSMutableData *)recvData1
//{
//    if (!_recvData1) {
//        _recvData1 = [NSMutableData data];
//    }
//    return _recvData1;
//}
//- (NSMutableData *)recvData2
//{
//    if (!_recvData2) {
//        _recvData2 = [NSMutableData data];
//    }
//    return _recvData2;
//}
- (NSMutableArray *)arr1
{
    if (!_arr1) {
        _arr1 = [NSMutableArray array];
    }
    return _arr1;
}
- (NSMutableArray *)arr2
{
    if (!_arr2) {
        _arr2 = [NSMutableArray array];
    }
    return _arr2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
<<<<<<< HEAD
    NSURL * url1 = [NSURL URLWithString:@"http://iappfree.candou.com:8080/free/applications/free?currency=rmb&page=1"];
    NSURL * url2 = [NSURL URLWithString:@"http://iappfree.candou.com:8080/free/applications/free?currency=rmb&page=2"];
=======
    NSURL * url1 = [NSURL URLWithString:@"http://c.inhand.com.cn:8888/api/file/5679E77AE4B0F9B083B7EC51?access_token=f9a9a290f70e24e7ac715a2f49863d41"];
>>>>>>> 355055e7e62ec917204ab1d9c862f61e92d9568c
    // 创建会话
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    _task1 = [session dataTaskWithURL:url1];
    [_task1 resume];
    
<<<<<<< HEAD
    _task2 = [session dataTaskWithURL:url2];
    [_task2 resume];
=======
    
>>>>>>> 355055e7e62ec917204ab1d9c862f61e92d9568c
}

#pragma mark - /********** NSURLSessionDataDeleget方法 **********/

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    _recvData1 = [[NSMutableData alloc]init];
<<<<<<< HEAD
    _recvData2 = [[NSMutableData alloc]init];
=======
>>>>>>> 355055e7e62ec917204ab1d9c862f61e92d9568c
    NSLog(@"回来数据了！");
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if ([dataTask isEqual:_task1]) {
<<<<<<< HEAD
        [_recvData1 appendData:data];
        NSLog(@"--1--接收数据了！");
    }
    if ([dataTask isEqual:_task2]) {
        [_recvData2 appendData:data];
        NSLog(@"--2--接收数据了！");
    }
    
=======
        
    }
    [_recvData1 appendData:data];
    NSLog(@"--1--接收数据了！");
>>>>>>> 355055e7e62ec917204ab1d9c862f61e92d9568c
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    
//    NSLog(@"完成！（%@\n---%@）", [[NSString alloc]initWithData:_recvData1 encoding:NSUTF8StringEncoding],error);
<<<<<<< HEAD
    NSDictionary * dictionary1 = [NSJSONSerialization JSONObjectWithData:_recvData1 options:NSJSONReadingMutableLeaves error:nil];
    for (NSDictionary * dict in dictionary1[@"applications"]) {
        NSLog(@"--1--name = %@",dict[@"name"]);
        [_arr1 addObject:dict[@"name"]];
    }
    
    NSDictionary * dictionary2 = [NSJSONSerialization JSONObjectWithData:_recvData2 options:NSJSONReadingMutableLeaves error:nil];
    for (NSDictionary * dict in dictionary2[@"applications"]) {
        NSLog(@"--2--name = %@",dict[@"name"]);
        [_arr2 addObject:dict[@"name"]];
    }
    NSLog(@"%ld----%ld",_arr1.count,_arr2.count);
=======
//    NSDictionary * dictionary1 = [NSJSONSerialization JSONObjectWithData:_recvData1 options:NSJSONReadingMutableLeaves error:nil];
//    for (NSDictionary * dict in dictionary1[@"applications"]) {
//        NSLog(@"--1--name = %@",dict[@"name"]);
//        [_arr1 addObject:dict[@"name"]];
//    }
//    
//    NSDictionary * dictionary2 = [NSJSONSerialization JSONObjectWithData:_recvData2 options:NSJSONReadingMutableLeaves error:nil];
//    for (NSDictionary * dict in dictionary2[@"applications"]) {
//        NSLog(@"--2--name = %@",dict[@"name"]);
//        [_arr2 addObject:dict[@"name"]];
//    }
//    NSLog(@"%ld----%ld",_arr1.count,_arr2.count);
    UIImage * image = [UIImage imageWithData:_recvData1];
    _imageView.image = image;
>>>>>>> 355055e7e62ec917204ab1d9c862f61e92d9568c
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    NSLog(@"%lld---%lld",bytesSent,totalBytesSent);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
