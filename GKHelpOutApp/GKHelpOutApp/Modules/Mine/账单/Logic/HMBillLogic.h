//
//  HMBillLogin.h
//  GKHelpOutApp
//
//  Created by kky on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HpBaseLogic.h"

@interface HMBillLogic : HpBaseLogic
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger pageSize;
@property (nonatomic, assign) BOOL hasNextPage;
@property (nonatomic, assign) DSDataStatus dataStatus;
- (void)refreshMyAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
- (void)loadMyAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

@end

