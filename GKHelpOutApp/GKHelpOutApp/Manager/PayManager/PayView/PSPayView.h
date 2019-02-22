//
//  PSPayView.h
//  PrisonService
//
//  Created by calvin on 2018/4/23.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSPaymentBlock.h"

typedef NS_ENUM(NSUInteger, PSPayStatus) {
    PSPayOngoing,
    PSPaySuccessful,
};

@interface PSPayView : UIControl

@property (nonatomic, assign) PSPayStatus status;
@property (nonatomic, copy) PaymentAmount getAmount;
@property (nonatomic, copy) PaymentRows getRows;
@property (nonatomic, copy) PaymentSelectedIndex getSelectedIndex;
@property (nonatomic, copy) PaymentIconAtIndex getIcon;
@property (nonatomic, copy) PaymentNameAtIndex getName;
@property (nonatomic, copy) PaymentSelectedAtIndex seletedPayment;
@property (nonatomic, copy) PaymentGoPay goPay;
@property (nonatomic, copy) NSString *payType; //"law"  //法律咨询
@property (nonatomic, copy) PaymentGoHome goHomeAction;
@property (nonatomic, copy) PaymentGozx goZxActcion;

- (void)showAnimated:(BOOL)animated;
- (void)dismissAnimated:(BOOL)animated;

@end
