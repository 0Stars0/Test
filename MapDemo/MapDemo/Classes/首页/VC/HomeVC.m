//
//  HomeVC.m
//  MapDemo
//
//  Created by zhouzhongmao on 2019/10/18.
//  Copyright © 2019 zhouzhongmao. All rights reserved.
//

#import "HomeVC.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import "CSMapVC.h"
#import "DianJuHeVC.h"
#import "DaoHangVC.h"
#import "DaTouZhenVC.h"
#import "TextVC.h"
#import "YayaVC.h"
#import "ShiShiDaHangVC.h"
#import "XlghVC.h"
#import "OrderVC.h"

@interface HomeVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self.view addSubview:self.tableView];
}
- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0.5, kScreenWidth, kScreenHeight-kSafeAreaBottomHeight-NavHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"HomeCell"];

    }
    return _tableView;
}
//返回表格某一行显示什么内容 cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeModel *model = self.dataSource[indexPath.row];
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configDataModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CSMapVC *vc = [[CSMapVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        DianJuHeVC *vc = [[DianJuHeVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        DaoHangVC *vc = [[DaoHangVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        DaTouZhenVC *vc = [[DaTouZhenVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4){
        TextVC *vc = [[TextVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 5){
        YayaVC *vc = [[YayaVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 6){
        AMapNaviPoint *startPoint   = [AMapNaviPoint locationWithLatitude:34.742281 longitude: 113.764224];
        AMapNaviPoint *endPoint   = [AMapNaviPoint locationWithLatitude:34.759197 longitude: 113.778584];
//        AMapNaviPoint *endPoint   = [AMapNaviPoint locationWithLatitude:34.0484 longitude: 113.778584];
        ShiShiDaHangVC *vc = [[ShiShiDaHangVC alloc]init];
        vc.startPoint = startPoint;
        vc.endPoint = endPoint;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 7){
        AMapNaviPoint *startPoint   = [AMapNaviPoint locationWithLatitude:34.74201199 longitude: 113.77701009];
        AMapNaviPoint *endPoint   = [AMapNaviPoint locationWithLatitude:34.0484 longitude: 113.778584];
        XlghVC *vc = [[XlghVC alloc]init];
//        vc.startPoint = startPoint;
//        vc.endPoint = endPoint;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 8){

            OrderVC *vc = [[OrderVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
    
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [HomeModel mj_objectArrayWithKeyValuesArray:@[@{@"title":@"地图demo"},@{@"title":@"点聚合"},@{@"title":@"导航"},@{@"title":@"大头针"},@{@"title":@"打开折叠"},@{@"title":@"yaya"},@{@"title":@"时时导航"},@{@"title":@"线路规划"},@{@"title":@"订单"}]];
    }
    return _dataSource;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)leftItemPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

