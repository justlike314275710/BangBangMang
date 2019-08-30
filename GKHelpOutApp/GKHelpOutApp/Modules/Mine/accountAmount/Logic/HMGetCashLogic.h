//
//  HMGetCashLogic.h
//  GKHelpOutApp
//
//  Created by kky on 2019/3/8.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HpBaseLogic.h"
#import "GETCashModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMGetCashLogic : HpBaseLogic
@property(nonatomic,strong)NSString *amount;
@property(nonatomic,strong)NSString *verificationCode;
@property(nonatomic,strong)GETCashModel *getCashModel;
///<提现
- (void)postGetCashDatacompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

@end

NS_ASSUME_NONNULL_END
