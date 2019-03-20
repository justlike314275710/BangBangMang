//
//  PSMoreServiceViewModel.m
//  PrisonService
//
//  Created by kky on 2018/10/25.
//  Copyright © 2018年 calvin. All rights reserved.
//
#import "PSMoreServiceViewModel.h"

@implementation PSMoreServiceViewModel

- (id)init {
   self = [super init];
    if (self) {
        
        NSArray *titles = @[@"财产纠纷",
                            @"婚姻家庭",
                            @"交通事故",
                            @"工伤赔偿",
                            @"合同纠纷",
                            @"刑事辩护",
                            @"房产纠纷",
                            @"劳动就业"];

        NSArray *messages = @[@"最大化维护您的合法权益",
                              @"让法律守护你我他",
                              @"优质、高效的法律帮助",
                              @"尽职尽责，专业诚信",
                              @"专业高效，值得托付",
                              @"好律师就在身边",
                              @"认证律师，高效出函",
                              @"资深专业，经验丰富"];
        
        NSMutableArray *items = [NSMutableArray array];
        [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PSMoreModel *model = [[PSMoreModel alloc] init];
            model.logoIcon = titles[idx];
            model.title = titles[idx];
            model.message = messages[idx];
            [items addObject:model];
        }];
        _functions = items;
  }
  return self;
}

@end
