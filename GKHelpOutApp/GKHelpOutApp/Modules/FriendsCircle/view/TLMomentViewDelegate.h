//
//  TLMomentViewDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/5/2.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLMoment;
@class UserInfo;
@class TLMomentImagesCell;
@protocol TLMomentViewDelegate <NSObject>

- (void)momentViewClickImage:(NSArray *)images atIndex:(NSInteger)index cell:(TLMomentImagesCell *)cell ;

- (void)momentViewWithModel:(TLMoment *)moment didClickUser:(UserInfo *)user;

- (void)momentViewWithModel:(TLMoment *)moment jumpToUrl:(NSString *)url;
//分享
- (void)momentViewWithModel:(TLMoment *)moment didClickShare:(NSString *)url;
//评论
- (void)momentViewWithModel:(TLMoment *)moment didClickComment:(NSString *)url;
//点赞
- (void)momentViewWithModel:(TLMoment *)moment didClickLike:(NSString *)url;
@end
