//
//  PSAppointmentBaseViewModel.h
//  PrisonService
//
//  Created by calvin on 2018/5/11.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSBasePrisonerViewModel.h"
#import "PSPhoneCard.h"


@interface PSAppointmentBaseViewModel : PSBasePrisonerViewModel

@property (nonatomic, strong, readonly) PSPhoneCard *phoneCard;


- (void)requestPhoneCardCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
- (void)requestJailConfigurationsCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

@end
