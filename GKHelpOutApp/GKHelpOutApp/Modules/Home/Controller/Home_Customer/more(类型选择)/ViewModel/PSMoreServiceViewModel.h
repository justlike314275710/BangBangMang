//
//  PSMoreServiceViewModel.h
//  PrisonService
//
//  Created by kky on 2018/10/25.
//  Copyright © 2018年 calvin. All rights reserved.
//



#import "PSViewModel.h"
#import "PSMoreModel.h"
@interface PSMoreServiceViewModel : PSViewModel

@property (nonatomic, strong, readonly) NSArray<PSMoreModel *> *functions;


@end

