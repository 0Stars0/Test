//
//  OrderVC.m
//  MapDemo
//
//  Created by zhouzhongmao on 2020/4/2.
//  Copyright © 2020 zhouzhongmao. All rights reserved.
//

#import "OrderVC.h"
#import "ZMScrollView.h"
#import "ZMTableView.h"
#import "OrderCell.h"

@interface OrderVC ()<MAMapViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation OrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
    }];
    [self setupScrollView];
    [self setupTableView];
}
-(MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] init];
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _mapView.delegate = self;
        _mapView.showsUserLocation = NO;
        _mapView.rotateEnabled = NO;
//        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        [_mapView setZoomLevel:16];
    }
    return _mapView;
}
#pragma mark - ScrollView视图
- (void)setupScrollView{
    
    ZMScrollView *scrollView = [[ZMScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(0, 0);
    scrollView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:scrollView];
    
    self.scrollView = scrollView;
    
    [self.scrollView addSubview:self.tableView];

}

#pragma mark - tableView视图
- (void)setupTableView{
    
    //20为状态栏高度；tableview设置的大小要和view的大小一致
    ZMTableView *tableView = [[ZMTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kSafeAreaBottomHeight-NavHeight) style:UITableViewStyleGrouped];
    
    self.tableView = tableView;

    tableView.rowHeight = 80;
    //tableview下移
    tableView.contentInset = UIEdgeInsetsMake(kScreenHeight-NavHeight-400, 0, 0, 0);
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.sectionHeaderHeight = 0.0;//消除底部空白
    tableView.sectionFooterHeight = 0.0;//消除底部空白
    
    [self.scrollView addSubview:tableView];
    
    //注册cell
    [_tableView registerClass:[OrderCell class] forCellReuseIdentifier:@"OrderCell"];
    
    //添加KVO监听
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}
#pragma mark - KVO 监听tableView的contentOffset属性（收缩头部视图）
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        CGPoint tableContenOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
        
//        if (tableContenOffset.y > -ScreenH*0.5) {
//
//            if (self.headerView.xds_y == 0) {
//                [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{ //0.15秒内做完改变frame的动画，动画效果匀速
//                    self.headerView.xds_y = -headerH;
//                } completion:nil];
//
//            }
//
//        }
//        if (tableContenOffset.y < -ScreenH*0.5) {
//
//            if (self.headerView.xds_y == -headerH) {
//                [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{ //0.15秒内做完改变frame的动画，动画效果匀速
//
//                    self.headerView.xds_y = 0;;
//                } completion:nil];
//
//            }
//        }
    }
    
}


#pragma mark - 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了cell");
    
    //点击后消除选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//#pragma mark - cell高度
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return cellH;
//}

#pragma mark - cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

#pragma mark - 每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
