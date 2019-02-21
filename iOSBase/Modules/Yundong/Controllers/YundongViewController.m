//
//  YundongViewController.m
//  iOSBase
//
//  Created by 冷婷 on 2019/1/3.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YundongViewController.h"
#import "MotionDetector.h"
#import "TrackMapViewController.h"


CGFloat weight = 60;
BOOL humState=NO;

@interface YundongViewController ()
@property(nonatomic,assign)BOOL isStart;// 开始记录
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *walkBtn;
@property (weak, nonatomic) IBOutlet UIButton *runBtn;
@property (weak, nonatomic) IBOutlet UIButton *healthBtn;
@property (weak, nonatomic) IBOutlet UIButton *bikeBtn;
@property (weak, nonatomic) IBOutlet UIButton *startbtn;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property(nonatomic,assign)NSInteger seconds;
@property(nonatomic,strong)NSTimer *myTimer;
@property(nonatomic,strong)NSMutableArray *distancearray;
@property(nonatomic,assign)int StepCount;
@property (weak, nonatomic) IBOutlet UILabel *stepCountLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spendW;

@property (weak, nonatomic) IBOutlet UILabel *speedLab;
@property (weak, nonatomic) IBOutlet UILabel *powerLab;
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLab;


@property(nonatomic,strong)NSArray *locationar;

@end

@implementation YundongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"运动";
    _seconds = 0;
    self.distancearray = [NSMutableArray array];
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    UIBarButtonItem *rigthBarItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = rigthBarItem;
    
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
        [self state];
    }else {
        // 结束计时
        _seconds = 0;
        [self.myTimer invalidate];
        self.myTimer = nil;
        _isStart = NO;
        [[MotionDetector sharedInstance] stopDetection];
        _speedLab.text = @"_";
        _powerLab.text = @"_";
        _stepCountLab.text = @"_";
        _StepCount = 0;
        _distanceLab.text = @"_";
        [self.distancearray removeAllObjects];
        self.locationar = [NSArray array];
    }
}

-(void)start:(NSTimer *)timer{
    _seconds ++;
    self.timeLab.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",_seconds/3600,(_seconds%3600)/60,_seconds%60];
}

-(void)state
{
    [MotionDetector sharedInstance].motionTypeChange = ^(MotionType Type){
        if (Type==0) {
          // statelabel.text = @"开始运动吧!！";
        }
        if (Type==1) {
            
          //  statelabel.text = @"正在走路！";
        }
        if (Type==2) {
            
          //   statelabel.text = @"正在奔跑！";
        }
        if (Type==3) {
            
          //  statelabel.text = @"正在使用交通工具！";
        }
    };
    
    [MotionDetector sharedInstance].locationChange=^(CLLocationDistance meters,CGFloat speed, NSArray *locationarr){
        self.locationar = locationarr;
        _totalTimeLab.text = [NSString stringWithFormat:@"%.01f",(float)(_seconds/(60*60))];
        if (speed > 0) {
          _speedLab.text = [NSString stringWithFormat:@"%.2f", 1000/(speed*60)];
        }else {
        _speedLab.text = [NSString stringWithFormat:@"%.2f", speed];
        }
        _distanceLab.text = [NSString stringWithFormat:@"%.0fm",meters];
        [self.distancearray addObject:[NSNumber numberWithFloat:meters]];
        NSUInteger index = self.distancearray.count-1;
        NSLog(@"%lu",(unsigned long)self.distancearray.count);
        if (self.distancearray.count>2) {
            CGFloat kcalo = weight*meters/1000*1.036;
            _powerLab.text = [NSString stringWithFormat:@"%.2f",kcalo];
            CGFloat meter1 = [[self.distancearray objectAtIndex:index-1]floatValue];
            CGFloat meter2 = [[self.distancearray objectAtIndex:index]floatValue];
            CGFloat distance = meter2-meter1;
            if (humState == NO) {
                if (distance>0.8f) {
                    int number = distance/0.8;
                    _StepCount=_StepCount+number;
                    _stepCountLab.text = [NSString stringWithFormat:@"%d",_StepCount];
                    //animationview.image = [UIImage imageNamed:@"centerXin6"];
                }else{
                   // animationview.image = [UIImage imageNamed:@"centerXin1"];
                }
            }
        }
        
    };
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [MotionDetector sharedInstance].Ios7Available = YES;
    }
    
    [LocationManager sharedInstance].allowsBackground = YES;
    
    [[MotionDetector sharedInstance] startUpdate:^(BOOL humanState) {
        humState = humanState;
        if (humanState==YES) {
           // animationview.image = [UIImage imageNamed:@"centerXin6"];
            _StepCount++;
            _stepCountLab.text = [NSString stringWithFormat:@"%d",_StepCount];
        }else{
            //animationview.image = [UIImage imageNamed:@"centerXin1"];
        }
        
    }];
}

- (IBAction)trackAction:(id)sender {
    TrackMapViewController *vc = [[TrackMapViewController alloc] init];
    if (self.locationar.count > 0) {
        vc.locationar = self.locationar;
    }
    [self.navigationController pushViewController:vc animated:YES];
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
