//
//  AppDelegate.h
//  GKHelpOutApp
//
//  Created by kky on 2019/2/19.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"


/**
 这里面只做调用，具体实现放到 AppDelegate+AppService 或者Manager里面，防止代码过多不清晰
 */
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (assign, nonatomic) BOOL IS_NetWork; //是否有网

@property (strong, nonatomic) MainTabBarController *mainTabBar;


@end

