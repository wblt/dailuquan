//
//  YundongViewController.m
//  iOSBase
//
//  Created by 冷婷 on 2019/1/3.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YundongViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface YundongViewController ()
@property(nonatomic,assign)BOOL isStart;// 开始记录
@property (weak, nonatomic) IBOutlet UIButton *walkBtn;
@property (weak, nonatomic) IBOutlet UIButton *runBtn;
@property (weak, nonatomic) IBOutlet UIButton *healthBtn;
@property (weak, nonatomic) IBOutlet UIButton *bikeBtn;
@property (weak, nonatomic) IBOutlet UIButton *startbtn;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property(nonatomic,assign)NSInteger seconds;
@property(nonatomic,strong) NSTimer *myTimer;

@property (nonatomic,strong)CMStepCounter *stepCounter;

@end

@implementation YundongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"运动";
    _seconds = 0;
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    UIBarButtonItem *rigthBarItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = rigthBarItem;
    
    // 1. 创建计步器
    self.stepCounter = [[CMStepCounter alloc]init];
    
    // 2. 开始计步
    
    /**
     *  开始计步
     *
     *  @param UpdatesToQueue 执行回调的队列
     *  @param updateOn       从第几步开始计算
     *  @param Handler        回调
     *
     */
    [self.stepCounter startStepCountingUpdatesToQueue:[NSOperationQueue mainQueue] updateOn:1 withHandler:^(NSInteger numberOfSteps, NSDate * _Nonnull timestamp, NSError * _Nullable error) {
        NSLog(@"%s",__func__);
        NSLog(@"%zd",numberOfSteps);
        
    }];
    
}

- (IBAction)walkAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    if (_isStart) {
        [SVProgressHUD showInfoWithStatus:@"您正在记录您现在的运动数据，请点击结束后再切换运动类型"];
        return;
    }
    sender.selected = !sender.selected;
    _runBtn.selected = NO;
    _healthBtn.selected = NO;
    _bikeBtn.selected = NO;
}

- (IBAction)runAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    if (_isStart) {
        [SVProgressHUD showInfoWithStatus:@"您正在记录您现在的运动数据，请点击结束后再切换运动类型"];
        return;
    }
    sender.selected = !sender.selected;
    _walkBtn.selected = NO;
    _healthBtn.selected = NO;
    _bikeBtn.selected = NO;
}
- (IBAction)healthWalkAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    if (_isStart) {
        [SVProgressHUD showInfoWithStatus:@"您正在记录您现在的运动数据，请点击结束后再切换运动类型"];
        return;
    }
    sender.selected = !sender.selected;
    _runBtn.selected = NO;
    _walkBtn.selected = NO;
    _bikeBtn.selected = NO;
}
- (IBAction)bikeAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    if (_isStart) {
        [SVProgressHUD showInfoWithStatus:@"您正在记录您现在的运动数据，请点击结束后再切换运动类型"];
        return;
    }
    sender.selected = !sender.selected;
    _runBtn.selected = NO;
    _healthBtn.selected = NO;
    _walkBtn.selected = NO;
}

- (IBAction)startAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        // 开始计时
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(start:) userInfo:nil repeats:YES];
        _isStart = YES;
    }else {
        // 结束计时
        _seconds = 0;
        [self.myTimer invalidate];
        self.myTimer = nil;
        _isStart = NO;
    }
}

-(void)start:(NSTimer *)timer{
    _seconds ++;
    self.timeLab.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",_seconds/3600,(_seconds%3600)/60,_seconds%60];
}

- (void)moreAction {
    
}

- (void)shareAction {
    
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
