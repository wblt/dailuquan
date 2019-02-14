//
//  UserInfoVC.m
//  iOSBase
//
//  Created by wy on 2019/2/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "UserInfoVC.h"
#import <BRPickerView.h>
#import <MOFSPickerManager.h>

@interface UserInfoVC ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *sexLab;
@property (weak, nonatomic) IBOutlet UILabel *heightLab;
@property (weak, nonatomic) IBOutlet UILabel *weightLab;
@property (weak, nonatomic) IBOutlet UILabel *birthDayLab;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;

@property(nonatomic,strong)UIImage *headImg;

@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人信息";
    UserInfoModel *userModel = [[BeanManager shareInstace] getBeanfromPath:UserModelPath];
    
    _nameLab.text = userModel.nikeName;
    _sexLab.text = [userModel.sex isEqualToString:@"0"]? @"男":@"女";
    _heightLab.text = userModel.height;
    _weightLab.text = userModel.weight;
    _birthDayLab.text = userModel.dateOfBirth;
    _areaLab.text = userModel.region;
    _addressLab.text = userModel.address;
    _phoneLab.text = userModel.phone;
    
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:userModel.portrait] placeholderImage:[UIImage imageNamed:@"me_head_portrait"]];
    
    if (userModel.portrait != nil) {
        self.headImg = _headImgView.image;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgAction)];
    _headImgView.userInteractionEnabled = YES;
    [_headImgView addGestureRecognizer:tap];
    
    UIBarButtonItem *rigthBarItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(editInfoAction)];
    self.navigationItem.rightBarButtonItem = rigthBarItem;
    
}

- (void)editInfoAction {
    
    if (!self.headImg) {
        [SVProgressHUD showErrorWithStatus:@"请上传头像"];
        return;
    }
    
    if (_nameLab.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写昵称"];
        return;
    }
    
    if (_heightLab.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择身高"];
        return;
    }
    
    if (_weightLab.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择体重"];
        return;
    }
    
    if (_birthDayLab.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择生日"];
        return;
    }
    
    
    if (_areaLab.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择地区"];
        return;
    }
    
    if (_addressLab.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写详细地址"];
        return;
    }
    
    if (_phoneLab.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写手机号"];
        return;
    }
    
    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
    
//    UserInfoModel *userModel = [[BeanManager shareInstace] getBeanfromPath:UserModelPath];
//    RequestParams *params = [[RequestParams alloc] initWithParams:self.addressModel?api_modifyReceivingAddress: api_addReceivingAddress];
//    [params addParameter:@"uid" value:userModel.id];
//    [params addParameter:@"address" value:_address];
//    [params addParameter:@"country" value:@"中国"];
//    [params addParameter:@"city" value:_shi];
//    [params addParameter:@"area" value:_qu];
//    [params addParameter:@"phone" value:_phone];
//    [params addParameter:@"name" value:_name];
//    [params addParameter:@"province" value:_sheng];
//    if (self.addressModel) {
//        [params addParameter:@"id" value:self.addressModel.id];
//    }
//    [[NetworkSingleton shareInstace] httpPost:params withTitle:@"" successBlock:^(id data) {
//        NSString *code = data[@"code"];
//        if (![code isEqualToString:@"0"]) {
//            [SVProgressHUD showErrorWithStatus:data[@"message"]];
//            return ;
//        }
//        [SVProgressHUD showSuccessWithStatus:self.addressModel? @"修改成功":@"添加成功"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.navigationController popViewControllerAnimated:YES];
//        });
//    } failureBlock:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"网络异常"];
//    }];
//
}

- (void)imgAction {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开照相机",@"从手机相册获取",nil];
    actionSheet.tag = 202;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
        if (buttonIndex == 0) {
            [self openCamera];
        }else if (buttonIndex == 1) {
            [self openPhotoLibrary];
        }
}


- (IBAction)nameAction:(id)sender {
    [self AlertWithTitle:@"昵称" message:@"" buttons:@[@"取消",@"确认"] textFieldNumber:1 configuration:^(UITextField *field, NSInteger index) {
        
    } animated:YES action:^(NSArray<UITextField *> *fields, NSInteger index) {
        if (index == 1) {
            if (fields[0].text.length > 0) {
                _nameLab.text = fields[0].text;
            }
        }
    }];
}

- (IBAction)sexAction:(id)sender {
    [BRStringPickerView showStringPickerWithTitle:@"性别" dataSource:@[@"男",@"女"] defaultSelValue:@"女" isAutoSelect:NO themeColor:nil resultBlock:^(id selectValue) {
        _sexLab.text = selectValue;
    }];
}

- (IBAction)heightAction:(id)sender {
    NSMutableArray *hights = [NSMutableArray array];
    for (NSInteger i = 140; i<200; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld",(long)i];
        [hights addObject:str];
    }
//    self.weights = [NSMutableArray array];
//    for (NSInteger i = 40; i<180; i++) {
//        NSString *str = [NSString stringWithFormat:@"%ld",(long)i];
//        [self.weights addObject:str];
//    }
    [[MOFSPickerManager shareManger] showPickerViewWithDataArray:hights tag:20 title:@"选择身高(CM)" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *string) {
        NSLog(@"%@",string);
        self.heightLab.text = [NSString stringWithFormat:@"%@ CM",string];
    } cancelBlock:^{
        
    }];
}
- (IBAction)weightAction:(id)sender {
    NSMutableArray *weights = [NSMutableArray array];
    for (NSInteger i = 140; i<180; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld",(long)i];
        [weights addObject:str];
    }
    [[MOFSPickerManager shareManger] showPickerViewWithDataArray:weights tag:21 title:@"选择体重(Kg)" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *string) {
        NSLog(@"%@",string);
        self.weightLab.text = [NSString stringWithFormat:@"%@ Kg",string];
    } cancelBlock:^{
        
    }];
}

- (IBAction)birthDayAction:(id)sender {
    [BRDatePickerView showDatePickerWithTitle:@"生日" dateType:BRDatePickerModeYMD defaultSelValue:@"" resultBlock:^(NSString *selectValue) {
        _birthDayLab.text = selectValue;
    }];
}

- (IBAction)areaAction:(id)sender {
    [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea defaultSelected:@[@"",@"",@""] isAutoSelect:NO themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        _areaLab.text = [NSString stringWithFormat:@"%@ %@ %@",province.name,city.name,area.name];
    } cancelBlock:^{
        NSLog(@"点击了背景视图或取消按钮");
    }];
}
- (IBAction)addressAction:(id)sender {
    [self AlertWithTitle:@"详细地址" message:@"" buttons:@[@"取消",@"确认"] textFieldNumber:1 configuration:^(UITextField *field, NSInteger index) {
        
    } animated:YES action:^(NSArray<UITextField *> *fields, NSInteger index) {
        if (index == 1) {
            if (fields[0].text.length > 0) {
                _addressLab.text = fields[0].text;
            }
        }
    }];
}

- (IBAction)phoneAction:(id)sender {
    [self AlertWithTitle:@"联系方式" message:@"" buttons:@[@"取消",@"确认"] textFieldNumber:1 configuration:^(UITextField *field, NSInteger index) {
        field.keyboardType = UIKeyboardTypePhonePad;
    } animated:YES action:^(NSArray<UITextField *> *fields, NSInteger index) {
        if (index == 1) {
            if (fields[0].text.length > 0) {
                _phoneLab.text = fields[0].text;
            }
        }
    }];

}


- (void)openCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; //可编辑
    //判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        NSLog(@"没有摄像头");
    }
}

/**
 
 *  打开相册
 
 */

-(void)openPhotoLibrary{
    // 进入相册
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        
        imagePicker.allowsEditing = YES;
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:^{
            NSLog(@"打开相册");
        }];
    }else {
        NSLog(@"不能打开相册");
    }
    
}

#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)

{
    self.headImgView.image = image;
    self.headImg = image;
    //    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
    //
    //    }else if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
    //
    //    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
