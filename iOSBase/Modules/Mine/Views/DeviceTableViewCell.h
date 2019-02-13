//
//  DeviceTableViewCell.h
//  iOSBase
//
//  Created by wy on 2019/2/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DevicesModel.h"

typedef void(^DeleteDeviceBlock)(DevicesModel *model);
@interface DeviceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *deviceLab;

@property(nonatomic,strong)DevicesModel *model;
@property(nonatomic,copy)DeleteDeviceBlock block;
@end
