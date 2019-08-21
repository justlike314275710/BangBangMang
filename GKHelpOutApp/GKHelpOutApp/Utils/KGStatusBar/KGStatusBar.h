//
//  XXEmallViewController.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/7/20.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGStatusBar : UIView

+ (void)showWithStatus:(NSString*)status;
+ (void)showErrorWithStatus:(NSString*)status;
+ (void)showSuccessWithStatus:(NSString*)status;
+ (void)dismiss;

@end
