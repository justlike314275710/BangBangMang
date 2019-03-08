//
//  LawUserInfo.h
//  GKHelpOutApp
//
//  Created by kky on 2019/3/5.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LawUserInfo : NSObject

@property (nonatomic,copy) NSString *certificationStatus;
@property (nonatomic,copy) NSString *rewardAmount;
@property (nonatomic,copy) NSString *alipayBind;
@property (nonatomic,copy) NSString *avatar;   //支付宝头像
@property (nonatomic,copy) NSString *nickName; //支付昵称
@property (nonatomic , strong) NSArray *categories;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *lawOffice;


@end

NS_ASSUME_NONNULL_END
