//
//  AddressInfoModel.h
//  iOSBase
//
//  Created by wy on 2019/2/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressInfoModel : NSObject

@property(nonatomic,copy)NSString *area;
@property(nonatomic,copy)NSString *country;
@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *id;

@end

/*
 "area": "枞阳县",
 "country": "中国",
 "address": "好好 好好就 喜欢动画电影需要多少艺术 ", "province": "安徽省",
 "phone": "13612345678",
 "city": "安庆市",
 "name": "教学计划电话",
 "id": 6
 */
