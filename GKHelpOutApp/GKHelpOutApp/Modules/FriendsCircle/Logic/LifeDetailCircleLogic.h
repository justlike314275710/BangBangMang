//
//  LifeDetailCircleLogic.h
//  GKHelpOutApp
//
//  Created by kky on 2019/4/24.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HpBaseLogic.h"

NS_ASSUME_NONNULL_BEGIN

@interface LifeDetailCircleLogic : HpBaseLogic
@property (nonatomic,copy)NSString* circleoffriendsId;
@property (nonatomic,copy)NSString* content;
//获取某条生活圈详情
-(void)requestLifeCircleDetailCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
//评论某条朋友圈
-(void)requestLifeCircleDetailCommentCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
//点赞朋友圈
-(void)requestLifeCircleDetailPraiseCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

@end

NS_ASSUME_NONNULL_END
