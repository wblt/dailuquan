//
//  AddressCell.m
//  iOSBase
//
//  Created by 冷婷 on 2019/1/11.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell


- (IBAction)editAction:(id)sender {
    if (self.block) {
        self.block(_model);
    }
}

- (void)setModel:(AddressInfoModel *)model {
    _model = model;
    self.titleLab.text = [model.name substringToIndex:1];
    self.nameLab.text = model.name;
    self.phoneLan.text = model.phone;
    self.addressLab.text = [NSString stringWithFormat:@"%@ %@ %@ %@",model.province,model.city,model.area,model.address];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewRadius(self.titleLab, 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
