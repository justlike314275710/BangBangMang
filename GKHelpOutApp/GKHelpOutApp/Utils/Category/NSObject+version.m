//
//  NSObject+version.m
//  PrisonService
//
//  Created by kky on 2018/11/28.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "NSObject+version.h"


@implementation NSObject (version)

+(void)save_forceLogoutFlag {
    
    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSString *key = [NSString stringWithFormat:@"%@_%@",localVersion,@"localVersion"];
    //是2.1.13 版本
    if ([key isEqualToString:forceLogoutKey]) {
              NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             [defaults setObject:@"1" forKey:[NSString stringWithFormat:@"%@",forceLogoutKey]];
            [defaults synchronize];
    }
}

+(BOOL)judgeIsforceLogout {
    BOOL flag = false;
    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSString *key = [NSString stringWithFormat:@"%@_%@",localVersion,@"localVersion"];
    //是2.1.13版本
    if ([key isEqualToString:forceLogoutKey]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *value = [defaults valueForKey:key];
        if (value) {
            flag = NO; //已经登陆过一次
        } else {
            flag = YES; //没有强制退出过,需要更新一次
        }
    } else {
        //不是2.1.13版本不需要强制退出
        flag = NO;
    }
    return flag;
}


+(BOOL)judegeIsVietnamVersion {
    
    BOOL isVietnam = false;
    NSArray *langArr = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"];
    
    NSString *language = langArr.firstObject;
    if ([language isEqualToString:@"vi-US"]||[language isEqualToString:@"vi-VN"]||[language isEqualToString:@"vi-CN"]) {
        isVietnam = YES;
    }
    return isVietnam;
}
@end
