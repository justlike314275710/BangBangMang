//
//  PSRemittancePayStateViewController.h
//  PrisonService
//
//  Created by kky on 2018/10/29.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSBusinessViewController.h"
#import "PSPayInfo.h"
//#import "PSPrisonerDetail.h"
typedef NS_ENUM(NSInteger, PayState) {
    payScuess = 0,
    payFailure = 1,
    payCancel = 2
};

typedef NS_ENUM(NSInteger, PayWayState) {
    payWayLegaladvice = 0,  //法律咨询
    payWayRemittance = 1,   //汇款
};

typedef void (^CompleteBlock)(PayState state);
@interface PSRemittancePayStateViewController : PSBusinessViewController
@property (nonatomic,strong)PSPayInfo *info;
@property (nonatomic,assign)PayState state;
//@property (nonatomic,strong)PSPrisonerDetail *prisoner;
@property (nonatomic,copy)  CompleteBlock completeBlock;
@property (nonatomic,assign)PayWayState payWay;


@end


