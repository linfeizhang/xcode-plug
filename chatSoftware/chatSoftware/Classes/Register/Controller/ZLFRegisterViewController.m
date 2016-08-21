//
//  ZLFRegisterViewController.m
//  chatSoftware
//
//  Created by zhanglf on 16/3/25.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ZLFRegisterViewController.h"
#import "ZLFTextFielBackgroud.h"

@interface ZLFRegisterViewController ()
@property (nonatomic, weak) ZLFTextFielBackgroud * backgroudView;
@property (nonatomic, weak) UITextField * usernameText;
@property (nonatomic, weak) UITextField * passwordText;
@property (nonatomic, weak) UITextField * passwordTextTwo;
@end
@implementation ZLFRegisterViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:51/255.0 green:204/255.0 blue:255/255.0 alpha:1];
    [self creatTextFieldBackgroud];
    [self creatTextField];
    [self creatRegisterButton];
}
- (void)creatTextFieldBackgroud
{
    ZLFTextFielBackgroud * backgroud = [[ZLFTextFielBackgroud alloc]initWithFrame:CGRectMake(25, 70, SCREEN_WIDTH - 50, 150)];
    self.backgroudView = backgroud;
    backgroud.layer.cornerRadius = 5.0;
    backgroud.backgroundColor = [UIColor whiteColor];
    backgroud.layer.masksToBounds = YES;
    [self.view addSubview:backgroud];
}
#pragma mark - /********** 创建子控件 **********/
// 创建输入框
- (void)creatTextField
{
    // 创建账号文本框
    UITextField * usernameText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 60, 50)];
    self.usernameText = usernameText;
    usernameText.placeholder = @"请输入账号或邮箱";
    usernameText.backgroundColor = [UIColor clearColor];
    [self.usernameText addTarget:self action:@selector(closekey) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.backgroudView addSubview:usernameText];
    
    // 创建密码文本框
    UITextField * passwordText = [[UITextField alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH - 60, 50)];
    self.passwordText = passwordText;
    passwordText.placeholder = @"请输入密码";
    passwordText.backgroundColor = [UIColor clearColor ];
    passwordText.secureTextEntry = YES;
    [self.passwordText addTarget:self action:@selector(closekey) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.backgroudView addSubview:passwordText];
    
    // 创建密码文本框
    UITextField * passwordTextTwo = [[UITextField alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH - 60, 50)];
    self.passwordTextTwo = passwordTextTwo;
    passwordTextTwo.placeholder = @"请重新输入密码";
    passwordTextTwo.backgroundColor = [UIColor clearColor ];
    passwordTextTwo.secureTextEntry = YES;
    [self.passwordTextTwo addTarget:self action:@selector(closekey) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.backgroudView addSubview:passwordTextTwo];
    
}
// 创建注册按钮和返回按钮
- (void)creatRegisterButton
{
    UIButton * registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    registerButton.frame = CGRectMake(25, 230, SCREEN_WIDTH - 50, 40);
    registerButton.layer.cornerRadius = 5.0;
    [registerButton setTitle:@"注   册" forState:UIControlStateNormal];
    registerButton.backgroundColor = [UIColor greenColor];
    [registerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    UIButton * backBtton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtton.frame = CGRectMake(25, 280, SCREEN_WIDTH - 50, 40);
    backBtton.layer.cornerRadius = 5.0;
    [backBtton setTitle:@"返   回" forState:UIControlStateNormal];
    backBtton.backgroundColor = [UIColor greenColor];
    [backBtton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [backBtton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtton];
}
#pragma mark - /********** 控件的方法 **********/
// 注册按钮点击事件
- (void)registerClick
{
    //数据进行验证
    //得到用户输入的账号和密码并剔除两端空格
    NSString * uName=[self.usernameText.text trimingWithString];
    NSString * uPass=[self.passwordText.text trimingWithString];
    NSString * uPassTwo = [self.passwordTextTwo.text trimingWithString];
    //判断账号是否为空
    if ([uName isEqualToString:@""])
    {
        [ZLFUtil alertWithTitle:@"账号不能为空!" targe:self];
        self.usernameText.text=@"";
        [self.usernameText becomeFirstResponder];
        return;
    }
    //判断密码是否为空
    if ([uPass isEqualToString:@""])
    {
        [ZLFUtil alertWithTitle:@"密码不能为空!" targe:self];
        self.passwordText.text=@"";
        [self.passwordText becomeFirstResponder];
        return;
    }
    // 判断两次输入的密码是否一致
    if (![uPass isEqualToString:uPassTwo]) {
        [ZLFUtil alertWithTitle:@"密码不一致，请重新输入!" targe:self];
        self.passwordTextTwo.text = @"";
        [self.passwordTextTwo becomeFirstResponder];
        return;
    }
    //判断网络
    Reachability * rech=[Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus status=[rech currentReachabilityStatus];
    if (status==NotReachable)
    {
        [ZLFUtil alertWithTitle:@"对不起，请检查网络是否连接!" targe:self];
        return;
    }
    //进行注册
    AppDelegate * app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    app.regist=YES;
    [app connectWithUsername:uName password:uPass];
}

- (void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closekey
{
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}







@end
