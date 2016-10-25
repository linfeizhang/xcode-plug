//
//  ViewController.m
//  post传参数
//
//  Created by zhanglf on 15/12/29.
//  Copyright © 2015年 zhanglf. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
@interface ViewController ()
- (IBAction)TapBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL * url=[[NSURL alloc]initWithString:@"http://115.159.1.248:56666/xinwen/getsearchs.php"];
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"post"];
    NSString  * str=@"content=1";
    [request setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSession * session=[NSURLSession sharedSession];
    NSURLSessionDataTask * task=[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    [task resume];
    void (^sum)(int)=^(int n){
        int m=0;
        for(int i=1;i<=n;i++){
            if(i%2==0){
                m+=i;
            }
        }
        NSLog(@"m=%d",m);
    };
    sum(100);
    int a=1;
    int b=a;
    printf("b=%d,a=%d",b,++a);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)TapBtn {
    NSString * dataFilePath = [self readyDatabase:@"db.sqlite"];
    sqlite3 * database;
    if (sqlite3_open([dataFilePath UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    NSString * query = @"select name,age from student";
    sqlite3_stmt * statement;
    int result = (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil));
    if (result == SQLITE_OK){
        while (sqlite3_step(statement)==SQLITE_ROW) {
            char * str = (char *)sqlite3_column_text(statement, 0);
            int age = sqlite3_column_int(statement, 1);
            NSString * name = [[NSString alloc]initWithUTF8String:str];
            NSLog(@"name = %@---age = %d",name,age);
        }
    }
    
}
-(NSString *)readyDatabase:(NSString *)dbName{
    BOOL success;
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSError * error;
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * writableDBPath = [documentsDirectory stringByAppendingPathComponent:dbName];
    NSLog(@"%@",writableDBPath);
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (!success) {
        NSString * defaultDBPath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:dbName];
        NSLog(@"%@",defaultDBPath);
        success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message'%@'.", [error localizedDescription]);
        }
    }
    return writableDBPath;
}
















@end
