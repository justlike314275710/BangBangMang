//
//  PSLawerViewModel.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/2.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSViewModel.h"

@interface PSLawerViewModel : PSViewModel
@property (nonatomic ,strong) NSString *category;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) BOOL hasNextPage;


@property (nonatomic , strong) NSArray *myLawerArray;


- (void)refreshLawyerCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
- (void)loadMoreLawyerCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
@end
