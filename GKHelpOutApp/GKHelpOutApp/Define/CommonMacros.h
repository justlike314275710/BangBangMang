//
//  CommonMacros.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/31.
//  Copyright © 2017年 徐阳. All rights reserved.
//

//全局标记字符串，用于 通知 存储

#ifndef CommonMacros_h
#define CommonMacros_h

#pragma mark - ——————— 用户相关 ————————
//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"

//自动登录成功
#define KNotificationAutoLoginSuccess @"KNotificationAutoLoginSuccess"

//被踢下线
#define KNotificationOnKick @"KNotificationOnKick"

//用户信息缓存 名称
#define KUserCacheName @"KUserCacheName"

//用户model缓存
#define KUserModelCache @"KUserModelCache"

//用户类型名称(是否是律师)
#define KUserStateName @"KUserStateName"
#define KUserLawModel @"KUserLawModel"


//用户公共服务信息缓存
#define KOauthCacheName @"KOauthCacheName"

//用户公共服务信息Model缓存
#define KOauthModelCache @"KOauthModelCache"

//用户律师认证信息存储
#define KLawyerModelCache @"KLawyerModelCache"

#define AppScheme @"gkytHelpApp"


#pragma mark - ——————— 订单状态相关 ————————
//新的订单
#define KNotificationNewOrderState @"KNotificationNewOrderState"
//订单状态改变
#define KNotificationOrderStateChange @"KNotificationOrderStateChange"

#pragma mark - ——————— 网络状态相关 ————————

//网络状态变化
#define KNotificationNetWorkStateChange @"KNotificationNetWorkStateChange"
//修改资料
#define KNotificationModifyDataChange    @"KNotificationModifyDataChange"
//个人中心界面变化
#define KNotificationMineDataChange    @"KNotificationMineDataDataChange"
//支付宝绑定结果通知
#define KNotificationBingAliPay        @"KNotificationBingAliPay"
//提现成功回调通知
#define KNotificationGetCashSuccess    @"KNotificationGetCashSuccess"

//刷新生活圈
#define KNotificationRefreshCirCle    @"KNotificationRefreshCirCle"
//刷新指定单元格
#define KNotificationRefreshCirCleIndex   @"KNotificationRefreshCirCleIndex"
//刷新生活圈红点
#define KNotificationRefreshTabbarDot @"KNotificationRefreshTabbarDot"
//刷新我的生活圈红点(有人点赞评论)
#define KNotificationMineRefreshDot @"KNotificationMineRefreshDot"



#define defultTager  999
#endif /* CommonMacros_h */
