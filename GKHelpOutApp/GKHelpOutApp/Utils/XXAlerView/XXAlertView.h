//
//  XXAlertView.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/7/17.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^alertClick)(NSInteger index);
@interface XXAlertView : UIView
@property (nonatomic,copy) alertClick clickIndex;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;

- (void)show;
@end
