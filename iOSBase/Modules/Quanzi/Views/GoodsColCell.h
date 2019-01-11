/***************************************************************
 ***********
 *	湖南长沙阳环科技实业有限公司
 *	@Copyright (c) 2003-2017 yhcloud, Inc. All rights reserved.
 *
 *	@license http://www.yhcloud.com.cn/license/
 ***************************************************************
 ********/

//
//  GoodsColCell.h
//  iOSBase
//
//  Created by yanghuan on 2018/12/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsColCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@end
