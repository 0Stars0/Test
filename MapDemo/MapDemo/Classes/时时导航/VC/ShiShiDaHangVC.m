//
//  ShiShiDaHangVC.m
//  MapDemo
//
//  Created by zhouzhongmao on 2020/1/1.
//  Copyright © 2020 zhouzhongmao. All rights reserved.
//

#import "ShiShiDaHangVC.h"
#import "LineVC.h"
#import "ShiShiVC.h"

@interface ShiShiDaHangVC ()<AMapNaviDriveManagerDelegate, AMapNaviDriveViewDelegate,AMapNaviDriveDataRepresentable>

@property (nonatomic, strong) AMapNaviDriveView *driveView;

@property (nonatomic,strong) AMapNaviRoute *naviRoute;

@property(nonatomic,assign)NSInteger  routeID;

@end

@implementation ShiShiDaHangVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"时时导航";
    [self setLeftItemWithIcon:@"nav_back" title:@"" selector:@selector(leftItemPressed:)];
    [self setRightItemWithIcon:@"" andTitle:@"路径规划" selector:@selector(rightItemPressed)];
    [[AMapNaviDriveManager sharedInstance] setDelegate:self];

       //初始化AMapNaviDriveView
       if (self.driveView == nil)
       {
           self.driveView = [[AMapNaviDriveView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-NavHeight)];
           [self.driveView setShowUIElements:NO];
//           self.driveView.showTrafficLayer = NO;
           self.driveView.showCrossImage = NO;
           [self.driveView setDelegate:self];
       }

          //将AMapNaviManager与AMapNaviDriveView关联起来
       [[AMapNaviDriveManager sharedInstance] addDataRepresentative:self.driveView];
    [[AMapNaviDriveManager sharedInstance] addDataRepresentative:self];
          //将AManNaviDriveView显示出来
       [self.view addSubview:self.driveView];
    [self.driveView setEndPointImage:[UIImage imageNamed:@"hone_icon_fujinr"]];
    


}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //路径规划
    [[AMapNaviDriveManager sharedInstance] calculateDriveRouteWithStartPoints:@[self.startPoint]
                                                                    endPoints:@[self.endPoint]
                                                                    wayPoints:nil
                                                              drivingStrategy:AMapNaviDrivingStrategySinglePrioritiseDistance];

}
//路径规划成功后，开始模拟导航
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    AMapNaviRoute *naviRoute = driveManager.naviRoute;
//    NSLog(@"==%@",driveManager.naviRoutes);
    NSArray *routeCoordinates = naviRoute.routeCoordinates;
    NSMutableArray *arr = [NSMutableArray new];
    for (AMapNaviPoint *point in routeCoordinates) {
        NSLog(@"=====<%f  , %f>",point.latitude,point.longitude);
        [arr addObject:@{@"latitude":[NSString stringWithFormat:@"%f",point.latitude],@"longitude":[NSString stringWithFormat:@"%f",point.longitude]}];
    }
    NSLog(@"%@",arr);

    self.naviRoute = naviRoute;
//    - (nullable NSArray<AMapNaviGuide *> *)getNaviGuideList
    NSLog(@"routeUID=%ld",naviRoute.routeUID);
    self.routeID = naviRoute.routeUID;
    NSArray<AMapNaviGuide *> * naviGuide= [driveManager getNaviGuideList];
//    NSLog(@"==%@",naviGuide);
    NSLog(@"==%ld",self.routeID);
    [[AMapNaviDriveManager sharedInstance] startGPSNavi];

//[[AMapNaviDriveManager sharedInstance] selectNaviRouteWithRouteID:2975578008];
//    [[AMapNaviDriveManager sharedInstance] startEmulatorNavi];
//    [[AMapNaviDriveManager sharedInstance] selectNaviRouteWithRouteID:4026991463];
}
- (void)driveManagerNeedRecalculateRouteForYaw:(AMapNaviDriveManager *)driveManager{
    [QMUITips showInfo:@"偏航"];
}
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateNaviInfo:(AMapNaviInfo *)naviInfo{

//    [self showToastInView:self.view message:[NSString stringWithFormat:@"行驶里程%ldm\n行驶时间%ld秒",naviInfo.routeDriveDistance,naviInfo.routeDriveTime] duration:1];
    
    
}
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateCruiseInfo:(nullable AMapNaviCruiseInfo *)cruiseInfo{
//    _la1.text = [NSString stringWithFormat:@"连续启用时间%ld秒\n",cruiseInfo.cruisingDriveTime];
    [QMUITips showInfo:[NSString stringWithFormat:@"连续启用时间%ld秒\n",cruiseInfo.cruisingDriveTime]];
}
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateNaviLocation:(nullable AMapNaviLocation *)naviLocation{
    [QMUITips showInfo:[NSString stringWithFormat:@"速度=%ld",naviLocation.speed]];
}
-(void)rightItemPressed{
//    LineVC *vc = [[LineVC alloc]init];
//    vc.naviRoute = self.naviRoute;
//    [self.navigationController pushViewController:vc animated:YES];
    ShiShiVC *vc = [[ShiShiVC alloc]init];
    vc.routeID = self.routeID;
    [self.navigationController pushViewController:vc animated:YES];
}
//- (BOOL)driveManagerIsNaviSoundPlaying:(AMapNaviDriveManager *)driveManager
//{
//    return [[SpeechSynthesizer sharedSpeechSynthesizer] isSpeaking];
//}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
    
//    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
}
- (void)dealloc
{
    [[AMapNaviDriveManager sharedInstance] stopNavi];
    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
    [[AMapNaviDriveManager sharedInstance] setDelegate:nil];
    
    BOOL success = [AMapNaviDriveManager destroyInstance];
    NSLog(@"单例是否销毁成功 : %d",success);
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}
- (void)leftItemPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
