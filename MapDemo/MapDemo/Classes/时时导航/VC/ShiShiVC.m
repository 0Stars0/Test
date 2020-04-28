//
//  ShiShiVC.m
//  MapDemo
//
//  Created by zhouzhongmao on 2020/1/2.
//  Copyright © 2020 zhouzhongmao. All rights reserved.
//

#import "ShiShiVC.h"

@interface ShiShiVC ()<AMapNaviDriveManagerDelegate, AMapNaviDriveViewDelegate>

@property (nonatomic, strong) AMapNaviDriveView *driveView;

@end

@implementation ShiShiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"时时导航";
    [self setLeftItemWithIcon:@"nav_back" title:@"" selector:@selector(leftItemPressed:)];
    NSLog(@"%ld",self.routeID);
    [[AMapNaviDriveManager sharedInstance] setDelegate:self];

    //初始化AMapNaviDriveView
    if (self.driveView == nil)
    {
        self.driveView = [[AMapNaviDriveView alloc] initWithFrame:self.view.bounds];
        [self.driveView setDelegate:self];
    }

       //将AMapNaviManager与AMapNaviDriveView关联起来
    [[AMapNaviDriveManager sharedInstance] addDataRepresentative:self.driveView];
       //将AManNaviDriveView显示出来
    [self.view addSubview:self.driveView];
    [[AMapNaviDriveManager sharedInstance] selectNaviRouteWithRouteID:self.routeID];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
