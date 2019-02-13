//
//  AddressCell.h
//  iOSBase
//
//  Created by 冷婷 on 2019/1/11.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^EditAddressBlock)(AddressInfoModel *model);
@interface AddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLan;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@property(nonatomic,strong)AddressInfoModel *model;
@property(nonatomic,copy)EditAddressBlock block;

@end

NS_ASSUME_NONNULL_END
