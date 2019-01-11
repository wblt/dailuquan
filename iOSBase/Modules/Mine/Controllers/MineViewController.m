//
//  MineViewController.m
//  iOSBase
//
//  Created by 冷婷 on 2019/1/3.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "BaseNavViewController.h"
#import "ScoreViewController.h"
#import "HonourViewController.h"
#import "AddressViewController.h"
#import "InformationViewController.h"
@interface MineViewController ()
@property (weak, nonatomic) IBOutlet UIView *user_view;
@property (weak, nonatomic) IBOutlet UIView *visit_view;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)registerAction {
    UIStoryboard *storyboad = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    RegisterViewController *loginVC = [storyboad instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)loginAction {
    UIStoryboard *storyboad = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginViewController *loginVC = [storyboad instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginVC animated:YES];
}

//退出登录
- (void)exitAction {
    [SPUtil setBool:NO forKey:k_app_login];
    [self changeLoginStatus];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeLoginStatus];
//    self.tabBarController.tabBar.hidden = NO;
}

- (void)changeLoginStatus {
    if ([SPUtil boolForKey:k_app_login]) {
        self.user_view.hidden = NO;
        self.visit_view.hidden = YES;
        UIBarButtonItem *rigthBarItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(exitAction)];
        self.navigationItem.rightBarButtonItem = rigthBarItem;
        self.navigationItem.leftBarButtonItem = nil;
    }else {
        self.user_view.hidden = YES;
        self.visit_view.hidden = NO;
        UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"没有账号？点此注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerAction)];
        self.navigationItem.leftBarButtonItem = leftBarItem;
        UIBarButtonItem *rigthBarItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginAction)];
        self.navigationItem.rightBarButtonItem = rigthBarItem;
    }
}

- (IBAction)toScoreVC:(UIButton *)sender {
    if ([SPUtil boolForKey:k_app_login]) {
        ScoreViewController *score = [[ScoreViewController alloc] init];
        [self.navigationController pushViewController:score animated:YES];
    }else {
        [self loginAction];
    }
}

- (IBAction)toHonourVC:(UIButton *)sender {
    if ([SPUtil boolForKey:k_app_login]) {
        HonourViewController *honous = [[HonourViewController alloc] init];
        [self.navigationController pushViewController:honous animated:YES];
    }else {
        [self loginAction];
    }
}

- (IBAction)toAddressVC:(UIButton *)sender {
    if ([SPUtil boolForKey:k_app_login]) {
        AddressViewController *address = [[AddressViewController alloc] init];
        [self.navigationController pushViewController:address animated:YES];
    }else {
        [self loginAction];
    }
}

- (IBAction)toInfoVC:(UITapGestureRecognizer *)sender {
    InformationViewController *info = [[InformationViewController alloc] init];
    [self.navigationController pushViewController:info animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
