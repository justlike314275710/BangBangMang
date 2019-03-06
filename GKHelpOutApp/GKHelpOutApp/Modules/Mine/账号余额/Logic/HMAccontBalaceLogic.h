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
///<绑定支付吧
- (void)getBingLawyerAuthSignData:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

@end

NS_ASSUME_NONNULL_END
