//
//  HMBillModel.h
//  GKHelpOutApp
//
//  Created by kky on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMBillModel : NSObject
@property(nonatomic,strong)NSString *amount;
@property(nonatomic,strong)NSString *billid;       //唯一标示
@property(nonatomic,strong)NSString *orderNumber;  //订单标号
@property(nonatomic,strong)NSString *source;       //支付方式
@property(nonatomic,strong)NSString *type;         //账单类型
@property(nonatomic,strong)NSString *successTime;  //成功时间


@end

