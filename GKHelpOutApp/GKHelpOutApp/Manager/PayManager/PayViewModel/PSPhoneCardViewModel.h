//
//  PSPhoneCardViewModel.h
//  PrisonService
//
//  Created by calvin on 2018/4/23.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSAppointmentBaseViewModel.h"
#import "PSPayment.h"

@interface PSPhoneCardViewModel : PSAppointmentBaseViewModel

@property (nonatomic, strong, readonly) NSArray *payments;
@property (nonatomic, assign) NSInteger selectedPaymentIndex;
@property (nonatomic, assign) NSInteger quantity;

@end
