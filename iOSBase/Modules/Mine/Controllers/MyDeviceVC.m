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
    UIBarButtonItem *rigthBarItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addDeviceAction)];
    self.navigationItem.rightBarButtonItem = rigthBarItem;
}

- (void)addDeviceAction {
    AddDeviceVC *vc = [[AddDeviceVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;//self.addressArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MJWeakSelf
    cell.block = ^(DevicesModel *model) {
        //
        [weakSelf.dataSource removeObject:model];
        [weakSelf.tableView reloadData];
    };
    return cell;
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
