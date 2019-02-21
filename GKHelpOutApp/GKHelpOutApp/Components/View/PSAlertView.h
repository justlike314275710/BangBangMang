//
//  STAlertView.h
//  Start
//
//  Created by Glen on 16/6/15.
//  Copyright © 2016年 DingSNS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GAlertViewTage 99999

@interface PSAlertView : UIView
/**
 *  初始化方法
 *
 *  @param title        标题文字
 *  @param message      提示文字信息
 *  @param image        提示图片
 *  @param block        回调
 *  @param buttonTitles 按钮文字
 *
 *  @return PSAlertView对象
 */
+ (instancetype)showWithTitle:(NSString *)title
                      message:(NSString *)message
             messageAlignment:(NSTextAlignment)alignment
                        image:(UIImage *)image
                      handler:(void (^)(PSAlertView *alertView, NSInteger buttonIndex))block
                 buttonTitles:(NSString *)buttonTitles ,...NS_REQUIRES_NIL_TERMINATION;

- (void)didDismiss;
-(void)show;
@end
