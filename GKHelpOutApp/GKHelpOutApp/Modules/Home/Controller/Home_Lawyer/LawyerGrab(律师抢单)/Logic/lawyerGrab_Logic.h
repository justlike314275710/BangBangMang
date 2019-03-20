//
//  lawyerGrab_Logic.h
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSViewModel.h"
@interface lawyerGrab_Logic : PSViewModel
@property (nonatomic , strong) NSString *cid;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) BOOL hasNextPage;
@property (nonatomic , strong) NSArray *rushAdviceArray;
@property (nonatomic , strong) NSArray *myAdviceArray;


@property (nonatomic , strong) NSString *rate;
@property (nonatomic , strong) NSString *content;
@property (nonatomic , strong) NSString *isResolved;


- (void)refreshLawyerAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
- (void)loadLawyerAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

-(void)POSTLawyergrabCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;




- (void)refreshMygrabCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
- (void)loadMygrabCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
-(void)GETMygrabCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

- (void)checkEvaluateDataWithCallback:(CheckDataCallback)callback ;
-(void)GETLawyerDetailsCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

-(void)requestCommentsCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;//评论

-(void)GETProcessedCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;//模拟通话



-(void)deleteConsultationCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;//删除订单
@end
