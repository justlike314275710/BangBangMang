//
//  PSPrisonerFamliesViewModel.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/9/14.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSBasePrisonerViewModel.h"

@interface PSPrisonerFamliesViewModel : PSBasePrisonerViewModel
@property (nonatomic , strong) NSArray *selectPrisonerFamliesArray;
@property (nonatomic, strong, readonly) NSArray *prisonerFamlies;
@property (nonatomic, assign) BOOL hasNextPage;
@property (nonatomic, assign) BOOL isSelectFamily;
@property (nonatomic, assign) NSString<Optional> *face_recognition;
- (void)requestOfPrisonerFamliesCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
@end
