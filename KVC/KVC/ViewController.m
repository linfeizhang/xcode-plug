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
    
    NSDictionary * dict=[NSDictionary dictionaryWithObjectsAndKeys:@"张三",@"name", nil];
    ZLFPerson * person=[[ZLFPerson alloc]initWithDict:dict];
    NSLog(@"%@",person.name);
    NSLog(@"%@",[[ZLFPerson messageWithDict:dict] name]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end