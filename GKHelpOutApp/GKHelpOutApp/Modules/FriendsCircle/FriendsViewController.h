//
//  FriendsViewController.h
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/4/15.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "RootViewController.h"
#import "BaseRootViewController.h"
#import "LifeCircleViewController.h"
@interface FriendsViewController : BaseRootViewController
@property (nonatomic,assign)LifeCircleStyle lifeCircleStyle;

-(void)refreshLifeTabbar;
-(void)loadMenus;

@end
