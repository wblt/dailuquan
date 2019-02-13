//
//  HonorModel.h
//  iOSBase
//
//  Created by wy on 2019/2/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HonorModel : NSObject

@property(nonatomic,copy)NSString *conditionsReached;
@property(nonatomic,copy)NSString *honorName;
@property(nonatomic,copy)NSString *describe;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *target;

@end
/*
 "conditionsReached": 1000, "honorName": " 富翁", "name": " 富翁", "describe": "账号有1000蚊", "id": 1,
 "time": "2019-01-03 14:17:28.0",
 "target": 1000
 */
