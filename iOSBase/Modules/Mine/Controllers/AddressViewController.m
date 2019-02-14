//
//  AddressViewController.m
//  iOSBase
//
//  Created by 冷婷 on 2019/1/11.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressCell.h"
#import "AddAddressVC.h"

@interface AddressViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *addressArr;
@end

@implementation AddressViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.addressArr removeAllObjects];
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    self.addressArr = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 76;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressCell" bundle:nil] forCellReuseIdentifier:@"AddressCell"];
    UIBarButtonItem *rigthBarItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addAddressAction)];
    self.navigationItem.rightBarButtonItem = rigthBarItem;
}

- (void)requestData {
    UserInfoModel *userModel = [[BeanManager shareInstace] getBeanfromPath:UserModelPath];
    RequestParams *params = [[RequestParams alloc] initWithParams:api_getReceivingAddress];
    [params addParameter:@"uid" value:userModel.id];
    
    [[NetworkSingleton shareInstace] httpPost:params withTitle:@"" successBlock:^(id data) {
        NSString *code = data[@"code"];
        if (![code isEqualToString:@"0"]) {
            [SVProgressHUD showErrorWithStatus:data[@"message"]];
            return ;
        }
        for (NSDictionary *dic in data[@"data"]) {
            AddressInfoModel *model = [AddressInfoModel mj_objectWithKeyValues:dic];
            [self.addressArr addObject:model];
        }
        
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
}

- (void)addAddressAction {
    AddAddressVC *vc = [[AddAddressVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addressArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell" forIndexPath:indexPath];
    cell.model = self.addressArr[indexPath.row];
    
    MJWeakSelf
    cell.block = ^(AddressInfoModel * _Nonnull model) {
        [self AlertWithTitle:@"温馨提示" message:@"删除或修改收货地址" andOthers:@[@"删除",@"修改"] animated:YES action:^(NSInteger index) {
            if (index == 0) { // 删除
                [self deleteAddress:model];
            }else { // 修改
                AddAddressVC *vc = [[AddAddressVC alloc] init];
                vc.addressModel = model;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)deleteAddress:(AddressInfoModel *)model {
    UserInfoModel *userModel = [[BeanManager shareInstace] getBeanfromPath:UserModelPath];
    RequestParams *params = [[RequestParams alloc] initWithParams:api_deleteReceivingAddress];
    [params addParameter:@"uid" value:userModel.id];
    [params addParameter:@"id" value:model.id];
    
    [[NetworkSingleton shareInstace] httpPost:params withTitle:@"" successBlock:^(id data) {
        NSString *code = data[@"code"];
        if (![code isEqualToString:@"0"]) {
            [SVProgressHUD showErrorWithStatus:data[@"message"]];
            return ;
        }
        [SVProgressHUD showSuccessWithStatus:@"删除成功"];
        [self.addressArr removeObject:model];
        [self.tableView reloadData];
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
