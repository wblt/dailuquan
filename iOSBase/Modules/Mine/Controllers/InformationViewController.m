//
//  InformationViewController.m
//  iOSBase
//
//  Created by wb on 2018/7/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "InformationViewController.h"
#import <PGDatePicker.h>
#import "MOFSPickerManager.h"

@interface InformationViewController () <UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,PGDatePickerDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *informationArr;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *brithday;
@property (nonatomic,strong) NSMutableArray *hights;
@property (nonatomic,strong) NSMutableArray *weights;
@property (nonatomic,strong) UIImageView *headImg;
@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写信息";
    if ([self.type isEqualToString:@"add"]) {
        self.navigationItem.hidesBackButton = YES;
    }
    [self initTableView];
    self.informationArr = @[@"性别",@"身高",@"城市"].mutableCopy;
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    self.hights = [NSMutableArray array];
    for (NSInteger i = 140; i<200; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld",(long)i];
        [self.hights addObject:str];
    }
    self.weights = [NSMutableArray array];
    for (NSInteger i = 40; i<180; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld",(long)i];
        [self.weights addObject:str];
    }
    // 初始化
    self.nickName = [SPUtil objectForKey:k_app_nickname];
    self.sex = [SPUtil objectForKey:k_app_sex];
    self.height = [SPUtil objectForKey:k_app_height];
    self.weight = [SPUtil objectForKey:k_app_weight];
    self.brithday = [SPUtil objectForKey:k_app_birthday];
}

- (void)saveAction {
    
}

- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-navHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 55;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.informationArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier=@"InformationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.informationArr[indexPath.section];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.section == 0) {
        cell.detailTextLabel.text = _sex;
    }else if (indexPath.section == 1) {
        cell.detailTextLabel.text = _height;
    }else if (indexPath.section == 2) {
        cell.detailTextLabel.text = @"湖南长沙";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 130;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headV = [[NSBundle mainBundle] loadNibNamed:@"InformationHeaderView" owner:nil options:nil].lastObject;
        headV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toChangeHeadImg)];
        [headV addGestureRecognizer:tap];
        self.headImg = [headV viewWithTag:301];
        NSString *aPath3= [SPUtil objectForKey:k_app_headpath];
        if (aPath3 != nil) {
            [self.headImg sd_setImageWithURL:[NSURL URLWithString:aPath3] placeholderImage:[UIImage imageNamed:@"me_head_portrait"]];
        } else {
            self.headImg.image = [UIImage imageNamed:@"me_head_portrait"];
        }
        return headV;
    }
    return [[UIView alloc] init];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女",nil];
        myActionSheet.tag = 201;
        [myActionSheet showInView:self.view];
        
    }else if (indexPath.section == 1) {
        [[MOFSPickerManager shareManger] showPickerViewWithDataArray:self.hights tag:20 title:@"选择身高(CM)" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *string) {
            NSLog(@"%@",string);
            self.height = string;
            [_tableView reloadData];
        } cancelBlock:^{
            
        }];
    }else if (indexPath.section == 3) {
        
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 201) {
        if (buttonIndex == 0) {
            _sex = @"男";
        }else if (buttonIndex == 1) {
            _sex = @"女";
        }
        [_tableView reloadData];
    }else {
        if (buttonIndex == 0) {
            [self openCamera];
        }else if (buttonIndex == 1) {
            [self openPhotoLibrary];
        }
    }
}

- (void)toChangeHeadImg {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开照相机",@"从手机相册获取",nil];
    actionSheet.tag = 202;
    [actionSheet showInView:self.view];
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

-(void)openPhotoLibrary

{
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
    self.headImg.image = image;
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

#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSLog(@"dateComponents = %@", dateComponents);
    _brithday = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)dateComponents.year,(long)dateComponents.month,(long)dateComponents.day];
    [_tableView reloadData];
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
