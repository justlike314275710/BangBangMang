//
//  NSString+emoji.h
//  PrisonService
//
//  Created by kky on 2018/12/27.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (emoji)

/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;
+ (BOOL)hasEmoji:(NSString*)string;
+(BOOL)isNineKeyBoard:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
