//
//  QuanziViewController.m
//  iOSBase
//
//  Created by 冷婷 on 2019/1/3.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "QuanziViewController.h"
#import <SDCycleScrollView.h>
#import "TitleTopScrollView.h"
#import "GoodsColCell.h"
@interface QuanziViewController () <SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate, UITableViewDataSource>
{
    NSInteger currentIndex;
    NSString *identify;
    NSMutableArray *dataSource;
}
@property (strong, nonatomic)SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)TitleTopScrollView    *typeView;
@property (nonatomic, strong) NSMutableArray *tableViewArr;
@property (nonatomic, strong) UIScrollView    *listContentView;
@property (nonatomic,assign) BOOL isDragging;
@end

@implementation QuanziViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圈子";
    [self.view addSubview:self.cycleScrollView];
    [self addTopView];
    [self addScrollerView];
}

- (void)addTopView {
    _typeView = [[TitleTopScrollView alloc] initWithFrame:CGRectMake(0, 200, 320, 50) withRow:3];
    [_typeView addItemData:@[@"预告",@"报名",@"往期"]];
    MJWeakSelf
    _typeView.block = ^(NSString *title,NSInteger index){
        [weakSelf didChangeToIndex:index byClick:NO];
    };
    [self.view addSubview:_typeView];
}

#pragma mark - 自定义滑动视图
- (void)addScrollerView {
    identify = @"WangqiTabCell";
    _tableViewArr = [[NSMutableArray alloc] init];
    //初始化数据
    dataSource = [NSMutableArray array];
    [self.view addSubview:self.listContentView];
    self.listContentView.contentSize = CGSizeMake(self.listContentView.bounds.size.width * 3, self.listContentView.bounds.size.height);
    self.listContentView.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < 3; i++) {
        if (i == 2) {
            UITableView  *cutableView = [[UITableView alloc] initWithFrame:CGRectMake(i * self.listContentView.bounds.size.width, 0, self.listContentView.bounds.size.width, self.listContentView.bounds.size.height) style:UITableViewStyleGrouped];
            cutableView.dataSource = self;
            cutableView.delegate = self;
            cutableView.tag = i+100;
            cutableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self.listContentView addSubview:cutableView];
            [_tableViewArr addObject:cutableView];
            
            if([cutableView    respondsToSelector:@selector(setSeparatorInset:)]){
                [cutableView   setSeparatorInset:UIEdgeInsetsZero];
            }
            
            if([cutableView   respondsToSelector:@selector(setLayoutMargins:)]){
                [cutableView    setLayoutMargins:UIEdgeInsetsZero];
            }
        }else {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.itemSize = CGSizeMake((KScreenWidth-100)/2, (KScreenWidth-100)/2+40);
            layout.minimumInteritemSpacing = 25;
            layout.minimumLineSpacing = 25;
            UICollectionView *_collection = [[UICollectionView alloc] initWithFrame:CGRectMake(i * self.listContentView.bounds.size.width, 0, self.listContentView.bounds.size.width, self.listContentView.bounds.size.height) collectionViewLayout:layout];
            _collection.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            _collection.tag = i+100;
            _collection.showsHorizontalScrollIndicator = NO;
            _collection.backgroundColor = [UIColor whiteColor];
            _collection.dataSource = self;
            _collection.delegate = self;
            [_collection registerNib:[UINib nibWithNibName:@"GoodsColCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
            [self.listContentView addSubview:_collection];
            [_tableViewArr addObject:_collection];
        }
    }
}


- (UIScrollView*)listContentView {
    if (!_listContentView) {
        _listContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _typeView.mj_h+_typeView.mj_y, KScreenWidth, KScreenHeight-_typeView.mj_h-_typeView.mj_y-navHeight)];
        _listContentView.showsHorizontalScrollIndicator = NO;
        _listContentView.showsVerticalScrollIndicator = NO;
        _listContentView.pagingEnabled = YES;
        _listContentView.bounces = NO;
        _listContentView.delegate = self;
        _listContentView.backgroundColor = [UIColor clearColor];
        _listContentView.directionalLockEnabled = YES;
    }
    return _listContentView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"me_background"]];
    cell.titleLab.text = @"低功耗";
    return cell;
}

//设置单元格的起始位置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(25, 25, 25, 25);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = @"哈哈死光光大股东郭德纲";
    cell.detailTextLabel.text = @"哈哈死光光大股东郭德纲";
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"me_background"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 10)];
    v.backgroundColor = [UIColor whiteColor];
    return v;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark - UIScrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == _listContentView) {
        _isDragging = YES;
    }
    [self.view endEditing:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == _listContentView && !decelerate) {
        _isDragging = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_isDragging && scrollView == _listContentView) {
        [_typeView refreshBottomPosition:scrollView.contentOffset.x / scrollView.bounds.size.width];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _listContentView){
        _isDragging = NO;
        NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width ;
        [self didChangeToIndex:index byClick:NO];
    }
}


- (void)didChangeToIndex:(NSInteger)index byClick:(BOOL)bClick {
    if (index >= _tableViewArr.count)
        return;
    [self.listContentView setContentOffset:CGPointMake(index * self.listContentView.bounds.size.width, 0) animated:YES];
    currentIndex = index;
    //加载数据
//    [self requestListData];
}

- (SDCycleScrollView *)cycleScrollView {
    NSArray *imgAry = @[@"https://mmbiz.qpic.cn/mmbiz_png/hQzuHPqO7rRltV1VwMWNXnKA2JnBjXHO4icMYslyvraxntuzicQ1W4IEypCciaxibjibCBWVadPZeBUj71Fib6XVvYaw/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1",@"https://mmbiz.qpic.cn/mmbiz_png/hQzuHPqO7rSUvxPV8MYnwRsEGyDz8cLyg42nGvqiaP6vzsqIgGKUCGap05VtQWaHXY3JOtrLCkibsXHZkxVd4hrQ/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1"];
    if (!_cycleScrollView) {/**<创建不带标题的图片轮播器*/
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,KScreenWidth,200) imageURLStringsGroup:imgAry];/**<创建轮播图且赋值*/
        _cycleScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _cycleScrollView.delegate = self;
        _cycleScrollView.hidesForSinglePage = YES;
        if (imgAry.count == 1) {
            _cycleScrollView.autoScroll = NO;
        }
        /**<轮播时间间隔，默认1.0秒，可自定义*/
        _cycleScrollView.autoScrollTimeInterval = 2;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    }
    return _cycleScrollView;
}

#pragma mark - 点击轮播图片的回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
