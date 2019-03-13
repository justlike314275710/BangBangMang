//
//  PSPayOngoingViewController.h
//  PrisonService
//
//  Created by calvin on 2018/4/23.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSBusinessViewController.h"
#import "PSPaymentBlock.h"

@interface PSPayOngoingViewController : PSBusinessViewController
//PSBusinessViewController
@property (nonatomic, copy) PaymentAmount getAmount;
@property (nonatomic, copy) PaymentRows getRows;
@property (nonatomic, copy) PaymentSelectedIndex getSelectedIndex;
@property (nonatomic, copy) PaymentIconAtIndex getIcon;
@property (nonatomic, copy) PaymentNameAtIndex getName;
@property (nonatomic, copy) PaymentSelectedAtIndex seletedPayment;
@property (nonatomic, copy) PaymentClosed closeAction;
@property (nonatomic, copy) PaymentGoPay goPay;

@end
