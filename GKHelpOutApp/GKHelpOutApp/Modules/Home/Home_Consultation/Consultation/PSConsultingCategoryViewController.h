//
//  PSConsultingCategoryViewController.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/10/29.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSBusinessViewController.h"
typedef void (^ReturnValueBlock) (NSArray *arrayValue);
typedef void(^addCategoryCompletion)(BOOL successful);
@interface PSConsultingCategoryViewController : PSBusinessViewController
@property(nonatomic, copy) ReturnValueBlock returnValueBlock;
@property (nonatomic, copy) addCategoryCompletion completion;
@end
