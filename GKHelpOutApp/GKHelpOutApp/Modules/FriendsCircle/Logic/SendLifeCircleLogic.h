//
//  SendLifeCircleLogic.h
//  GKHelpOutApp
//
//  Created by kky on 2019/4/22.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HpBaseLogic.h"

@interface SendLifeCircleLogic : HpBaseLogic

@property (nonatomic,copy) NSString *content;

//图片
@property (nonatomic,copy) NSArray *circleoffriendsPicture; 


//发布朋友圈
- (void)postReleaseLifeCircleData:(RequestDataCompleted)completed failed:(RequestDataFailed)failedCallback;

@end

