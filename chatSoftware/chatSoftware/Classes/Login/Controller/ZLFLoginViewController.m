//
//  ZLFLoginViewController.m
//  chatSoftware
//
//  Created by zhanglf on 16/3/24.
//  Copyright © 2016年 zhanglf. All rights reserved.
//
#define BackgroudColor [UIColor colorWithRed:51/255.0 green:204/255.0 blue:255/255.0 alpha:1]

#import "ZLFLoginViewController.h"
#import "ZLFTextFielBackgroud.h"
#import "ZLFRegisterViewController.h"
#import "AppDelegate.h"
#import "ZLFTabBarController.h"
@interface ZLFLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) ZLFTextFielBackgroud * backgroudView;
@property (nonatomic, weak) UITextField * usernameText;
@property (nonatomic, weak) UITextField * passwordText;
@property (nonatomic, weak) UIButton * rememberButton;
@property (nonatomic, weak) UIButton * loginButton;


@end
@implementation ZLFLoginViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = BackgroudColor;
    [self creatTextFieldBackgroud];
    [self creatTextField];
    [self creatRememberButton];
    [self creatLoginButton];
    
    
}
#pragma mark - /********** 创建子控件 **********/
// 创建textField的背景
- (void)creatTextFieldBackgroud
{
    ZLFTextFielBackgroud * backgroud = [[ZLFTextFielBackgroud alloc]initWithFrame:CGRectMake(25, 70, SCREEN_WIDTH - 50, 100)];
    self.backgroudView = backgroud;
    backgroud.layer.cornerRadius = 5.0;
    backgroud.backgroundColor = [UIColor whiteColor];
    backgroud.layer.masksToBounds = YES;
    [self.view addSubview:backgroud];
}
// 创建输入框
- (void)creatTextField
{
    // 创建账号文本框
    UITextField * usernameText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 60, 50)];
    self.usernameText = usernameText;
    usernameText.placeholder = @"请输入账号或邮箱";
    usernameText.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"USERNAME"];
    usernameText.backgroundColor = [UIColor clearColor];
    [self.usernameText addTarget:self action:@selector(closekey) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.backgroudView addSubview:usernameText];
    
    // 创建密码文本框
    UITextField * passwordText = [[UITextField alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH - 60, 50)];
    self.passwordText = passwordText;
    passwordText.placeholder = @"请输入密码";
    passwordText.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"PASSWORD"];
    passwordText.backgroundColor = [UIColor clearColor ];
    passwordText.secureTextEntry = YES;
    [self.passwordText addTarget:self action:@selector(closekey) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.backgroudView addSubview:passwordText];
}
// 创建登陆按钮和注册按钮
- (void)creatLoginButton
{
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.loginButton = loginButton;
    loginButton.frame = CGRectMake(25, 210, SCREEN_WIDTH - 50, 40);
    loginButton.layer.cornerRadius = 5.0;
    [loginButton setTitle:@"登   陆" forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor greenColor];
    [loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton * regist = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    regist.frame = CGRectMake(25, 260, SCREEN_WIDTH - 50, 40);
    regist.layer.cornerRadius = 5.0;
    [regist setTitle:@"注   册" forState:UIControlStateNormal];
    regist.backgroundColor = [UIColor greenColor];
    [regist setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [regist addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regist];
}
// 创建记住账号按钮
- (void)creatRememberButton
{
    UIButton * rememberButton = [[UIButton alloc]initWithFrame:CGRectMake(35, 180, 20 , 20)];
    [rememberButton setImage:[UIImage imageNamed:@"discheck"] forState:UIControlStateNormal];
    [rememberButton addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
    self.rememberButton = rememberButton;
    [self.view addSubview:rememberButton];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(65, 180,90 , 20)];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = @"记住账号";
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
}
#pragma mark - /********** 子控件的方法 **********/
// 记住账号点击事件
- (void)Click:(UIButton *)sender
{
    self.select = !self.isSelect;
    NSLog(@"%d",self.select);
    if (self.select) {
        [sender setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"discheck"] forState:UIControlStateNormal];
    }
}
// 注册按钮点击事件
- (void)registClick
{
    self.registerController = [[ZLFRegisterViewController alloc]init];
    [self presentViewController:self.registerController animated:YES completion:nil];
}
// 登录按钮点击事件
- (void)loginClick
{
    NSString * username = [self.usernameText.text trimingWithString];
    NSString * password = [self.passwordText.text trimingWithString];
    if ([username isEqualToString:@""]) {
        [ZLFUtil alertWithTitle:@"账号不能为空!" targe:self];
        self.usernameText.text = @"";
        [self.usernameText becomeFirstResponder];
        return;
    }
    if ([password isEqualToString:@""]) {
        [ZLFUtil alertWithTitle:@"密码不能为空!" targe:self];
        self.passwordText.text = @"";
        [self.passwordText becomeFirstResponder];
        return;
    }
    //进行登陆
    AppDelegate * app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    app.regist = NO;
    [app connectWithUsername:username password:password];
    
    
}
#pragma mark - /********** 关闭键盘 **********/
- (void)closekey
{
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
// 显示消息界面
- (void)showMainView
{
    ZLFTabBarController * tabBarController = [[ZLFTabBarController alloc]init];
    [self presentViewController:tabBarController animated:YES completion:nil];
}





- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}










@end
