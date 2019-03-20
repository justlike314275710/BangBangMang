//
//  PSConsultation.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/10/31.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSConsultation.h"

@implementation PSConsultation
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//    if([key isEqualToString:@"id"]){
//        self.trans_id = [value intValue];
//    }
//    if ([key isEqualToString:@"description"]) {
//        self.trans_description=value;
//    }
//}
+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return@{@"des":@"description",@"cid":@"id"};
}


@end
