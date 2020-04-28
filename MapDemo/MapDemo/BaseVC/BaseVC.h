//
//  BaseVC.h
//  MapDemo
//
//  Created by zhouzhongmao on 2019/10/18.
//  Copyright © 2019 zhouzhongmao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC : UIViewController

//导航栏右侧按钮
- (void)setRightItemWithIcon:(NSString *)imageName andTitle:(NSString*)title selector:(SEL)selector;

//导航栏右侧按钮
- (void)setLeftItemWithIcon:(NSString *)imageName title:(NSString *)title selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
