//
//  PSPayInfo.h
//  Start
//
//  Created by calvin on 16/7/18.
//  Copyright © 2016年 DingSNS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSPayInfo : NSObject

/**
 *  商品ID
 */
@property (nonatomic, strong) NSString *productID;
/**
 *  支付方式（WEIXIN,ALIPAY）
 */
@property (nonatomic, strong) NSString *payment;
/**
 * 商品金额
 */
@property (nonatomic, assign) CGFloat amount;
/**
 * 商品名称
 */
@property (nonatomic, strong) NSString *productName;
/**
 * 商品数量
 */
@property (nonatomic, assign) NSInteger quantity;
/**
 * jailID
 */
@property (nonatomic, strong) NSString *jailId;
/**
 * familyId
 */
@property (nonatomic, strong) NSString *familyId;
/**
 * prisonerId
 */
@property (nonatomic, strong) NSString *prisonerId; 
/**
 * 汇款金额
 */
@property (nonatomic, strong) NSString *money;



@end
