//
//  LifeCircleLogic.h
//  GKHelpOutApp
//
//  Created by kky on 2019/4/22.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HpBaseLogic.h"

NS_ASSUME_NONNULL_BEGIN

@interface LifeCircleLogic : HpBaseLogic
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger size;
@property (nonatomic, assign) BOOL hasNextPage;
@property (nonatomic, assign) PSDataStatus dataStatus;
@property (nonatomic, strong) NSMutableArray *datalist;
//发布朋友圈
- (void)getLifeCircleListData:(RequestDataCompleted)completed failed:(RequestDataFailed)failedCallback;


@end

NS_ASSUME_NONNULL_END
