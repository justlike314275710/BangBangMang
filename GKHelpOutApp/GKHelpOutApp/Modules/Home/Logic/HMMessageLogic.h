//
//  HMMessageLogic.h
//  GKHelpOutApp
//
//  Created by kky on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HpBaseLogic.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMMessageLogic : HpBaseLogic
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger pageSize;
@property (nonatomic, assign) BOOL hasNextPage;
@property (nonatomic, assign) PSDataStatus dataStatus;
@property (nonatomic, strong) NSMutableArray *datalist;

- (void)refreshMesagaeListCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
- (void)loadMyMessageListCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

@end

NS_ASSUME_NONNULL_END
