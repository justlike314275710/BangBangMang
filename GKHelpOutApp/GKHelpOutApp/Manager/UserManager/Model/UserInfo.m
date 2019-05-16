//
//  UserInfo.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/23.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

// UserInfo.m
+ (NSDictionary *)modelCustomPropertyMapper {
    // 将im_username映射到key为username的数据字段
    return @{@"im_username":@"username"};
}


@end
