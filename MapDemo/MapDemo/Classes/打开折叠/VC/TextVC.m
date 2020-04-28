//
//  TextVC.m
//  MapDemo
//
//  Created by zhouzhongmao on 2019/11/16.
//  Copyright © 2019 zhouzhongmao. All rights reserved.
//

#import "TextVC.h"
#import "TextCell.h"

@interface TextVC ()<UITableViewDataSource,UITableViewDelegate,TextCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) BOOL topOpen;

@end

@implementation TextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"打开折叠";
    [self setLeftItemWithIcon:@"nav_back" title:@"" selector:@selector(leftItemPressed:)];
    [self.view addSubview:self.tableView];
}
- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0.5, kScreenWidth, kScreenHeight-kSafeAreaBottomHeight-2*NavHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 180;
        [_tableView registerClass:[TextCell class] forCellReuseIdentifier:@"TextCell"];
    }
    return _tableView;
}
- (void)qqAction{
    [self.tableView reloadData];
}
//返回表格某一行显示什么内容 cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell configDataModelisOpen:_topOpen];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return 1;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)leftItemPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
