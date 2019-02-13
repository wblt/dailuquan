/***************************************************************
 ***********
 *	湖南长沙阳环科技实业有限公司
 *	@Copyright (c) 2003-2017 yhcloud, Inc. All rights reserved.
 *
 *	@license http://www.yhcloud.com.cn/license/
 ***************************************************************
 ********/

//
//  UserManager.h
//  Keepcaring
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeanManager : NSObject
/**
 *  创建单例对象
 *
 *  @return 返回创建的单例对象
 */
+ (BeanManager *)shareInstace;

// 解档
- (id) getBeanfromPath:(NSString *) path;

// 归档
- (void)setBean:(id ) model path:(NSString *)filePath;

// 删除
- (void)deleteFromPath:(NSString *)path;
@end
