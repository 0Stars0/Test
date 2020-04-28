
//
//  APIUrl.h
//  LSZXDriver
//
//  Created by zhouzhongmao on 2019/9/10.
//  Copyright © 2019 zhouzhongmao. All rights reserved.
//

#ifndef APIUrl_h
#define APIUrl_h

//真实
#define MAIN_DOMAIN @"http://spl.6scx.com:9180"
//测试
//#define MAIN_DOMAIN @"http://47.103.151.194:9180"
#define API_GET(api) [MAIN_DOMAIN stringByAppendingString:api]


//登录注册相关
#define API_REGIST_SENDMSG API_GET(@"/api/member/getMsg")//注册验证码
#define API_REGIST API_GET(@"/api/member/registerMember")//注册
#define API_LOGIN API_GET(@"/api/member/loginMember")//登录

//首页
#define API_BC_APPLY API_GET(@"/api/bc/applyShift")//申请班次


//个人中心
#define API_USER_INFO API_GET(@"/api/member/inquireMemberById")//个人信息
#define API_EDIT_NICKNANE API_GET(@"/api/member/changeUsername")//修改昵称


#define API_INFO_SMRZ API_GET(@"/api/member/checkMember")//实名认证

#define API_CAR_LIST API_GET(@"/api/car/getAllCarModels")//汽车品牌列表
#define API_CAR_OWEN API_GET(@"/api/driver/carCheck")//车主认证信息提交
#define API_CAR_DRIVE_CHECK API_GET(@"/api/car/driverCheck")//车主认证信息查询
#define API_PICTURE_UPLOAD API_GET(@"/api/picture/toUploadPic2Json")//上传图片返回图片地址

//修改手机号
#define API_GETMSG API_GET(@"/api/msg/getImpMsg")//获取修改重要信息验证码
#define API_CHANGE_PHONE API_GET(@"/api/member/changePhone")//修改手机号
#define API_EDIT_PASSWORD API_GET(@"/api/member/changePwd")//修改登录密码
#define API_RESET_PASSWORD API_GET(@"/api/member/resetPwd")//重置登录密码

//
#define API_SEARCH_LINE API_GET(@"/api/order/queryAllDirections")//线路查询
#define API_HOME_LINE API_GET(@"/api/order/lookForAddress")//首页获取已开线路
#define API_SUB_ORDER API_GET(@"/api/order/bookSeat")//预定生产订单
#define API_QIANMING_ORDER API_GET(@"/api/pay/apppay")//生成签名订单
#define API_MY_ORDER API_GET(@"/api/order/checkItiner")//我的行程
#define API_CANCEL_ORDER API_GET(@"/api/order/cancelOrder")//我的行程
#define API_QUXIAO_ORDER API_GET(@"/api/order/cancelOrder")//取消订单
#define API_XIEYI API_GET(@"/api/page/getLince")//所以协议
#define API_XT_XX API_GET(@"/api/notice/querySystemMessages")//系统消息
#define API_DD_XX API_GET(@"/api/notice/queryUserOrderNotifications")//订单
#define API_NEWS API_GET(@"/api/notice/queryMessagesAndNotifications")//消息


#define API_MY_QIANBAO API_GET(@"/api/member/checkAccountBalance")//我的钱包
#define API_MY_JYJL API_GET(@"/api/order/queryTransactionInformation")//交易记录



#endif /* APIUrl_h */
