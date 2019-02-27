//
//  AuthGroupItem.h
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/2/27.
//  Copyright © 2019年 kky. All rights reserved.
//
#import "AuthItem.h"
#import <Foundation/Foundation.h>

@interface AuthGroupItem : NSObject
@property (nonatomic, strong) NSMutableArray <AuthItem *> *items;
@property (nonatomic, copy) NSString *headTitle;
@end
