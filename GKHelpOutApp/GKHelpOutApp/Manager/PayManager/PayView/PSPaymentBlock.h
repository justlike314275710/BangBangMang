//
//  PSPaymentProtocol.h
//  PrisonService
//
//  Created by calvin on 2018/4/23.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PaymentClosed)();
typedef void(^PaymentGoHome)();
typedef void(^PaymentGozx)();
typedef CGFloat(^PaymentAmount)();
typedef UIImage *(^PaymentIconAtIndex)(NSInteger index);
typedef NSString *(^PaymentNameAtIndex)(NSInteger index);
typedef NSInteger(^PaymentRows)();
typedef NSInteger(^PaymentSelectedIndex)();
typedef void(^PaymentSelectedAtIndex)(NSInteger index);
typedef void(^PaymentGoPay)();
