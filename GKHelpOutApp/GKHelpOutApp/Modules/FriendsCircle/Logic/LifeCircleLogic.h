//
//  LifeCircleLogic.h
//  GKHelpOutApp
//
//  Created by kky on 2019/4/22.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HpBaseLogic.h"
#import "LifeCircleViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LifeCircleLogic : HpBaseLogic
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger size;
@property(nonatomic,copy) NSString *username;
@property (nonatomic, assign) BOOL hasNextPage;
@property (nonatomic, assign) PSDataStatus dataStatus;
@property (nonatomic, strong) NSMutableArray *datalist;
@property (nonatomic, assign) LifeCircleStyle lifeCircleStyle;

//获取朋友圈列表
- (void)refreshLifeCirclelistCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
- (void)loadMyLifeCircleListCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;


@end

NS_ASSUME_NONNULL_END
