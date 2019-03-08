//
//  HMBillModel.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMBillModel.h"

@implementation HMBillModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"billid":@"id"};
}

+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return@{@"billid":@"id"};
}


@end
