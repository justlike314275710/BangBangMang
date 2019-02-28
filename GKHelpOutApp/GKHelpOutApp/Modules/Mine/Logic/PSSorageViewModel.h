//
//  PSSorageViewModel.h
//  PrisonService
//
//  Created by kky on 2018/12/18.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSorageViewModel : PSViewModel
@property(nonatomic,copy,readonly) NSString *allStorage;
@property(nonatomic,copy,readonly) NSString *usedStorage;

@end

NS_ASSUME_NONNULL_END
