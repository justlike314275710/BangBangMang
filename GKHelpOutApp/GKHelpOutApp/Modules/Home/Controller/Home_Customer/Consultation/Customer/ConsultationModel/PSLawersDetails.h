//
//  PSLawersDetails.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/6.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSLawersDetails : NSObject
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *certified;
@property (nonatomic , strong) NSString *avatarThumb;
@property (nonatomic , strong) NSString *serviceTotal;
@property (nonatomic , strong) NSString *lawOffice;
@property (nonatomic , strong) NSString *level;
@property (nonatomic , strong) NSString *des;
@property (nonatomic , strong) NSArray *categories;
@property (nonatomic , strong) NSString *rate;
@end
