//
//  HomeCell.m
//  MapDemo
//
//  Created by zhouzhongmao on 2019/10/18.
//  Copyright © 2019 zhouzhongmao. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell ()

@property (nonatomic, strong) UILabel *titleLa;

@end

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"HomeCell";
    //先从缓存池中找可重用的cell
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //没找到就创建
    if (cell == nil) {
        cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
 
    
    
    
    _titleLa = [[UILabel alloc]init];
    _titleLa.font = [UIFont systemFontOfSize:13];
    _titleLa.textColor = RGB(63, 63, 63);
    [self addSubview:_titleLa];
    [_titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
    UIImageView *rightImage = [[UIImageView alloc]init];
    rightImage.image = [UIImage imageNamed:@"mine_next"];
    [self addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.width.mas_equalTo(9);
        make.height.mas_equalTo(15);
    }];
    
    
        UIView *line1 = [[UIView alloc]init];
        line1.backgroundColor = RGB(230, 230, 230);
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(0);
            make.left.mas_equalTo(self.mas_left).offset(20);
            make.right.mas_equalTo(self.mas_right).offset(0);
            make.height.mas_equalTo(0.5);
        }];
}

- (void)configDataModel:(HomeModel*)model{
    _titleLa.text = model.title;

}
@end
