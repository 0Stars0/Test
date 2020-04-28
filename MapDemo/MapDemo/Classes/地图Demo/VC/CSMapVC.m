//
//  CSMapVC.m
//  MapDemo
//
//  Created by zhouzhongmao on 2019/10/18.
//  Copyright © 2019 zhouzhongmao. All rights reserved.
//

#import "CSMapVC.h"


@interface CSMapVC ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;

@end

@implementation CSMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地图demo";
    [self setLeftItemWithIcon:@"nav_back" title:@"" selector:@selector(leftItemPressed:)];
    [self initUI];
}
-(void)initUI{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.userLocation.title = @"您的位置在这里";
    [self.mapView setZoomLevel:16.8 animated:YES];
    MAUserLocationRepresentation *represent = [[MAUserLocationRepresentation alloc] init];
    represent.showsAccuracyRing = YES;
    represent.showsHeadingIndicator = YES;
    represent.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
    represent.strokeColor = [UIColor lightGrayColor];;
    represent.lineWidth = 2.f;
    represent.image = [UIImage imageNamed:@"userPosition1"];
    [self.mapView updateUserLocationRepresentation:represent];
}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//
//    MAAnnotationView *userLocationView = [self.mapView viewForAnnotation:self.mapView.userLocation];
//    [UIView animateWithDuration:0.1 animations:^{
//
//        double degree = self.mapView.userLocation.heading.trueHeading - self.mapView.rotationDegree;
//        userLocationView.imageView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
//    }];
//}


#pragma mark - mapview delegate
- (void)mapViewRequireLocationAuth:(CLLocationManager *)locationManager
{
    [locationManager requestAlwaysAuthorization];
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!updatingLocation)
    {
        MAAnnotationView *userLocationView = [mapView viewForAnnotation:mapView.userLocation];
        [UIView animateWithDuration:0.1 animations:^{

            double degree = userLocation.heading.trueHeading - self.mapView.rotationDegree;
            userLocationView.imageView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
        }];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)leftItemPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
