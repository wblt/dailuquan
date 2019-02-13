//
//  HonourViewController.m
//  iOSBase
//
//  Created by 冷婷 on 2019/1/11.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "HonourViewController.h"
#import "HonorModel.h"

@interface HonourViewController ()
@property (weak, nonatomic) IBOutlet UILabel *text1Lab;
@property (weak, nonatomic) IBOutlet UILabel *text2Lab;

@end

@implementation HonourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"荣誉";
    [self requestData];
}

- (void)requestData {
    RequestParams *params = [[RequestParams alloc] initWithParams:api_getMotionHonor];
    
    [[NetworkSingleton shareInstace] httpPost:params withTitle:@"" successBlock:^(id data) {
        NSString *code = data[@"code"];
        if (![code isEqualToString:@"0"]) {
            [SVProgressHUD showErrorWithStatus:data[@"message"]];
            return ;
        }
        NSMutableArray <HonorModel *>*ary = [NSMutableArray array];
        for (NSDictionary *dic in data[@"data"]) {
            HonorModel *model = [HonorModel mj_objectWithKeyValues:dic];
            [ary addObject:model];
        }
        if (ary.count > 0 ) {
            _text1Lab.text = ary[0].honorName;
            _text2Lab.text = ary[1].honorName;
        }
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
    
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
