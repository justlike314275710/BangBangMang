//
//  PSPhoneCardViewModel.m
//  PrisonService
//
//  Created by calvin on 2018/4/23.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSPhoneCardViewModel.h"

@interface PSPhoneCardViewModel ()

@end

@implementation PSPhoneCardViewModel
- (id)init {
    self = [super init];
    if (self) {
        NSMutableArray *payments = [NSMutableArray array];
        PSPayment *alipay = [PSPayment new];
        alipay.iconName = @"appointmentAlipayIcon";
        alipay.name = @"支付宝支付";
        alipay.payment = @"ALIPAY";
        [payments addObject:alipay];
        PSPayment *wechatPay = [PSPayment new];
        wechatPay.iconName = @"appointmentWechatIcon";
        wechatPay.name = @"微信支付";
        wechatPay.payment = @"WEIXIN";
        [payments addObject:wechatPay];
        _payments = payments;
        _quantity = 1;
    }
    return self;
}

@end
