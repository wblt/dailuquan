//
//  DevicesModel.h
//  iOSBase
//
//  Created by wy on 2019/2/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DevicesModel : NSObject

@property(nonatomic,copy)NSString *deviceType;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *bleName;
@property(nonatomic,copy)NSString *nikName;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *deviceid;
@property(nonatomic,copy)NSString *deviceId;
@property(nonatomic,copy)NSString *bleMac;

@end
/*
 "deviceType": "C100+",
 "uid": 1,
 "bleName": "",
 "nikName": "ggg",
 "id": 6,
 "time": "2019-01-10 11:18:38.0", "type": 0,
 "deviceid": "6622222233333333", "deviceId": "6622222233333333", "bleMac": ""
 */
