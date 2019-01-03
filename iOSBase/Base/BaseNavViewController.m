//
//  BaseNavViewController.m
//  Keepcaring
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,weak) UIViewController* currentShowVC;


@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = NO;
}

//这里可以封装成一个分类
- (UIBarButtonItem *)barButtonItemWithImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 40, 40);
    button.adjustsImageWhenHighlighted = NO;
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // iOS 11 系统，将Button的内容 和 图片根具体需求进行便处理
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)) {
        button.contentEdgeInsets =UIEdgeInsetsMake(0, -15,0, 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -10,0, 0);
    }
    [button layoutButtonWithEdgeInsetsStyle:WYButtonEdgeInsetsStyleLeft imageTitleSpace:-5];
    return  [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *popToPreButton = [self barButtonItemWithImage:@"top_ico" highImage:@"top_ico" target:self action:@selector(popToPre)];
        popToPreButton.width = -15;
        viewController.navigationItem.leftBarButtonItem = popToPreButton;
    }
    [super pushViewController:viewController animated:animated];
}


- (void)popToPre{
    [self popViewControllerAnimated:YES];
}

#pragma mark --------navigation delegate
//该方法可以解决popRootViewController时tabbar的bug
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //删除系统自带的tabBarButton
    for (UIView *tabBar in self.tabBarController.tabBar.subviews) {
        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBar removeFromSuperview];
        }
    }
    
}

//-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//
//}

#pragma mark --------解决导航自定义后侧滑后退失效

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (navigationController.viewControllers.count == 1)
        self.currentShowVC = Nil;
    else
        self.currentShowVC = viewController;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.topViewController);
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
