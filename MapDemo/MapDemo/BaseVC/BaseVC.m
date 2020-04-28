//
//  BaseVC.m
//  MapDemo
//
//  Created by zhouzhongmao on 2019/10/18.
//  Copyright © 2019 zhouzhongmao. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = RGB(235, 235, 235);
}
- (void)setLeftItemWithIcon:(NSString *)imageName title:(NSString *)title selector:(SEL)selector {
    UINavigationItem *item = self.navigationItem;
    if (title.length == 0) {
        UIImage *image = [UIImage imageNamed:imageName];
        //用图片最原始的模式
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:selector];
        item.leftBarButtonItem= leftItem;
    }else {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
        [leftItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName,nil] forState:UIControlStateNormal];
        leftItem.tintColor = RGB(248, 75, 42);
        //设置右边的item
        item.leftBarButtonItem = leftItem;
    }
}
- (void)setRightItemWithIcon:(NSString *)imageName andTitle:(NSString*)title selector:(SEL)selector {
    UINavigationItem *item = self.navigationItem;
    if (title.length == 0) {
        UIImage *image = [UIImage imageNamed:imageName];
        //用图片最原始的模式
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:selector];
        item.rightBarButtonItem = rightItem;
        
    }else {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
        [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName,nil] forState:UIControlStateNormal];
        //        rightItem.tintColor = RGB(248, 75, 42);
        rightItem.tintColor = [UIColor blackColor];
        //设置右边的item
        item.rightBarButtonItem = rightItem;
    }
    
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
