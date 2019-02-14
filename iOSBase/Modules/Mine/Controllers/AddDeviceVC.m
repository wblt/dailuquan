//
//  AddDeviceVC.m
//  iOSBase
//
//  Created by wy on 2019/2/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "AddDeviceVC.h"
#import <MOFSPickerManager.h>

@interface AddDeviceVC ()

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *imei;
@property(nonatomic,strong)NSString *type;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *imeiLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;

@end

@implementation AddDeviceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"绑定设备";
    UIBarButtonItem *rigthBarItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(bindDeviceAction)];
    self.navigationItem.rightBarButtonItem = rigthBarItem;
    
}

- (void)bindDeviceAction {
    if (_name.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写昵称"];
        return;
    }
    
    if (_imei.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写设备IMEI"];
        return;
    }
    
    if (_type.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请选择设备类型"];
        return;
    }
    
    UserInfoModel *userModel = [[BeanManager shareInstace] getBeanfromPath:UserModelPath];
    RequestParams *params = [[RequestParams alloc] initWithParams:api_bindingDevice];
    [params addParameter:@"uid" value:userModel.id];
    [params addParameter:@"nikName" value:_name];
    [params addParameter:@"deviceId" value:_imei];
    [params addParameter:@"deviceType" value:_type];
    
    [[NetworkSingleton shareInstace] httpPost:params withTitle:@"" successBlock:^(id data) {
        NSString *code = data[@"code"];
        if (![code isEqualToString:@"0"]) {
            [SVProgressHUD showErrorWithStatus:data[@"message"]];
            return ;
        }
        [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
}

- (IBAction)nameAction:(UITapGestureRecognizer *)sender {
    [self AlertWithTitle:@"昵称" message:@"" buttons:@[@"取消",@"确认"] textFieldNumber:1 configuration:^(UITextField *field, NSInteger index) {
        
    } animated:YES action:^(NSArray<UITextField *> *fields, NSInteger index) {
        if (index == 1) {
            if (fields[0].text.length > 0) {
                _name = fields[0].text;
                _nameLab.text = _name;
            }
        }
    }];
}


- (IBAction)imeiAction:(UITapGestureRecognizer *)sender {
    [self AlertWithTitle:@"设备IMEI" message:@"" buttons:@[@"取消",@"确认"] textFieldNumber:1 configuration:^(UITextField *field, NSInteger index) {
        
    } animated:YES action:^(NSArray<UITextField *> *fields, NSInteger index) {
        if (index == 1) {
            if (fields[0].text.length > 0) {
                _imei = fields[0].text;
                _imeiLab.text = _imei;
            }
        }
    }];
}
- (IBAction)deviceTypeAction:(id)sender {
    NSArray *ary = @[@"A200",@"A200-2",@"C100",@"C100+",@"W300",@"W400",@"W500"];
   [[MOFSPickerManager shareManger] showPickerViewWithDataArray:ary tag:20 title:@"设备类型" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *string) {
        NSLog(@"%@",string);
        _type = string;
       _typeLab.text = _type;
    } cancelBlock:^{
        
    }];
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
