//
//  MyDeviceVC.m
//  iOSBase
//
//  Created by wy on 2019/2/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "MyDeviceVC.h"
#import "DeviceTableViewCell.h"
#import "AddDeviceVC.h"

@interface MyDeviceVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation MyDeviceVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.dataSource removeAllObjects];
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的设备";
    
    self.dataSource = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 68;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"DeviceTableViewCell" bundle:nil] forCellReuseIdentifier:@"DeviceTableViewCell"];
    UIBarButtonItem *rigthBarItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addDeviceAction)];
    self.navigationItem.rightBarButtonItem = rigthBarItem;
    
}

- (void)requestData {
    UserInfoModel *userModel = [[BeanManager shareInstace] getBeanfromPath:UserModelPath];
    RequestParams *params = [[RequestParams alloc] initWithParams:api_getDevices];
    [params addParameter:@"uid" value:userModel.id];
    
    [[NetworkSingleton shareInstace] httpPost:params withTitle:@"" successBlock:^(id data) {
        NSString *code = data[@"code"];
        if (![code isEqualToString:@"0"]) {
            [SVProgressHUD showErrorWithStatus:data[@"message"]];
            return ;
        }
        for (NSDictionary *dic in data[@"data"][@"devices"]) {
            DevicesModel *model = [DevicesModel mj_objectWithKeyValues:dic];
            [self.dataSource addObject:model];
        }
        
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
    
}

- (void)addDeviceAction {
    AddDeviceVC *vc = [[AddDeviceVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSource[indexPath.row];
    MJWeakSelf
    cell.block = ^(DevicesModel *model) {
        [self AlertWithTitle:@"温馨提示" message:@"是否解除设备的绑定" andOthers:@[@"取消",@"确定"] animated:YES action:^(NSInteger index) {
            
            if (index == 1) {
                [self unbindDevice:model];
            }
        }];
        
    };
    return cell;
}

- (void)unbindDevice:(DevicesModel *)model {
    UserInfoModel *userModel = [[BeanManager shareInstace] getBeanfromPath:UserModelPath];
    RequestParams *params = [[RequestParams alloc] initWithParams:api_unbindDevice];
    [params addParameter:@"uid" value:userModel.id];
    [params addParameter:@"id" value:model.id];
    
    [[NetworkSingleton shareInstace] httpPost:params withTitle:@"" successBlock:^(id data) {
        NSString *code = data[@"code"];
        if (![code isEqualToString:@"0"]) {
            [SVProgressHUD showErrorWithStatus:data[@"message"]];
            return ;
        }
        [SVProgressHUD showSuccessWithStatus:@"解绑成功"];
        [self.dataSource removeObject:model];
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
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
