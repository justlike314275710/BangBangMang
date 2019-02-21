//
//  STTipsView.h
//  Components
//
//  Created by calvin on 14-4-2.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSTipsView : UIView

/**
 *  弱弹窗提示
 *
 *  @param tips 提示信息
 */
+ (void)showTips:(NSString *)tips;
+ (void)showTips:(NSString *)tips dismissAfterDelay:(NSTimeInterval)interval;

@end
