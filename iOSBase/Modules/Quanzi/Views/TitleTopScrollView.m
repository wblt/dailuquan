/***************************************************************
 ***********
 *	湖南长沙阳环科技实业有限公司
 *	@Copyright (c) 2003-2017 yhcloud, Inc. All rights reserved.
 *
 *	@license http://www.yhcloud.com.cn/license/
 ***************************************************************
 ********/

//
//  TitleTopScrollView.m
//  iOSBase
//
//  Created by yanghuan on 2018/12/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TitleTopScrollView.h"
#define BTNTag  200
@interface TitleTopScrollView ()

@property(nonatomic,strong) UIButton *typeBtn;
@property(nonatomic,strong) UIButton *oldBtn;
@property(nonatomic,strong) UIView *bottomView; // 滑动条

@end
@implementation TitleTopScrollView

- (instancetype)initWithFrame:(CGRect)frame withRow:(NSInteger )row {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
		self.bounces = NO;
		self.pagingEnabled = NO;
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator   = NO;
		_row = row;
	}
	return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
		self.bounces = NO;
		self.pagingEnabled = NO;
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator   = NO;
	}
	return self;
}


-(void)addItemData:(NSArray *)itemData{
	_itemData   = itemData;
	
	[self configView];
}


-(void)configView{
	
	CGFloat btnW = self.frame.size.width/_row;
	CGFloat btnH =  50; //self.frame.size.width/_row;
	for (NSInteger i = 0; i< self.itemData.count; i++) {
		self.typeBtn  = [UIButton createCustomButtonWithFrame:CGRectMake(i*btnW, 0, btnW, btnH) title:self.itemData[i] backGroungColor:[UIColor whiteColor] titleColor:[UIColor blackColor] font:[UIFont systemFontOfSize:17]];
		[self.typeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
		self.typeBtn.adjustsImageWhenHighlighted = NO;
		self.typeBtn.tag     = i + BTNTag;
		
		if (i == 0 ) {
			self.typeBtn.selected = YES;
			_oldBtn = self.typeBtn;
		}
		[self.typeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:self.typeBtn];
	}
	self.contentSize = CGSizeMake(btnW*self.itemData.count,btnH);
	
//    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-2, self.frame.size.width/_row, 2)];
//    _bottomView.backgroundColor = [UIColor orangeColor];
//    [self addSubview:_bottomView];
	
	//	UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
	//	lineView.backgroundColor = UIColorFromHex(0xe5e5e6);
	//	[self addSubview:lineView];
	
}


-(void)btnClick:(UIButton *)sender{
	
	self.block(sender.titleLabel.text,sender.tag - BTNTag);
	
	if (_oldBtn != sender) {
		_oldBtn.selected = !_oldBtn.selected;
		sender.selected = !sender.selected;
	}
	_oldBtn = sender;
	[UIView animateWithDuration:0.25 animations:^{
		_bottomView.frame = CGRectMake((sender.tag - BTNTag)*(self.frame.size.width/_row),self.frame.size.height-2, self.frame.size.width/_row, 2);
	}];
}

- (void)refreshBottomPosition:(NSInteger)index {
	[UIView animateWithDuration:0.25 animations:^{
		_bottomView.frame = CGRectMake((index)*(self.frame.size.width/_row),self.frame.size.height-2, self.frame.size.width/_row, 2);
		UIButton *btn = [self viewWithTag:index + BTNTag];
		_oldBtn.selected = NO;
		btn.selected = YES;
		_oldBtn = btn;
	}];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
