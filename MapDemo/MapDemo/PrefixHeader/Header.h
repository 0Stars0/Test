//
//  Header.h
//  ChatTool
//
//  Created by zhouzhongmao on 2019/6/28.
//  Copyright © 2019年 zhouzhongmao. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

//屏幕的frame 和宽高
#define kScreenFrame [UIScreen mainScreen].bounds
#define kScreenWidth kScreenFrame.size.width
#define kScreenHeight kScreenFrame.size.height
#define kScreenScale [UIScreen mainScreen].scale

#define EmotionKeyboardHeight 240


#define isIPhoneX_Xs (kScreenWidth == 375.0 && kScreenHeight == 812.0)
#define isIPhoneXR ((kScreenWidth == 414.0 && kScreenHeight == 896.0) && kScreenScale == 2.0)
#define isIPhoneXsMax ((kScreenWidth == 414.0 && kScreenHeight == 896.0) && kScreenScale == 3.0)
// iPhone X
#define  isIPhoneX (isIPhoneX_Xs || isIPhoneXR || isIPhoneXsMax ? YES : NO)
// Status bar height.
#define  NavHeight      (IPHONE_X ? 88.f : 64.f)
#define kSafeAreaBottomHeight (IPHONE_X ? 34.0 : 0.0)
#define HCONVER_VALUE(y) ceil((IPHONE_X ?(kScreenHeight-34-44):(kScreenHeight)) * y / 667)

#define CONVER_VALUE(x) ceil(kScreenWidth * x / 375)

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))



#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define kIsLogin    [USER_DEFAULT boolForKey:@"isLogin"]
#define kSession_key    [USER_DEFAULT stringForKey:@"sessionkey"]

#define kUid    [USER_DEFAULT stringForKey:@"id"]
#define kPhone    [USER_DEFAULT stringForKey:@"phone"]
#define kDic [USER_DEFAULT dictionaryForKey:@"loginDic"]
#define kVersion    [USER_DEFAULT stringForKey:@"Version"]
#define kType    [USER_DEFAULT stringForKey:@"type"]

#define kYJApp ((AppDelegate *)[UIApplication sharedApplication].delegate)

//颜色配置
#define RGB(r,g,b)      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define MAIN_COLOR RGB(59, 207, 68)
#define LINE_COLOR RGB(224,224,224)
#define COLOR_52 RGB(52,52,52)
#define COLOR_143 RGB(143,67,72)
#define COLOR_153 RGB(153,153,153)
#define COLOR_242 RGB(242,242,242)
#define COLOR_102 RGB(102,102,102)
#define Height_ContentStatusBar (isIPhoneX ?44.f:0.f)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define ISEmpty(s) [NSString isEmpty:s]

#define LRRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]




#define TCNotifi [NSNotificationCenter defaultCenter]

#define LSPAYMANAGER [LSPayManager shareManager]

#endif /* Header_h */
