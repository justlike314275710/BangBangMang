//
//  PSLawyerComments.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/9.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSCustomer.h"
@interface PSLawyerComments : NSObject
@property (nonatomic , strong) NSString *content;
@property (nonatomic , strong) NSString *createdTime;
@property (nonatomic , strong) NSString *cid;
@property (nonatomic , strong) NSString *rate;
@property (nonatomic , strong) PSCustomer *customer;
@end
