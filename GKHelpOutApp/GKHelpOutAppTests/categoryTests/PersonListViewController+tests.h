//
//  PersonListViewController+tests.h
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/3.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "PersonListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonListViewController (tests)
-(void)refreshLifeTabbar;
-(void)setupUI;
-(void)headerRereshing;
-(void)footerRereshing;
-(void)requestDataCompleted;
@end

NS_ASSUME_NONNULL_END
