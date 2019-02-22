//
//  STLoadingView.h
//  Components
//
//  Created by calvin on 14-5-5.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSLoadingView : UIView

+ (PSLoadingView *)sharedInstance;
- (void)show;
- (void)showOnView:(UIView *)view;
- (void)dismiss;

@end
