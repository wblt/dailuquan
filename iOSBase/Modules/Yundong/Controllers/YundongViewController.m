//
//  YundongViewController.m
//  iOSBase
//
//  Created by 冷婷 on 2019/1/3.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YundongViewController.h"

@interface YundongViewController ()

@end

@implementation YundongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"运动";
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    UIBarButtonItem *rigthBarItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = rigthBarItem;
}

- (void)moreAction {
    
}

- (void)shareAction {
    
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
