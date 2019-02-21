//
//  TrackMapViewController.m
//  iOSBase
//
//  Created by wy on 2019/2/17.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "TrackMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "MASmoothPathTool.h"

@interface TrackMapViewController ()<MAMapViewDelegate>
@property(nonatomic,strong)NSMutableArray *trackAry;
@property (nonatomic, strong) MAPolyline *smoothedTrace;
@property(nonatomic,strong)MAMapView *mapView;
@end

@implementation TrackMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"轨迹";
    
    [AMapServices sharedServices].enableHTTPS = YES;
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    _mapView.zoomLevel = 12;
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
    r.showsHeadingIndicator = YES;///是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
    [_mapView updateUserLocationRepresentation:r];
    
    self.trackAry = [NSMutableArray array];
    if (self.locationar) {
        [self getTrack];
    }
}

- (void)getTrack {
    for (NSInteger i = 0; i< self.locationar.count; i++) {
        CLLocation * cl = self.locationar[i];
        MALonLatPoint *point = [[MALonLatPoint alloc] init];
//        point.lat = cl.coordinate.latitude;
//        point.lon = cl.coordinate.longitude;
//
        point.lat = cl.coordinate.latitude-0.003;
        point.lon = cl.coordinate.longitude +0.005;
        [self.trackAry addObject:point];
    }
    [self initSmoothedTrace];
}

- (void)initSmoothedTrace{
    MASmoothPathTool *tool = [[MASmoothPathTool alloc] init];
    tool.intensity = 5;
    tool.threshHold = 0.3;
    tool.noiseThreshhold = 5;
    self.trackAry = [NSMutableArray arrayWithArray:[tool pathOptimize:self.trackAry]];
    CLLocationCoordinate2D *pCoords = malloc(sizeof(CLLocationCoordinate2D) * self.trackAry.count);
    if(!pCoords) {
        return;
    }
    
    for(int i = 0; i < self.trackAry.count; ++i) {
        MALonLatPoint *p = [self.trackAry objectAtIndex:i];
        CLLocationCoordinate2D *pCur = pCoords + i;
        pCur->latitude = p.lat;
        pCur->longitude = p.lon;
        NSLog(@"%f,%f",p.lat,p.lon);
    }
    self.smoothedTrace = [MAPolyline polylineWithCoordinates:pCoords count:self.trackAry.count];
    NSInteger drawIndex = self.trackAry.count-1;
    
    self.smoothedTrace = [MAMultiPolyline polylineWithCoordinates:pCoords count:self.trackAry.count drawStyleIndexes:@[@(0), @(drawIndex)]];

    if(pCoords) {
        free(pCoords);
    }
    [self.mapView addOverlay:self.smoothedTrace];
    [self.mapView showOverlays:@[self.smoothedTrace] animated:NO];
}


#pragma mark - MAMapViewDelegate
#pragma <MAMapViewDelegate>
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
     if (overlay == self.smoothedTrace) {
        MAPolylineRenderer * polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:self.smoothedTrace];
        polylineRenderer.lineWidth = 10.f;
        polylineRenderer.strokeColor = [UIColor orangeColor];
       // [polylineRenderer setStrokeImage:[UIImage imageNamed:@"grasp_trace_line"]];
        return polylineRenderer;
    }
    return nil;
}
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout               = NO;
        annotationView.animatesDrop                 = NO;
        annotationView.draggable                    = NO;
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    //设置单机地图为地理围栏
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
