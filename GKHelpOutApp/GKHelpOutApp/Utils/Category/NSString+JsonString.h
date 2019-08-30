//
//  NSString+JsonString.h
//  GKHelpOutApp
//
//  Created by kky on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JsonString)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+(NSString *)convertToJsonData:(NSDictionary *)dict;
+(NSString*)changeTelephone:(NSString*)teleStr;


@end

NS_ASSUME_NONNULL_END
