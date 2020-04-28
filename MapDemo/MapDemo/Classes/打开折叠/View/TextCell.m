//
//  TextCell.m
//  MapDemo
//
//  Created by zhouzhongmao on 2019/11/16.
//  Copyright © 2019 zhouzhongmao. All rights reserved.
//

#import "TextCell.h"

@interface TextCell ()

@property (nonatomic, strong) UIView *topView;
//
@property (nonatomic, strong) UIView *midView;
//
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *titleLa;

@property (nonatomic, strong) UIButton *downBtn;

@end

@implementation TextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"TextCell";
    //先从缓存池中找可重用的cell
    TextCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //没找到就创建
    if (cell == nil) {
        cell = [[TextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

//通过代码自定义cell需要重写以下方法,可以添加额外的控件.
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}
- (void)initUI {
    
    
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(83);
    }];

    _midView = [[UIView alloc]init];
    _midView.backgroundColor = [UIColor brownColor];
    [self addSubview:_midView];
    [_midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];

    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.midView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(45);
//        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
    }];
    _downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_downBtn addTarget:self action:@selector(btnpressed) forControlEvents:UIControlEventTouchUpInside];
    _downBtn.backgroundColor = [UIColor purpleColor];
    [self addSubview:_downBtn];
    [_downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
    }];
    
    
}
-(void)configDataModelisOpen:(BOOL)isOpen {
//    if (isOpen) {
//        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.midView.mas_bottom).offset(0);
//            make.left.mas_equalTo(self.mas_left).offset(0);
//            make.right.mas_equalTo(self.mas_right).offset(0);
//            make.height.mas_equalTo(45);
//            make.bottom.mas_equalTo(self.mas_bottom).offset(0);
//        }];
//    }
}
-(void)btnpressed{
//        [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.midView.mas_bottom).offset(0);
//            make.left.mas_equalTo(self.mas_left).offset(0);
//            make.right.mas_equalTo(self.mas_right).offset(0);
//            make.height.mas_equalTo(150);
//    //        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
//        }];
        [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(150);

        }];
    if (self.delegate && [self.delegate respondsToSelector:@selector(qqAction)]) {
        [self.delegate qqAction];
    }
}
@end
