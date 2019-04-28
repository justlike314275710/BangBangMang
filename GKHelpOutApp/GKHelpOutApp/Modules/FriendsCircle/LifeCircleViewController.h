//
//  LifeCircleViewController.h
//  GKHelpOutApp
//
//  Created by kky on 2019/4/15.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"
#import "BaseRootViewController.h"
typedef NS_ENUM(NSInteger, LifeCircleStyle) {
    HMLifeCircleALL = 0,   //所有人的朋友圈
    HMLifeCircleMy,    //自己的朋友圈
    HMLifeCircleOther, //朋友的朋友圈
};
NS_ASSUME_NONNULL_BEGIN

@interface LifeCircleViewController : BaseRootViewController
@property(nonatomic,assign)LifeCircleStyle lifeCircleStyle;

#pragma mark - 别人朋友圈
@property(nonatomic,copy)NSString *friendusername; //别人username
@property(nonatomic,copy)NSString *showName;


@end

NS_ASSUME_NONNULL_END
