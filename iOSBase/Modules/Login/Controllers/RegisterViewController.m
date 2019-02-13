//
//  RegisterViewController.m
//  HJKHiWatch
//
//  Created by AirTops on 15/11/27.
//  Copyright © 2015年 cn.hi-watch. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (assign, nonatomic) BOOL presenting;
@property (nonatomic,copy) NSString *vercode;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册新用户";
    [_userNameFiled addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (IBAction)visAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    _passwordFiled.secureTextEntry = !sender.selected;
}

// textField 长度限制
- (void)textFieldDidChanged:(UITextField *)textField
{
    if (textField == _userNameFiled) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.presenting = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.presenting = NO;
}

#pragma mark - 获取验证码
- (IBAction)getSmsCodeAction:(id)sender {
    NSString *phoneNumber = self.userNameFiled.text;
    if (phoneNumber.length != 11) {
        [SVProgressHUD showInfoWithStatus:@"电话号格式异常"];
        return;
    }
    RequestParams *parms = [[RequestParams alloc] initWithParams:api_vercode];
    [parms addParameter:@"username" value:self.userNameFiled.text];
    [[NetworkSingleton shareInstace] httpPost:parms withTitle:@"获取验证码" successBlock:^(id data) {
        NSDictionary *dic = data;
        NSString *code = dic[@"result"];
        if ([code isEqualToString:@"0"]) {
            [SVProgressHUD showInfoWithStatus:@"验证码发送成功"];
            self.vercode = dic[@"vercode"];
            [self countTimer];
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"失败-%@",@"服务器请求出错,请联系管理员"]];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"服务器请求出错,请联系管理员"];
    }];
}

#pragma mark - 注册
- (IBAction)registerAction:(id)sender {
    if (self.userNameFiled.text.length != 11) {
        [SVProgressHUD showInfoWithStatus:@"电话号码格式不正确"];
        return;
    }
    if (![Util pwdCheck:self.passwordFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"请输入6到10位的数字或者字母的密码"];
        return;
    }
    if (![self.vercode isEqualToString:self.smsCodeFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"验证码输入错误"];
        return;
    }
    RequestParams *parms = [[RequestParams alloc] initWithParams:api_register];
    NSString *md5 = [[self.passwordFiled.text MD5Hash] lowercaseString];
    [parms addParameter:@"password" value:md5];
    [parms addParameter:@"username" value:self.userNameFiled.text];
    [[NetworkSingleton shareInstace] httpPost:parms withTitle:@"注册" successBlock:^(id data) {
        NSDictionary *dic = data;
        NSNumber *code = dic[@"result"];
        if ([code integerValue] == 0) {
            [SVProgressHUD showInfoWithStatus:@"注册成功"];
            if (self.registerBackBlock) {
        self.registerBackBlock(self.userNameFiled.text,self.passwordFiled.text);
            }
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"失败-%@",@"该账号已注册"]];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"服务器请求出错,请联系管理员"];
    }];
    
}
- (void)countTimer {
    //4.60s计时
    self.smsCodeBtn.enabled = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        int counter = 60;
        while (--counter >= 0 && _presenting) {
            dispatch_async(dispatch_get_main_queue(), ^(){
                [self.smsCodeBtn setTitle: [NSString stringWithFormat:@"%d秒", counter + 1] forState: UIControlStateDisabled];
            });
            [NSThread sleepForTimeInterval:1];
        }
        dispatch_async(dispatch_get_main_queue(), ^(){
            self.smsCodeBtn.enabled = YES;
        });
    });
}

- (IBAction)toBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
