//
//  LoginViewController.m
//  HJKHiWatch
//
//  Created by AirTops on 15/11/27.
//  Copyright © 2015年 cn.hi-watch. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPwdController.h"
#import "AppDelegate.h"
#import "BaseNavViewController.h"
#import "TabbarViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [_phoneNumFiled addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (IBAction)weixinAction:(id)sender {
}
- (IBAction)qqAction:(id)sender {
}

- (IBAction)weiboAction:(id)sender {
}

- (IBAction)visAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    _passwordFiled.secureTextEntry = !sender.selected;
}

// textField 长度限制
- (void)textFieldDidChanged:(UITextField *)textField
{
    if (textField == _phoneNumFiled) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - 登陆
- (IBAction)loginAction:(id)sender {
    if (self.phoneNumFiled.text.length != 11) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号码"];
        return;
    }
    if ([self.passwordFiled.text length] == 0) {
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        return;
    }
    RequestParams *parms = [[RequestParams alloc] initWithParams:api_login];
    NSString *md5 = [[self.passwordFiled.text MD5Hash] lowercaseString];
    [parms addParameter:@"accountNumber" value:self.phoneNumFiled.text];
    [parms addParameter:@"loginType" value:@"0"];
    [parms addParameter:@"password" value:md5];
    [[NetworkSingleton shareInstace] httpPost:parms withTitle:@"登录" successBlock:^(id data) {
        NSDictionary *dic = data;
        NSString *code = dic[@"code"];
        if ([code isEqualToString:@"0"]) {
            [SVProgressHUD showInfoWithStatus:@"登录成功"];
            [SPUtil setObject:self.phoneNumFiled.text forKey:k_app_userNumber];
            UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:data[@"data"]];
            [[BeanManager shareInstace] setBean:model path:UserModelPath];
            [SPUtil setBool:YES forKey:k_app_login];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"登录失败-%@",dic[@"message"]]];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"服务器请求出错,请联系管理员"];
    }];
   
}

#pragma mark - 监听故事版跳转
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[RegisterViewController class]]) {
        
        RegisterViewController *registerVC = (RegisterViewController *)segue.destinationViewController;
        registerVC.registerBackBlock = ^(NSString *userName,NSString *userPassword) {
            self.phoneNumFiled.text = userName;
            self.passwordFiled.text = userPassword;
        };
    }
    else if ([segue.destinationViewController isKindOfClass:[ForgetPwdController class]]) {
        ForgetPwdController *forGetVC = (ForgetPwdController *)segue.destinationViewController;
        forGetVC.forgetBackBlock = ^(NSString *userName,NSString *userPassword) {
            self.phoneNumFiled.text = userName;
            self.passwordFiled.text = userPassword;
        };
    }
}
@end
