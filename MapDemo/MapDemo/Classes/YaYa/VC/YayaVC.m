//
//  YayaVC.m
//  MapDemo
//
//  Created by zhouzhongmao on 2019/12/12.
//  Copyright © 2019 zhouzhongmao. All rights reserved.
//

#import "YayaVC.h"
#import "YayaCell0.h"
#import "YayaCell1.h"
#import "ULBCollectionViewFlowLayout.h"

@interface YayaVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,ULBCollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation YayaVC

- (void)viewDidLoad {
    [super viewDidLoad];
        self.title = @"地图demo";
    [self setLeftItemWithIcon:@"nav_back" title:@"" selector:@selector(leftItemPressed:)];
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        ULBCollectionViewFlowLayout *layout = [[ULBCollectionViewFlowLayout alloc]init];
        layout.flowDelegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 0, kScreenWidth, kScreenHeight-kSafeAreaBottomHeight-NavHeight)) collectionViewLayout:layout];
        _collectionView.backgroundColor = RGB(241, 241, 241);
        _collectionView.showsVerticalScrollIndicator  = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[YayaCell0 class] forCellWithReuseIdentifier:@"YayaCell0"];
        [_collectionView registerClass:[YayaCell1 class] forCellWithReuseIdentifier:@"YayaCell1"];
    }
    return _collectionView;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YayaCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YayaCell1" forIndexPath:indexPath];
        return cell;
    }else{
        YayaCell0 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YayaCell0" forIndexPath:indexPath];
        return cell;
    }
    
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 8;
    }
    
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        return UIEdgeInsetsMake(10, 0, 0, 0);
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeZero;
    if (indexPath.section == 0) {
        size =  CGSizeMake(kScreenWidth, 142);
    }else{
        size =  CGSizeMake(kScreenWidth, 160);
    }
    
    return size;
}
//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
    
}
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section {
    return [UIColor clearColor];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)leftItemPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
