//
//  AppDelegate.m
//  GKHelpOutApp
//
//  Created by kky on 2019/2/19.
//  Copyright © 2019年 kky. All rights reserved.
//
#import "WXApi.h"
#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //初始化window
    [self initWindow];
    
    //UMeng初始化
    [self initUMeng];
    
    //初始化app服务
    [self initService];
    
    //初始化IM
    [[IMManager sharedIMManager] initIM];
    
    //初始化用户系统
    [self initUserManager];
    
    //网络监听
    [self monitorNetworkStatus];
    
    [self registerThirdParty];
    
    
    //显示环境
#ifdef DEBUG
    [self showURL];
#else
    
#endif
    
    //广告页
//    [AppManager appStart];
    //[WXApi registerApp:@"wx21aed62551567801"];
    
    
    
    return YES;
    
}

#pragma mark - 显示debug下程序运行环境
-(void)showURL{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth-100,0,50,20)];
    label.font = FontOfSize(10);
    label.textColor = [UIColor redColor];
    if (DevelopSever) {
        label.text = @"开发环境";
    } else if (TestSever){
        label.text = @"测试环境";
    } else if (ProductSever){
        label.text = @"生产环境";
    }
    [window addSubview:label];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
