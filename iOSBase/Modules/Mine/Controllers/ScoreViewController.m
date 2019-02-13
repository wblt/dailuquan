//
//  ScoreViewController.m
//  iOSBase
//
//  Created by 冷婷 on 2019/1/11.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()
@property (weak, nonatomic) IBOutlet UILabel *integralLab;
@property (weak, nonatomic) IBOutlet UILabel *balanceLab;

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分";
    [self requestData];
}

- (void)requestData {
    UserInfoModel *userModel = [[BeanManager shareInstace] getBeanfromPath:UserModelPath];
    RequestParams *params = [[RequestParams alloc] initWithParams:api_getIntegral];
    [params addParameter:@"uid" value:userModel.id];
    
    [[NetworkSingleton shareInstace] httpPost:params withTitle:@"" successBlock:^(id data) {
        NSString *code = data[@"code"];
        if (![code isEqualToString:@"0"]) {
            [SVProgressHUD showErrorWithStatus:data[@"message"]];
            return ;
        }
        self.balanceLab.text = [NSString stringWithFormat:@"%.02f",[data[@"data"][@"balance"] floatValue]];
        self.integralLab.text = [NSString stringWithFormat:@"%.02f",[data[@"data"][@"integral"] floatValue]];
        
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
