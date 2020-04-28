//
//  ZMScrollView.m
//  MapDemo
//
//  Created by zhouzhongmao on 2020/4/2.
//  Copyright © 2020 zhouzhongmao. All rights reserved.
//

#import "ZMScrollView.h"
#import "ZMTableView.h"

@implementation ZMScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{

    //注意，这里是判断现在是在ScrollView的哪一个部分上
    int count = self.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    
    UIView *view = self.subviews[count];
    
    CGPoint viewPoint = [self convertPoint:point toView:view];
    
    if (viewPoint.y<0) {
        return nil;
    }
    
    return [super hitTest:point withEvent:event];
    
}

@end
