//
//  PSAppointmentBaseViewModel.m
//  PrisonService
//
//  Created by calvin on 2018/5/11.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSAppointmentBaseViewModel.h"
//#import "PSJailConfigurationsRequest.h"

@interface PSAppointmentBaseViewModel ()

//@property (nonatomic, strong) PSJailConfigurationsRequest *configurationRequest;

@end

@implementation PSAppointmentBaseViewModel
- (id)init {
    self = [super init];
    if (self) {
        self.phoneCard = [self phoneCardWithPrice:50];
    }
    return self;
}

- (PSPhoneCard *)phoneCardWithPrice:(CGFloat)price {
    PSPhoneCard *phoneCard = [[PSPhoneCard alloc] init];
    phoneCard.id = @"9999";
    phoneCard.price = price;
    NSString*Phone_CARDS=NSLocalizedString(@"Phone_CARDS", @"远程探视卡");
    phoneCard.title = Phone_CARDS;
    return phoneCard;
}

- (void)setPhoneCard:(PSPhoneCard *)phoneCard {
    _phoneCard = phoneCard;
}

//- (void)setJailConfiguration:(PSJailConfiguration *)jailConfiguration {
//    _jailConfiguration = jailConfiguration;
//}

- (void)requestPhoneCardCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
//    @weakify(self)
//    [self requestJailConfigurationsCompleted:^(PSResponse *response) {
//        @strongify(self)
//        if (self.jailConfiguration) {
//            self.phoneCard = [self phoneCardWithPrice:self.jailConfiguration.cost];
//        }
//        if (completedCallback) {
//            completedCallback(response);
//        }
//    } failed:^(NSError *error) {
//        if (failedCallback) {
//            failedCallback(error);
//        }
//    }];
}

- (void)requestJailConfigurationsCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
//    self.configurationRequest = [PSJailConfigurationsRequest new];
//    self.configurationRequest.jailId = self.prisonerDetail.jailId;
//    @weakify(self)
//    [self.configurationRequest send:^(PSRequest *request, PSResponse *response) {
//        @strongify(self)
//        if (response.code == 200) {
//            PSJailConfigurationsResponse *configurationsResponse = (PSJailConfigurationsResponse *)response;
//            self.jailConfiguration = configurationsResponse.configuration;
//        }
//        if (completedCallback) {
//            completedCallback(response);
//        }
//    } errorCallback:^(PSRequest *request, NSError *error) {
//        if (failedCallback) {
//            failedCallback(error);
//        }
//    }];
}

@end
