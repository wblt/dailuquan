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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    self.addressArr = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressCell" bundle:nil] forCellReuseIdentifier:@"AddressCell"];
    UIBarButtonItem *rigthBarItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addAddressAction)];
    self.navigationItem.rightBarButtonItem = rigthBarItem;
}

- (void)addAddressAction {
    AddAddressVC *vc = [[AddAddressVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;//self.addressArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
