//
//  HMGetCashResultViewController.h
//  GKHelpOutApp
//
//  Created by kky on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, PSGetCashState) {
    PSGetCashScuess = 0, //申请提现成功
    PSGetCashError,      //申请提现失败
};

@interface HMGetCashResultViewController : RootViewController
@property(nonatomic,assign)PSGetCashState getCashState;
@property(nonatomic,copy)NSString *cash;

@end

NS_ASSUME_NONNULL_END
