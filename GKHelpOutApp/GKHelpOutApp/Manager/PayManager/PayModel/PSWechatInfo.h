//
//  PSWechatInfo.h
//  PrisonService
//
//  Created by calvin on 2018/4/24.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "JSONModel.h"

@interface PSWechatInfo : JSONModel

@property (nonatomic, strong) NSString<Optional> *appid;
@property (nonatomic, strong) NSString<Optional> *sign;
@property (nonatomic, strong) NSString<Optional> *partnerid;
@property (nonatomic, strong) NSString<Optional> *prepayid;
@property (nonatomic, strong) NSString<Optional> *packageName;
@property (nonatomic, strong) NSString<Optional> *noncestr;
@property (nonatomic, strong) NSString<Optional> *timestamp;

@end
