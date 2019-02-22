//
//  PSProduct.m
//  PrisonService
//
//  Created by calvin on 2018/5/14.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSProduct.h"

@implementation PSProduct
- (id)init {
    self = [super init];
    if (self) {
        self.quantity = 1;
        self.selected = YES;
        self.defaultPrice = 50;
    }
    return self;
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"quantity"]) return YES;
    if ([propertyName isEqualToString:@"selected"]) return YES;
    if ([propertyName isEqualToString:@"price"]) return YES;
    if ([propertyName isEqualToString:@"defaultPrice"]) return YES;
    return NO;
}

@end
