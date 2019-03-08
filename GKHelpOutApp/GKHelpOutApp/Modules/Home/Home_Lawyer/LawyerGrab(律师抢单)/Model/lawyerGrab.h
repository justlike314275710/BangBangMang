//
//  lawyerGrab.h
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Grab_customer.h"

@protocol lawyerGrab <NSObject>
@end

@interface lawyerGrab : NSObject
@property (nonatomic , strong) NSString *cid;
@property (nonatomic , strong) NSString *number;
@property (nonatomic , strong) NSString *category;
@property (nonatomic , strong) NSString *reward;
@property (nonatomic , strong) NSString *createdTime;
@property (nonatomic , strong) NSString *status;
@property (nonatomic , strong) Grab_customer*customer;
@end
