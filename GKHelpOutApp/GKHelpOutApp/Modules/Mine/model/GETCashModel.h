//
//  GETCashModel.h
//  GKHelpOutApp
//
//  Created by kky on 2019/8/29.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GETCashModel : NSObject

@property(nonatomic,copy) NSString *outBizNo;
@property(nonatomic,copy) NSString *orderId;
@property(nonatomic,copy) NSString *payDate;
@property(nonatomic,copy) NSString *applyDate;
@property(nonatomic,copy) NSString *nickName;
@property(nonatomic,copy) NSString *amount;
@property(nonatomic,copy) NSString *realAmount;

@end

NS_ASSUME_NONNULL_END
