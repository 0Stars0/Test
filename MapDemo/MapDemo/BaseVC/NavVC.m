//
//  NavVC.m
//  MapDemo
//
//  Created by zhouzhongmao on 2019/10/18.
//  Copyright © 2019 zhouzhongmao. All rights reserved.
//

#import "NavVC.h"

@interface NavVC ()<UIGestureRecognizerDelegate>

@end

@implementation NavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg1"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    //    //设置标题字体大小与颜色
    //    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:RGB(0, 0, 0)}];
    
    
    //    UIGestureRecognizer  *gester = self.interactivePopGestureRecognizer;
    //    UIPanGestureRecognizer *panGesTer = [[UIPanGestureRecognizer alloc] initWithTarget:gester.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
    //
    //    [gester.view addGestureRecognizer:panGesTer];
    //
    //    gester.delaysTouchesBegan = YES;
    //
    //    panGesTer.delegate = self;
    //    // 关闭边缘触发手势 防止和原有边缘手势冲突
    //    [self.interactivePopGestureRecognizer setEnabled:NO];
    
    
    //    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //可以设置一些样式
    /*
     //设置了NO之后View自动下沉navigationBar的高度
     self.navigationBar.translucent = NO;
     //改变左右Item的颜色
     self.navigationBar.tintColor = [UIColor whiteColor];
     
     //改变title的字体样式
     NSDictionary *textAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName: FONT_SYSTEM_BOLD(18)};
     [self.navigationBar setTitleTextAttributes:textAttributes];
     //改变navBar的背景颜色
     [self.navigationBar setBarTintColor:[UIColor blueColor]];
     */
}
- (UIImage*)createImageWithColor: (UIColor*) color{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return theImage;
    
}
//重写这个方法，在跳转后自动隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers count] > 0){
        viewController.hidesBottomBarWhenPushed = YES;
        //可以在这里定义返回按钮等
        /*
         UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Login_icon_lift"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
         viewController.navigationItem.leftBarButtonItem = backItem;
         */
        //        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        button.tintColor = [UIColor clearColor];
        //        [button setImage:[UIImage imageNamed:@"Login_icon_lift"] forState:UIControlStateNormal];
        //        button.frame = CGRectMake(0, 0, 44, 22);
        //        // 让按钮内部的所有内容左对齐
        //        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //        // 修改导航栏左边的item
        //        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //一定要写在最后，要不然无效
    [super pushViewController:viewController animated:animated];
    //    CGRect rect = self.tabBarController.tabBar.frame;
    //    rect.origin.y = [UIScreen mainScreen].bounds.size.height - rect.size.height;
    //    self.tabBarController.tabBar.frame = rect;
}

- (void)back {
    [self popViewControllerAnimated:YES];
}
//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        if (self.childViewControllers.count == 1 ) {
            return NO;
        }
        
        if (self.interactivePopGestureRecognizer &&
            [[self.interactivePopGestureRecognizer.view gestureRecognizers] containsObject:gestureRecognizer]) {
            
            CGPoint tPoint = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
            
            if (tPoint.x >= 0) {
                CGFloat y = fabs(tPoint.y);
                CGFloat x = fabs(tPoint.x);
                CGFloat af = 30.0f/180.0f * M_PI;
                CGFloat tf = tanf(af);
                if ((y/x) <= tf) {
                    return YES;
                }
                return NO;
                
            }else{
                return NO;
            }
        }
    }
    
    return YES;
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
