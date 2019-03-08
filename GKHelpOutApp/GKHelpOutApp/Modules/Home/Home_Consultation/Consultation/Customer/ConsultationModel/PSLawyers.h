//
//  PSLawyers.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/6.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@protocol PSLawyers <NSObject>
@end


@interface PSLawyers : NSObject
@property (nonatomic , strong) NSString *cid;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *certified;
@property (nonatomic , strong) NSString *avatarThumb;
@property (nonatomic , strong) NSString *serviceStatus;
@property (nonatomic , strong) NSString *lawOffice;
@property (nonatomic , strong) NSString *level;
@property (nonatomic , strong) NSString *rate;
@property (nonatomic , strong) NSArray *categories;

@end
