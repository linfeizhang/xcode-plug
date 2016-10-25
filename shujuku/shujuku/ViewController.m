//
//  ViewController.m
//  shujuku
//
//  Created by zhanglf on 15/12/9.
//  Copyright (c) 2015年 zhanglf. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * f=[[UIButton alloc]initWithFrame:CGRectMake(40, 44, 55, 44)];
    [f addTarget:self action:@selector(nn) forControlEvents:UIControlEventTouchUpInside];
    f.backgroundColor=[UIColor redColor];
    [self.view addSubview:f];
    
}
-(void)nn
{
    NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * path=[paths objectAtIndex:0];
    path=[path stringByAppendingPathComponent:@"mydb.sqlite"];
    NSLog(@"%@",path);
    sqlite3 * db;
    int result=sqlite3_open([path UTF8String], &db);
    if (result!=SQLITE_OK) {
        NSLog( @"打开数据库失败!");
    }
    
    char * sql="create table if not exists t_student(name text,age integer)";
    char * error;
    result=sqlite3_exec(db, sql, NULL, NULL, &error);
    if (result!=SQLITE_OK) {
        NSLog(@"创建表格失败!");
    }
    sql="create table if not exists t_new(name text,age integer)";
    result=sqlite3_exec(db, sql, NULL, NULL, &error);
    if (result!=SQLITE_OK) {
        NSLog(@"创建表格失败!");
    }
    
    sql="insert into t_student(name,age) values('张三',22)";
    result=sqlite3_exec(db, sql, NULL, NULL, NULL);
    if (result!=SQLITE_OK) {
        NSLog(@"添加失败!");
    }
    sql="insert into t_student(name,age) values(?,?)";
    sqlite3_stmt * stmt;
    result=sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
    if (result==SQLITE_OK) {
        //绑定姓名
        result=sqlite3_bind_text(stmt, 1, "沃;;;;", -1, NULL);
        if (result!=SQLITE_OK) {
            NSLog(@"绑定失败1");
        }
        //绑定年龄
        result=sqlite3_bind_int(stmt, 2, 11);
        if (result!=SQLITE_OK) {
            NSLog(@"绑定失败2");
        }
        
        result=sqlite3_step(stmt);
        if (result!=SQLITE_DONE) {
            NSLog(@"添加失败");
        }
    }
    else {
        NSLog(@"预处理失败！");
    }
    sqlite3_finalize(stmt);
    /*
    sql="Alter Table t_student add column id integer not null ";
    result=sqlite3_exec(db, sql, NULL, NULL, NULL);
    if (result!=SQLITE_OK) {
        NSLog(@"修改失败失败!");
    }
    //    sql="drop table t_student  Id";
    //    result=sqlite3_exec(db, sql, NULL, NULL, &error);
    //    if (result!=SQLITE_OK) {
    //        NSLog(@"失败!%s",error);
    //    }
    
    //    sql="Delete from t_student Where ID Not In (Select MIN(ID) From t_student Group by name )";
    //    result=sqlite3_exec(db, sql, NULL, NULL, &error);
    //        if (result!=SQLITE_OK) {
    //            NSLog(@"失败!%s",error);
    //        }
     */
    sqlite3_close(db);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
