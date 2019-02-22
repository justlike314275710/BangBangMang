//
//  PSLawer.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/10/31.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PSLawer : NSObject
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *username;
@property (nonatomic , strong) NSString *avatarThumb;
@property (nonatomic , strong) NSString *avatarFileId;
@property (nonatomic , strong) NSString *cid;
@property (nonatomic , strong) NSString *rate;
@property (nonatomic , strong) NSString *lawOffice;
@end
