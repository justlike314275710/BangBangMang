//
//  PSConsultation.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/10/31.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "PSCustomer.h"
#import "PSLawer.h"
#import "MJExtension.h"

@protocol PSConsultation <NSObject>
@end


@interface PSConsultation : NSObject
@property (nonatomic, strong) NSString* cid;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSString* reward;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *paymentStatus;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *attachments;
@property (nonatomic , strong) NSString *createdTime;
@property (nonatomic , strong) NSString *acceptedTime;
@property (nonatomic , strong) NSString *endTime;
@property (nonatomic, strong) PSLawer<Optional> *lawyer;
//@property (nonatomic, strong) PSCustomer<Optional> *customer;
@property (nonatomic , strong) NSString *type;
@property (nonatomic , strong) NSString *category;
@property (nonatomic , strong) NSString *payStatus;
@property (nonatomic , assign) BOOL isAutoEnd;

@property (nonatomic , strong) NSString *videoDuration;
@end
