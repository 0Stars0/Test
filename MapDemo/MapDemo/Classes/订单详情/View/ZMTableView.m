//
//  ZMTableView.m
//  MapDemo
//
//  Created by zhouzhongmao on 2020/4/2.
//  Copyright © 2020 zhouzhongmao. All rights reserved.
//

#import "ZMTableView.h"

@implementation ZMTableView

- (void)setFrame:(CGRect)frame{

    frame.origin.x = 10;
    frame.size.width =kScreenWidth  - 20;

    [super setFrame:frame];
    
}

@end
