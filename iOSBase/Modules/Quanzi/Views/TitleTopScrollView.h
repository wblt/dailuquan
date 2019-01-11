/***************************************************************
 ***********
 *	湖南长沙阳环科技实业有限公司
 *	@Copyright (c) 2003-2017 yhcloud, Inc. All rights reserved.
 *
 *	@license http://www.yhcloud.com.cn/license/
 ***************************************************************
 ********/

//
//  TitleTopScrollView.h
//  iOSBase
//
//  Created by yanghuan on 2018/12/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^refreshTitleData)(NSString *title,NSInteger index);

@interface TitleTopScrollView : UIScrollView

@property(nonatomic,strong) NSArray *itemData;
@property(nonatomic,strong) NSArray *imageArray;
@property(nonatomic,assign) NSInteger row;
@property(nonatomic,copy) refreshTitleData block;

- (instancetype)initWithFrame:(CGRect)frame withRow:(NSInteger )row;
/**
 添加数据
 
 @param itemData   按钮标题
 */
-(void)addItemData:(NSArray *)itemData;

-(void)refreshBottomPosition:(NSInteger )index;


@end
