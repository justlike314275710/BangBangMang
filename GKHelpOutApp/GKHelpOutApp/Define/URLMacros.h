//
//  URLMacros.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//



#ifndef URLMacros_h
#define URLMacros_h


//内部版本号 每次发版递增
#define KVersionCode 1
/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever    0
#define TestSever       1
#define ProductSever    0

#if DevelopSever

/**开发服务器*/
#define URL_main @"http://192.168.20.31:20000/shark-miai-service"
#define ServerDomain @"http://120.78.190.101:8086"
#define ServerUrl [NSString stringWithFormat:@"%@/ywgk-app-auth",ServerDomain]
#define EmallUrl @"http://10.10.10.16:805"
#define EmallHostUrl @"http://192.168.0.230:8081"
#define ConsultationHostUrl @"http://192.168.0.230:8086"

#elif TestSever

/**测试服务器*/
#define URL_main @"http://192.168.20.31:20000/shark-miai-service"

#define ServerDomain @"http://120.78.190.101:8084"
#define ServerUrl [NSString stringWithFormat:@"%@/ywgk-app-demo",ServerDomain]
#define EmallHostUrl @"http://qa.api.auth.prisonpublic.com"          //授权认证平台测试地址
#define ConsultationHostUrl @"http://qa.api.legal.prisonpublic.com"  //法律咨询


#elif ProductSever

/**生产服务器*/
#define URL_main @"http://192.168.20.31:20000/shark-miai-service"

#define ServerDomain @"https://www.yuwugongkai.com"
#define ServerUrl [NSString stringWithFormat:@"%@/ywgk-app",ServerDomain]
#define EmallHostUrl @"http://api.auth.prisonpublic.com"           //授权认证平台生产地址
#define ConsultationHostUrl @"http://120.79.67.25"



#endif



#pragma mark - ——————— 详细接口地址 ————————

//测试接口
//NSString *const URL_Test = @"api/recharge/price/list";
#define URL_Test @"/api/cast/home/start"

#pragma mark - ——————— 公共服务 ————————
//获取验证码
#define URL_get_verification_code @"/users/%@/verification-codes/login"

//获取认证授权token
#define URL_get_oauth_token @"/oauth/token"


#pragma mark - ——————— 用户相关 ————————

//登录注册
#define URL_user_login @"/families/validTourist"


//自动登录
#define URL_user_auto_login @"/api/autoLogin"

//用户详情
#define URL_user_info_detail @"/api/user/info/detail"
//修改头像
#define URL_user_info_change_photo @"/api/user/info/changephoto"
//注释
#define URL_user_info_change @"/api/user/info/change"


#endif /* URLMacros_h */