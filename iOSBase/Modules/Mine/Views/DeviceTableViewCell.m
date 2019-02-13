//
//  DeviceTableViewCell.m
//  iOSBase
//
//  Created by wy on 2019/2/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "DeviceTableViewCell.h"

@implementation DeviceTableViewCell
- (IBAction)unBindAction:(id)sender {
    
    if (self.block) {
        self.block(_model);
    }
}

- (void)setModel:(DevicesModel *)model {
    _model = model;
    self.titleLab.text = [NSString stringWithFormat:@"%@ %@",model.nikName,model.deviceType];
    self.deviceLab.text = model.deviceid;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
