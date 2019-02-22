//
//  PSPayHandler.h
//  Start
//
//  Created by calvin on 16/7/18.
//  Copyright © 2016年 DingSNS. All rights reserved.
//
#import "PSPayInfo.h"

typedef void (^PSPayCallback)(BOOL result, NSError *error);

@protocol PSPayHandler <NSObject>

@property (nonatomic, copy) PSPayCallback payCallback;

- (void)goPayWithPayInfo:(PSPayInfo *)payInfo;

- (void)goRemittanceWithPayInfo:(PSPayInfo *)payInfo;

- (void)goOrderWithPayInfo:(PSPayInfo *)payInfo;//法律咨询
@end
