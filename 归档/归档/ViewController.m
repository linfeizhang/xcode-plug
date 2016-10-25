//
//  ViewController.m
//  归档
//
//  Created by zhanglf on 16/3/17.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ViewController.h"
#import "ZLFStudent.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *sexText;
@property (weak, nonatomic) IBOutlet UITextField *ageText;
@property (nonatomic, strong) NSMutableArray * students;
- (IBAction)addTap:(id)sender;
- (IBAction)foundTap:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * dict1 = @{@"age":@22,@"name":@"张三",@"sex":@"男"};
    NSDictionary * dict2 = @{@"age":@15,@"name":@"李四",@"sex":@"女"};
    ZLFStudent * student1 = [ZLFStudent studentWithDict:dict1];
//    student1.name = dict1[@"name"];
//    student1.age = [dict1[@"age"] intValue];
//    student1.sex = dict1[@"sex"];
    ZLFStudent * student2 = [ZLFStudent studentWithDict:dict2];
//    student2.name = dict2[@"name"];
//    student2.age = [dict2[@"age"] intValue];
//    student2.sex = dict2[@"sex"];
    self.students = [NSMutableArray arrayWithObjects:student1,student2, nil];
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingString:@"students.plist"];
    NSLog(@"path = %@",path);
//    BOOL success = [NSKeyedArchiver archiveRootObject:self.students toFile:path];
//    NSLog(@"%d",success);
//    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    for (ZLFStudent * student in array) {
//        NSLog(@"%@",student);
//    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTap:(id)sender {
//    NSDictionary * dict = @{@"age":self.ageText.text,@"name":self.nameText.text,@"sex":self.sexText.text};
//    [self.students addObject:dict];
    NSDictionary * dict1 = @{@"age":@15,@"name":@"李四",@"sex":@"女"};
    ZLFStudent * student1 = [ZLFStudent studentWithDict:dict1];
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingString:@"students.plist"];
    NSLog(@"path = %@",path);
    BOOL success = [NSKeyedArchiver archiveRootObject:student1 toFile:path];
    NSLog(@"%d",success);
}

- (IBAction)foundTap:(id)sender {
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingString:@"students.plist"];
    NSLog(@"path = %@",path);
    ZLFStudent * student = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    for (ZLFStudent * student in array) {
//        NSLog(@"%@",student);
//    }
      NSLog(@"%@",student);
}
@end
