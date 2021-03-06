//
//  ForgetPwdController.m
//  HJKHiWatch
//
//  Created by AirTops on 15/11/27.
//  Copyright © 2015年 cn.hi-watch. All rights reserved.
//

#import "ForgetPwdController.h"

@interface ForgetPwdController ()
@property (weak, nonatomic) IBOutlet UIButton *centainBtn;

@property (assign, nonatomic) BOOL presenting;
@property (nonatomic,copy) NSString *vercode;

@end

@implementation ForgetPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码找回";
     [_phoneNum addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (IBAction)visAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    _passwordFiled.secureTextEntry = !sender.selected;
}

// textField 长度限制
- (void)textFieldDidChanged:(UITextField *)textField
{
    if (textField == _phoneNum) {
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
    NSString *phoneNumber = self.phoneNum.text;
    if (phoneNumber.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"电话号格式异常"];
        return;
    }
    RequestParams *parms = [[RequestParams alloc] initWithParams:api_vercode];
    [parms addParameter:@"username" value:self.phoneNum.text];
    [[NetworkSingleton shareInstace] httpPost:parms withTitle:@"获取验证码" successBlock:^(id data) {
        NSDictionary *dic = data;
        NSNumber *code = dic[@"result"];
        if ([code integerValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"验证码发送成功"];
            self.vercode = dic[@"vercode"];
            [self countTimer];
        } else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"失败-%@",@"服务器请求出错,请联系管理员"]];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"服务器请求出错,请联系管理员"];
    }];
}


#pragma mark - 提交
- (IBAction)forgotPasswordAction:(id)sender {
    if (self.phoneNum.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"电话号码格式不正确"];
        return;
    }
    if (self.passwordFiled.text.length <6 || self.passwordFiled.text.length >10) {
        [SVProgressHUD showErrorWithStatus:@"请输入6到10位的数字或者字母的密码"];
        return;
    }
    if (![self.vercode isEqualToString:self.smsCodeFiled.text]) {
        [SVProgressHUD showErrorWithStatus:@"验证码输入错误"];
        return;
    }
    RequestParams *parms = [[RequestParams alloc] initWithParams:api_restpwd];
    NSString *md5 = [[self.passwordFiled.text MD5Hash] lowercaseString];
    [parms addParameter:@"password" value:md5];
    [parms addParameter:@"accountNumber" value:self.phoneNum.text];
    [parms addParameter:@"modifyType" value:@"0"];
    [[NetworkSingleton shareInstace] httpPost:parms withTitle:@"忘记密码" successBlock:^(id data) {
        NSDictionary *dic = data;
        NSNumber *code = dic[@"result"];
        if ([code integerValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            if (self.forgetBackBlock) {
                self.forgetBackBlock(self.phoneNum.text,self.passwordFiled.text);
            }
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"失败-%@",@"服务器请求出错,请联系管理员"]];
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
