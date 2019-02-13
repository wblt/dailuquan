//
//  AddAddressVC.m
//  iOSBase
//
//  Created by wy on 2019/2/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "AddAddressVC.h"
#import <MOFSPickerManager.h>
#import <BRPickerView.h>

@interface AddAddressVC ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *pLab;
@property (weak, nonatomic) IBOutlet UILabel *cityLab;
@property (weak, nonatomic) IBOutlet UILabel *disLab;

@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *sheng;
@property(nonatomic,strong)NSString *shi;
@property(nonatomic,strong)NSString *qu;
@property(nonatomic,strong)NSString *address;

@end

@implementation AddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"添加地址";
    UIBarButtonItem *rigthBarItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(addAddressAction)];
    self.navigationItem.rightBarButtonItem = rigthBarItem;
}

- (void)addAddressAction {
    if (_name.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写联系人名称"];
        return;
    }
    
    if (_phone.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写联系人电话"];
        return;
    }
    
    if (_sheng.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请选择地址"];
        return;
    }
    
    if (_address.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写详细地址"];
        return;
    }
    
    // 绑定设备
}

- (IBAction)nameAction:(id)sender {
    [self AlertWithTitle:@"联系人名称" message:@"" buttons:@[@"取消",@"确认"] textFieldNumber:1 configuration:^(UITextField *field, NSInteger index) {
        
    } animated:YES action:^(NSArray<UITextField *> *fields, NSInteger index) {
        if (index == 1) {
            if (fields[0].text.length > 0) {
                _name = fields[0].text;
                _nameLab.text = _name;
            }
        }
    }];
}

- (IBAction)phoneAction:(id)sender {
    [self AlertWithTitle:@"联系人电话" message:@"" buttons:@[@"取消",@"确认"] textFieldNumber:1 configuration:^(UITextField *field, NSInteger index) {
        field.keyboardType = UIKeyboardTypePhonePad;
    } animated:YES action:^(NSArray<UITextField *> *fields, NSInteger index) {
        if (index == 1) {
            if (fields[0].text.length > 0) {
                _phone = fields[0].text;
                _phoneLab.text = _phone;
            }
        }
    }];
}

- (IBAction)shengAction:(id)sender {
    MJWeakSelf;
    [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea defaultSelected:@[@"",@"",@""] isAutoSelect:NO themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        weakSelf.sheng = province.name;
        weakSelf.shi = city.name;
        weakSelf.qu = area.name;
        
        weakSelf.pLab.text = weakSelf.sheng;
        weakSelf.cityLab.text = weakSelf.shi;
        weakSelf.disLab.text = weakSelf.qu;
    } cancelBlock:^{
        NSLog(@"点击了背景视图或取消按钮");
    }];
}

- (IBAction)shiAction:(id)sender {
    MJWeakSelf;
    [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea defaultSelected:@[@"",@"",@""] isAutoSelect:NO themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        weakSelf.sheng = province.name;
        weakSelf.shi = city.name;
        weakSelf.qu = area.name;
        
        weakSelf.pLab.text = weakSelf.sheng;
        weakSelf.cityLab.text = weakSelf.shi;
        weakSelf.disLab.text = weakSelf.qu;
    } cancelBlock:^{
        NSLog(@"点击了背景视图或取消按钮");
    }];
}

- (IBAction)quAction:(id)sender {
    MJWeakSelf;
    [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea defaultSelected:@[@"",@"",@""] isAutoSelect:NO themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        weakSelf.sheng = province.name;
        weakSelf.shi = city.name;
        weakSelf.qu = area.name;
        
        weakSelf.pLab.text = weakSelf.sheng;
        weakSelf.cityLab.text = weakSelf.shi;
        weakSelf.disLab.text = weakSelf.qu;
    } cancelBlock:^{
        NSLog(@"点击了背景视图或取消按钮");
    }];
}

- (IBAction)addressAction:(id)sender {
    [self AlertWithTitle:@"详细地址" message:@"" buttons:@[@"取消",@"确认"] textFieldNumber:1 configuration:^(UITextField *field, NSInteger index) {
        
    } animated:YES action:^(NSArray<UITextField *> *fields, NSInteger index) {
        if (index == 1) {
            if (fields[0].text.length > 0) {
                _address = fields[0].text;
                _addressLab.text = _address;
            }
        }
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
