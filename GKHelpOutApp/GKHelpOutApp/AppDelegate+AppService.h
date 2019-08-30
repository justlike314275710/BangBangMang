//
//  AppDelegate+AppService.h
//  MiAiApp
//
//  Created by kky on 2018/5/25.
//  Copyright © 2018年 kky. All rights reserved.
//

#import "AppDelegate.h"

#define ReplaceRootViewController(vc) [[AppDelegate shareAppDelegate] replaceRootViewController:vc]

/**
 包含第三方 和 应用内业务的实现，减轻入口代码压力
 */
@interface AppDelegate (AppService)

//初始化服务
-(void)initService;

//初始化 window
-(void)initWindow;

//初始化 UMeng
-(void)initUMeng;

//初始化用户系统
-(void)initUserManager;

//监听网络状态
- (void)monitorNetworkStatus;
//注册第三方库
- (void)registerThirdParty;

//单例
+ (AppDelegate *)shareAppDelegate;

/**
 当前顶层控制器
 */
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;

@end
