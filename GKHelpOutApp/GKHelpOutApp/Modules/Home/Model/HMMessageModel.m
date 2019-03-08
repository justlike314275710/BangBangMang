//
//  HMMessageModel.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMMessageModel.h"

@implementation HMMessageModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"messageid":@"id"};
}

+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return@{@"messageid":@"id"};
}

@end
