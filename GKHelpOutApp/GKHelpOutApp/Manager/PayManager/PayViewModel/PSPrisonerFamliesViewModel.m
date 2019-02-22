//
//  PSPrisonerFamliesViewModel.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/9/14.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSPrisonerFamliesViewModel.h"




@interface PSPrisonerFamliesViewModel ()

@property (nonatomic, strong) NSMutableArray *logs;
@end

@implementation PSPrisonerFamliesViewModel
@synthesize dataStatus = _dataStatus;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isSelectFamily = NO;
    }
    return self;
}

- (NSArray *)prisonerFamlies{
    return _logs;
}

- (void)requestOfPrisonerFamliesCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    
    
}
@end
