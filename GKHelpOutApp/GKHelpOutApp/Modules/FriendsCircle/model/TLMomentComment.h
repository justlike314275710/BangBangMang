//
//  TLMomentComment.h
//  TLChat
//
//  Created by libokun on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface TLMomentCommentFrame : NSObject

@property (nonatomic, assign) CGFloat height;

@end


@interface TLMomentComment : NSObject

/// 作者
@property (nonatomic, strong) UserInfo *user;

/// 回复的用户
@property (nonatomic, strong) UserInfo *toUser;

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong, readonly) NSAttributedString *attrContent;
@property (nonatomic, copy) void (^userClickAction)(UserInfo *user);

@property (nonatomic, strong) TLMomentCommentFrame *commentFrame;

@end
