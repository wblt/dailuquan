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
@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"没有账号？点此注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerAction)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    UIBarButtonItem *rigthBarItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginAction)];
    self.navigationItem.rightBarButtonItem = rigthBarItem;
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
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
