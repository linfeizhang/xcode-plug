//
//  ViewController.m
//  KVC
//
//  Created by zhanglf on 15/12/20.
//  Copyright © 2015年 zhanglf. All rights reserved.
//

#import "ViewController.h"
#import "ZLFPerson.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
<<<<<<< HEAD
    NSDictionary * dict=[NSDictionary dictionaryWithObjectsAndKeys:@"张三",@"name", nil];
    ZLFPerson * person=[[ZLFPerson alloc]initWithDict:dict];
    NSLog(@"%@",person.name);
    NSLog(@"%@",[[ZLFPerson messageWithDict:dict] name]);
=======
//    NSDictionary * dict=[NSDictionary dictionaryWithObjectsAndKeys:@"张三",@"name", nil];
//    ZLFPerson * person=[[ZLFPerson alloc]initWithDict:dict];
//    NSLog(@"%@",person.name);
//    NSLog(@"%@",[[ZLFPerson messageWithDict:dict] name]);
    NSString * str1 = @"111";
    NSString * str2 = @"222";
    NSArray * arr = @[@"1",@"",@"-1"];
    NSString * str = [arr componentsJoinedByString:@","];
    NSLog(@"%@",str);
    
>>>>>>> 355055e7e62ec917204ab1d9c862f61e92d9568c
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
