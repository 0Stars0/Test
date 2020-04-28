//
//  DaTouZhenVC.m
//  MapDemo
//
//  Created by zhouzhongmao on 2019/11/6.
//  Copyright © 2019 zhouzhongmao. All rights reserved.
//

#import "DaTouZhenVC.h"

@interface DaTouZhenVC ()<MAMapViewDelegate,AMapLocationManagerDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, strong) MAPointAnnotation *starPio;

@property (nonatomic, strong) MAPointAnnotation *endPio;

@end

@implementation DaTouZhenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"大头针";
    [self setLeftItemWithIcon:@"nav_back" title:@"" selector:@selector(leftItemPressed:)];
    [self.view addSubview:self.mapView];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];

    //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        self.locationManager.allowsBackgroundLocationUpdates = YES;
    }
    //开始持续定位
    [self.locationManager setLocatingWithReGeocode:YES];
    [self.locationManager startUpdatingLocation];
}
-(MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kSafeAreaBottomHeight)];
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        [_mapView setZoomLevel:16.5];

    }
    return _mapView;
}

-(AMapLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
//NSLog(@"reGeocode:%@", reGeocode);
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
    if (reGeocode)
      {
          NSLog(@"reGeocode:%@", reGeocode);
          
          self.starPio = [[MAPointAnnotation alloc] init];
          self.starPio.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
          self.starPio.title = @"从这里上车";
          self.starPio.subtitle = reGeocode.POIName;
          self.mapView.delegate = self;
          [self.mapView addAnnotation:self.starPio];
          [self.locationManager stopUpdatingLocation];
      }

}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState
   fromOldState:(MAAnnotationViewDragState)oldState{
    if (self.starPio == view.annotation) {
        NSLog(@"起点");
    }
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:view.center toCoordinateFromView:self.mapView];//这里
    NSLog(@"location:{lat:%f; lon:%f;}", touchMapCoordinate.latitude, touchMapCoordinate.longitude);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)leftItemPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
