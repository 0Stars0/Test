//
//  LineVC.m
//  MapDemo
//
//  Created by zhouzhongmao on 2020/1/2.
//  Copyright © 2020 zhouzhongmao. All rights reserved.
//

#import "LineVC.h"

@interface LineVC ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) NSArray *lines;


@end

@implementation LineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"时时导航";
    [self setLeftItemWithIcon:@"nav_back" title:@"" selector:@selector(leftItemPressed:)];
    [self initLines];
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    [self.mapView setZoomLevel:16.5];
    [self.view addSubview:self.mapView];
    [self.mapView addOverlays:self.lines];
}
- (void)initLines {
    NSMutableArray *arr = [NSMutableArray array];
    for (AMapNaviPoint *point in self.naviRoute.routeCoordinates) {
        NSLog(@"%f , %f",point.latitude,point.longitude);
    }
    NSLog(@"%ld",self.naviRoute.routeCoordinates.count);
    //line 1
    CLLocationCoordinate2D line1Points[self.naviRoute.routeCoordinates.count];
    for (int i = 0; i<self.naviRoute.routeCoordinates.count; i++) {
        AMapNaviPoint *point = self.naviRoute.routeCoordinates[i];
        line1Points[i].latitude = point.latitude;
        line1Points[i].longitude = point.longitude;
    }
    
    
    MAPolyline *line1 = [MAPolyline polylineWithCoordinates:line1Points count:self.naviRoute.routeCoordinates.count];
//    MAMultiPolyline *coloredPolyline = [MAMultiPolyline polylineWithCoordinates:line1Points count:self.naviRoute.routeCoordinates.count drawStyleIndexes:@[@1, @3]];
//    [arr addObject:coloredPolyline];
    [arr addObject:line1];
    
    
//    //line 2
//    CLLocationCoordinate2D line2Points[5];
//    line2Points[0].latitude = 39.938698;
//    line2Points[0].longitude = 116.275177;
//
//    line2Points[1].latitude = 39.966069;
//    line2Points[1].longitude = 116.289253;
//
//    line2Points[2].latitude = 39.944226;
//    line2Points[2].longitude = 116.306076;
//
//    line2Points[3].latitude = 39.966069;
//    line2Points[3].longitude = 116.322899;
//
//    line2Points[4].latitude = 39.938698;
//    line2Points[4].longitude = 116.336975;
//
//    MAPolyline *line2 = [MAPolyline polylineWithCoordinates:line2Points count:5];
//    [arr addObject:line2];
    
    self.lines = [NSArray arrayWithArray:arr];
}
#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.strokeColor = [UIColor blueColor];
        polylineRenderer.lineWidth   = 10.f;
        polylineRenderer.lineDashType = kMALineDashTypeNone;
        
        return polylineRenderer;
    }
    
    return nil;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}
- (void)leftItemPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
