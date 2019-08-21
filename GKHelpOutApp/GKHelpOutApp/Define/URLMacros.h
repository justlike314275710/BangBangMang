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

//聊天朋友圈
#define ChatServerUrl @"http://192.168.0.230:8087"

#elif TestSever

/**测试服务器*/
#define URL_main @"http://192.168.20.31:20000/shark-miai-service"

#define ServerDomain @"http://120.78.190.101:8084"
#define ServerUrl [NSString stringWithFormat:@"%@/ywgk-app-demo",ServerDomain]
#define EmallHostUrl @"http://qa.api.auth.prisonpublic.com"          //授权认证平台测试地址
#define ConsultationHostUrl @"http://qa.api.legal.prisonpublic.com"  //法律咨询
//聊天朋友圈
#define ChatServerUrl @"http://qa.api.chat.prisonpublic.com"

#elif ProductSever

/**生产服务器*/
#define URL_main @"http://192.168.20.31:20000/shark-miai-service"

#define ServerDomain @"https://www.yuwugongkai.com"
#define ServerUrl [NSString stringWithFormat:@"%@/ywgk-app",ServerDomain]
#define EmallHostUrl @"http://api.auth.prisonpublic.com"           //授权认证平台生产地址
#define ConsultationHostUrl @"http://120.79.67.25"

#define ChatServerUrl @"http://qa.api.chat.prisonpublic.com"

#endif



#pragma mark - ——————— 详细接口地址 ————————

//测试接口
//NSString *const URL_Test = @"api/recharge/price/list";
#define URL_Test @"/api/cast/home/start"

#pragma mark - ——————— 公共服务 ————————
//注册接口
#define URL_post_registe @"/users/of-mobile"
//获取验证码
#define URL_get_verification_code @"/sms/verification-codes"

//获取认证授权token // 刷新认证授权token
#define URL_get_oauth_token @"/oauth/token"

//校验短信验证码接口
#define URL_post_sms_verification @"/sms/verification-codes/verification"

//修改头像
#define URL_upload_avatar @"/users/me/avatar"

//修改昵称
#define URL_modify_nickname @"/users/me"

//修改手机号码
#define URL_modify_PhoneNumber @"/users/me/phone-number"

#pragma mark - ——————— 生活圈 ————————————————
//发布生活圈
#define URL_lifeCircle_release @"/customer/circleoffriends/release"

//获取我的生活圈列表
#define URL_myLifeCircle_List @"/customer/circleoffriends/getMyCircleoffriends"

//获取所有生活圈列表
#define URL_allLifeCircle_List @"/customer/circleoffriends/getCircleoffriends"
//获取别人生活圈列表
#define URL_otherLifeCircle_List @"/customer/circleoffriends/get-friend-circlefriend"
//获取某条生活圈详情
#define URL_LifeCircle_detail @"/customer/circleoffriends"
//评论某条生活圈
#define URL_LifeCircle_comment @"/customer/circleoffriends/comment"
//点赞某条生活圈
#define URL_LifeCircle_praise @"/customer/circleoffriends/praise"
//获取最新未看的生活圈
#define URL_LifeCircle_getNewest @"/customer/circleoffriends/get-circlefriend-newest"

//获取我的生活圈最新四张图片
#define URL_LifeCircle_getMyNewPicture @"/customer/circleoffriends/getNewPicture"

//获取用户头像
#define URL_get_userAvatar @"/users/by-username/avatar"

//添加好友
#define URL_friend_add @"/customer/customerfriend/add"
//删除好友关系
#define URL_friend_delete @"/customer/customerfriend/delete"
//根据手机号码查找好友
#define URL_get_customerFriend @"/customer/customerfriend/get-customer-friend"


//获取当前IM用户
#define URL_get_im_info @"/im/users/me"

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

#pragma mark —— ——————— 律师相关 ————————
#define URL_Lawyer_certification @"/lawyer/certification"
#define URL_Lawyer_profiles @"/lawyer/profiles"
//获取支付宝签名sign
#define URL_Lawyer_aliPayAuthSign @"/lawyer/alipay/auth/sign"
//绑定支付宝
#define URL_Lawyer_aliPayBind     @"/lawyer/alipay/bind"
//解绑支付宝
#define URL_Lawyer_aliPayUnBind   @"/lawyer/alipay/unbind"
//查询支付宝
#define URL_Lawyer_aliPayinfo     @"/lawyer/alipay"
//支付宝提现
#define URL_Lawyer_aliPaywithdrawal     @"/lawyer/withdrawal/alipay"

#pragma mark - ——————— 意见反馈 ————————
//新增加意见反馈
#define URL_feedbacks_add     @"/feedbacks"

#pragma mark - ——————— 法律咨询 ————————

#define URL_advice_processing  @"/lawyer/my/legal-advice/processing"
#endif /* URLMacros_h */
