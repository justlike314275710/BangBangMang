//
//  HMMessageModel.h
//  GKHelpOutApp
//
//  Created by kky on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMMessageModel : NSObject
@property(nonatomic,strong)NSString *messageid;
@property(nonatomic,strong)NSString *to;       //唯一标示
@property(nonatomic,strong)NSString *content;  //订单标号
@property(nonatomic,strong)NSString *createdTime;       //支付方式
@property(nonatomic,strong)NSString *lastUpdatedTime;         //账单类型
@property(nonatomic,strong)NSString *from;  //成功时间

@end

NS_ASSUME_NONNULL_END
