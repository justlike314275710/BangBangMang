//
//  TLCommentDetail.h
//  GKHelpOutApp
//
//  Created by kky on 2019/4/25.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMoment.h"
#import "TLMomentDetail.h"
NS_ASSUME_NONNULL_BEGIN

@interface TLCommentDetail : NSObject
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *createdTime;
@property(nonatomic,copy)NSString *showDate;
@property(nonatomic,copy)NSString *customerName;
@property(nonatomic,copy)TLMomentDetail *detail;


@end

NS_ASSUME_NONNULL_END
