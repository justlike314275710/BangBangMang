//
//  NSObject+version.h
//  PrisonService
//
//  Created by kky on 2018/11/28.
//  Copyright © 2018年 calvin. All rights reserved.
//
/*
 每个版本不通的东西放在里面

 */

#import <Foundation/Foundation.h>
#define forceLogoutKey @"2.1.13_localVersion"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (version)
/***
//强制退出---2.1.13 版本如果版本更新后没有重新登陆必须强制退出重新登陆
 保存是否要强制退出标志
 ***/
+(void)save_forceLogoutFlag;
/***
 //判断2.1.13 是否需要强制退出
 ***/
+(BOOL)judgeIsforceLogout;

/***
 判断是否是越南版本
 ***/
+(BOOL)judegeIsVietnamVersion;


@end

NS_ASSUME_NONNULL_END
