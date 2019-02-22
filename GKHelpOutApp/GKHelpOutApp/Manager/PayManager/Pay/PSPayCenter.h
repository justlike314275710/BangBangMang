//
//  PSPayManager.h
//  Start
//
//  Created by calvin on 16/7/12.
//  Copyright © 2016年 DingSNS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSPayHandler.h"
#import "PSPayInfo.h"
typedef NS_ENUM(NSInteger,PayType) {
    PayTypeBuy = 0,  //购买
    PayTypeRem = 1,  //汇款
    PayTypeOrd = 2,  //法律咨询订单
};
@interface PSPayCenter : NSObject

+ (PSPayCenter *)payCenter;

@property (nonatomic, copy) PSPayCallback payCallback;

- (void)goPayWithPayInfo:(PSPayInfo *)payInfo type:(PayType)type callback:(PSPayCallback)callback;
- (void)handleWeChatURL:(NSURL *)url;
- (void)handleAliURL:(NSURL *)url;



@end
