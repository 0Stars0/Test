//
//  DianJuHeVC.m
//  MapDemo
//
//  Created by zhouzhongmao on 2019/10/31.
//  Copyright © 2019 zhouzhongmao. All rights reserved.
//

#import "DianJuHeVC.h"
#import "CoordinateQuadTree.h"
#import "CustomCalloutView.h"
#import "ClusterAnnotation.h"
#import "CustomCalloutView.h"
#import "ClusterAnnotationView.h"

#define kCalloutViewMargin  -12
#define Button_Height       70.0

@interface DianJuHeVC ()<MAMapViewDelegate, AMapSearchDelegate,CustomCalloutViewTapDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) UIButton *refreshButton;

@property (nonatomic, strong) CoordinateQuadTree* coordinateQuadTree;

@property (nonatomic, strong) CustomCalloutView *customCalloutView;

@property (nonatomic, strong) NSMutableArray *selectedPoiArray;

@property (nonatomic, assign) BOOL shouldRegionChangeReCalculate;

@property (nonatomic, strong) AMapPOIKeywordsSearchRequest *currentRequest;

@property (nonatomic, strong) dispatch_queue_t queue;


@end

@implementation DianJuHeVC

- (id)init
{
    if (self = [super init])
    {
        self.coordinateQuadTree = [[CoordinateQuadTree alloc] init];
        
        self.selectedPoiArray = [[NSMutableArray alloc] init];
        
        self.customCalloutView = [[CustomCalloutView alloc] init];
        
        self.queue = dispatch_queue_create("quadQueue", DISPATCH_QUEUE_SERIAL);
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"点聚合";
    [self setLeftItemWithIcon:@"nav_back" title:@"" selector:@selector(leftItemPressed:)];
    [self initMapView];
        
    [self initSearch];
        
    [self initRefreshButton];
        
    _shouldRegionChangeReCalculate = NO;
    [self searchPoiWithKeyword:@"超市"];
}
#pragma mark - SearchPOI

/* 搜索POI. */
- (void)searchPoiWithKeyword:(NSString *)keyword
{
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = keyword;
    request.city                = @"010";
    request.requireExtension    = YES;
    
    self.currentRequest = request;
    [self.search AMapPOIKeywordsSearch:request];
}

/* POI 搜索回调. */

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    // 只处理最新的请求
    if (request != self.currentRequest)
    {
        return;
    }
    
    @synchronized(self)
    {
        self.shouldRegionChangeReCalculate = NO;
        
        // 清理
        [self.selectedPoiArray removeAllObjects];
        [self.customCalloutView dismissCalloutView];
        
        NSMutableArray *annosToRemove = [NSMutableArray arrayWithArray:self.mapView.annotations];
        [annosToRemove removeObject:self.mapView.userLocation];
        [self.mapView removeAnnotations:annosToRemove];
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(self.queue, ^{
            /* 建立四叉树. */
            [weakSelf.coordinateQuadTree buildTreeWithPOIs:response.pois];
            weakSelf.shouldRegionChangeReCalculate = YES;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf addAnnotationsToMapView:weakSelf.mapView];
            });
        });
    }

}
- (void)addAnnotationsToMapView:(MAMapView *)mapView
{
    @synchronized(self)
    {
        if (self.coordinateQuadTree.root == nil || !self.shouldRegionChangeReCalculate)
        {
            NSLog(@"tree is not ready.");
            return;
        }
        
        /* 根据当前zoomLevel和zoomScale 进行annotation聚合. */
        MAMapRect visibleRect = self.mapView.visibleMapRect;
        double zoomScale = self.mapView.bounds.size.width / visibleRect.size.width;
        double zoomLevel = self.mapView.zoomLevel;
        
        /* 也可根据zoomLevel计算指定屏幕距离(以50像素为例)对应的实际距离 进行annotation聚合. */
        /* 使用：NSArray *annotations = [weakSelf.coordinateQuadTree clusteredAnnotationsWithinMapRect:visibleRect withDistance:distance]; */
        //double distance = 50.f * [self.mapView metersPerPointForZoomLevel:self.mapView.zoomLevel];
        
        __weak typeof(self) weakSelf = self;
        dispatch_barrier_async(self.queue, ^{
            
            NSArray *annotations = [weakSelf.coordinateQuadTree clusteredAnnotationsWithinMapRect:visibleRect
                                                                                    withZoomScale:zoomScale
                                                                                     andZoomLevel:zoomLevel];
            dispatch_async(dispatch_get_main_queue(), ^{
                /* 更新annotation. */
                [weakSelf updateMapViewAnnotationsWithAnnotations:annotations];
            });
        });
    }
}
/* 更新annotation. */
- (void)updateMapViewAnnotationsWithAnnotations:(NSArray *)annotations
{
    /* 用户滑动时，保留仍然可用的标注，去除屏幕外标注，添加新增区域的标注 */
    NSMutableSet *before = [NSMutableSet setWithArray:self.mapView.annotations];
    [before removeObject:[self.mapView userLocation]];
    NSSet *after = [NSSet setWithArray:annotations];
    
    /* 保留仍然位于屏幕内的annotation. */
    NSMutableSet *toKeep = [NSMutableSet setWithSet:before];
    [toKeep intersectSet:after];
    
    /* 需要添加的annotation. */
    NSMutableSet *toAdd = [NSMutableSet setWithSet:after];
    [toAdd minusSet:toKeep];
    
    /* 删除位于屏幕外的annotation. */
    NSMutableSet *toRemove = [NSMutableSet setWithSet:before];
    [toRemove minusSet:after];
    
    /* 更新. */
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mapView addAnnotations:[toAdd allObjects]];
        [self.mapView removeAnnotations:[toRemove allObjects]];
    });
}
#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    [self.selectedPoiArray removeAllObjects];
    [self.customCalloutView dismissCalloutView];
    self.customCalloutView.delegate = nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    ClusterAnnotation *annotation = (ClusterAnnotation *)view.annotation;

    for (AMapPOI *poi in annotation.pois)
    {
        [self.selectedPoiArray addObject:poi];
    }
    
    [self.customCalloutView setPoiArray:self.selectedPoiArray];
    self.customCalloutView.delegate = self;
    
    // 调整位置
    self.customCalloutView.frame = CGRectMake(0, 0, 200, 80);
    self.customCalloutView.center = CGPointMake(CGRectGetMidX(view.bounds), -CGRectGetMidY(self.customCalloutView.bounds) - CGRectGetMidY(view.bounds) - kCalloutViewMargin);
    
    
    [view addSubview:self.customCalloutView];
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self addAnnotationsToMapView:self.mapView];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[ClusterAnnotation class]])
    {
        /* dequeue重用annotationView. */
        static NSString *const AnnotatioViewReuseID = @"AnnotatioViewReuseID";
        
        ClusterAnnotationView *annotationView = (ClusterAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotatioViewReuseID];
        
        if (!annotationView)
        {
            annotationView = [[ClusterAnnotationView alloc] initWithAnnotation:annotation
                                                               reuseIdentifier:AnnotatioViewReuseID];
        }
        
        /* 设置annotationView的属性. */
        annotationView.annotation = annotation;
        annotationView.count = [(ClusterAnnotation *)annotation count];
//        annotationView.image = [UIImage imageNamed:@"hone_icon_fujinr"];
        /* 不弹出原生annotation */
        annotationView.canShowCallout = NO;
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - Refresh Button Action

- (void)refreshAction:(UIButton *)button
{
//    [self searchPoiWithKeyword:@"Apple"];
    [self searchPoiWithKeyword:@"超市"];
}
- (void)dealloc
{
    [self.coordinateQuadTree clean];
}

- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
//        self.mapView.allowsAnnotationViewSorting = NO;
        self.mapView.delegate = self;
    }
    
    self.mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - Button_Height);
    
    [self.view addSubview:self.mapView];
    
    self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
}

- (void)initSearch
{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}

- (void)initRefreshButton
{
    self.refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.refreshButton setFrame:CGRectMake(0, _mapView.frame.origin.y + _mapView.frame.size.height, _mapView.frame.size.width, Button_Height)];
    [self.refreshButton setTitle:@"重新加载数据" forState:UIControlStateNormal];
    [self.refreshButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    
    [self.refreshButton addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.refreshButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)leftItemPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
