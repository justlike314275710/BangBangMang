//
//  HMAccontBalaceLogic.h
//  GKHelpOutApp
//
//  Created by kky on 2019/3/5.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HpBaseLogic.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMAccontBalaceLogic : HpBaseLogic
///<查询支付宝
- (void)getBingLawyerAlipayInfo:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
///<获取绑定支付宝的sign
- (void)getBingLawyerAuthSignData:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
///<绑定支付宝的
- (void)postBingLawyerAlipayData:(NSString *)authCode completed:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
///<解绑支付宝
- (void)postUnBingLawyerAlipayData:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

@end

NS_ASSUME_NONNULL_END
