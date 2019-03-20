//
//  PSEvaluateViewmodel.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/9.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSViewModel.h"

@interface PSEvaluateViewmodel : PSViewModel

@property (nonatomic , strong) NSString *cid;//话题id
@property (nonatomic , strong) NSString *rate;
@property (nonatomic , strong) NSString *content;
@property (nonatomic , strong) NSString *isResolved;


@property (nonatomic , strong) NSString *lawyerId;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) BOOL hasNextPage;
@property (nonatomic , strong) NSArray *myEvaluateArray;
@property (nonatomic , strong) NSString *totleNumber;

- (void)checkDataWithCallback:(CheckDataCallback)callback ;
-(void)requestAddEvaluateCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;//增加评论


- (void)refreshEvaluateCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
- (void)loadMoreEvaluateCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
@end
