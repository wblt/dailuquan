//
//  TabbarViewController.m
//  iOSBase
//
//  Created by 冷婷 on 2018/10/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TabbarViewController.h"
#import "QuanziViewController.h"
#import "YundongViewController.h"
#import "JingpaiViewController.h"
#import "MineViewController.h"
#import "BaseNavViewController.h"

@interface TabbarViewController () <UITabBarControllerDelegate>

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    QuanziViewController *one = [[QuanziViewController alloc] init];
    
    BaseNavViewController *oneNav = [[BaseNavViewController alloc] initWithRootViewController:one];
    
    YundongViewController *two = [[YundongViewController alloc] init];
    BaseNavViewController *twoNav = [[BaseNavViewController alloc] initWithRootViewController:two];
    
    JingpaiViewController *three = [[JingpaiViewController alloc] init];
    BaseNavViewController *threeNav = [[BaseNavViewController alloc] initWithRootViewController:three];
	
    
    
    MineViewController *four = [[MineViewController alloc] init];
    BaseNavViewController *fourNav = [[BaseNavViewController alloc] initWithRootViewController:four];
    
    
    
    UITabBarItem *oneItem = [[UITabBarItem alloc]initWithTitle:@"圈子"
                             
                                                         image:[[UIImage imageNamed:@"main_circle_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                             
                                                 selectedImage:[[UIImage imageNamed:@"main_circle_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    UITabBarItem *twoItem = [[UITabBarItem alloc]initWithTitle:@"运动"

                                                         image:[[UIImage imageNamed:@"main_motion_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

                                                 selectedImage:[[UIImage imageNamed:@"main_motion_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	
    UITabBarItem *threeItem = [[UITabBarItem alloc]initWithTitle:@"竞拍"
                               
                                                           image:[[UIImage imageNamed:@"main_auction_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                               
                                                   selectedImage:[[UIImage imageNamed:@"main_auction_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UITabBarItem *foureItem = [[UITabBarItem alloc]initWithTitle:@"我"
                               
                                                           image:[[UIImage imageNamed:@"main_me_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                               
                                                   selectedImage:[[UIImage imageNamed:@"main_me_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    // 设置 viewcontroller.tabBarItem属性
    
    oneNav.tabBarItem = oneItem;
    
    twoNav.tabBarItem = twoItem;
    
    threeNav.tabBarItem = threeItem;
    
    fourNav.tabBarItem = foureItem;
    // 设置标题颜色
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary
                                                       
                                                       dictionaryWithObjectsAndKeys:[UIColor blackColor],
                                                       
                                                       NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    // 设置标题选重颜色
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary
                                                       
                                                       dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    // 设置tabBar背景颜色
    
    [self.tabBar setBarTintColor:[UIColor whiteColor]];
    
    self.delegate = self;
    self.viewControllers = @[oneNav, twoNav, threeNav, fourNav];
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
