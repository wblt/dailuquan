//
//  FlowAPI.h
//  Keepcaring
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#ifndef FlowAPI_h
#define FlowAPI_h

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

/**<转换16进制颜色*/
#define UIColorFromHex(HexValue) ([UIColor colorWithHex:HexValue])

/**<RGB颜色设置*/
#define UI_ColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a]

/**<本地的文件目录路径*/
#define kLocalFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"LocalFileDirectory"]

/**<本地的文件目录*/
#define LocalFileDirectory [Util createFileDirectory:kLocalFilePath]

/**<用户的文件目录*/
#define UserModelPath [LocalFileDirectory stringByAppendingPathComponent:@"userModel.archive"]

/**<设备信息的文件目录*/
#define DeviceDataPath [LocalFileDirectory stringByAppendingPathComponent:@"DeviceData.archive"]

/**<下载的文件目录*/
#define DownloadFilePath [LocalFileDirectory stringByAppendingPathComponent:@"downloadFileDirectory"]

//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//获取屏幕宽高
#define KScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define navHeight ((KScreenWidth >= 375 && KScreenHeight >= 812) ? 88.0 : 64.0)

// 主服务器地址
#define SERVER_IP         @"http://yg.welcare-tech.com.cn"

// 登录
//#define api_login       SERVER_IP@"/tpiot/app/login"
#define api_login       SERVER_IP@"/weixin/agedgame/login"

// 获取验证码
#define api_vercode     SERVER_IP@"/tpiot/app/vercode"

// 重置密码
#define api_restpwd     SERVER_IP@"/weixin/agedgame/modifyPassword"

// 注册
#define api_register     SERVER_IP@"/weixin/agedgame/register"

// 获取用户信息
#define api_getusermessage     SERVER_IP@"/tpiot/app/getusermessage"

// 更新用户信息
#define api_upuserinfodata     SERVER_IP@"/tpiot/app/upuserinfodata"

//--------------
//我的设备
#define api_getDevices     SERVER_IP@"/weixin/agedgame/getDevices"

// 绑定设备
#define api_bindingDevice     SERVER_IP@"/weixin/agedgame/bindingDevice"

// 解绑设备
#define api_unbindDevice     SERVER_IP@"/weixin/agedgame/unbindDevice"


// 收货地址
#define api_getReceivingAddress     SERVER_IP@"/weixin/agedgame/getReceivingAddress"

// 添加收货地址
#define api_addReceivingAddress     SERVER_IP@"/weixin/agedgame/addReceivingAddress"

// 修改收货地址
#define api_modifyReceivingAddress     SERVER_IP@"/weixin/agedgame/modifyReceivingAddress"

// 删除收货地址
#define api_deleteReceivingAddress     SERVER_IP@"/weixin/agedgame/deleteReceivingAddress"

// 积分
#define api_getIntegral     SERVER_IP@"/weixin/agedgame/getIntegral"

// 荣誉
#define api_getMotionHonor     SERVER_IP@"/weixin/agedgame/getMotionHonor"


#endif /* FlowAPI_h */
