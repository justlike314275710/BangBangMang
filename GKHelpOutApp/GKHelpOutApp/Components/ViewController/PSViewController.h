//
//  STViewController.h
//  BuBuGao
//
//  Created by calvin on 14-4-2.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSViewController : UIViewController
@property(nonatomic ,strong) UILabel*dotLab;
@property (nonatomic, assign) UIInterfaceOrientationMask orientationMask;

/**
 *  创建导航栏右按钮
 *
 *  @param target target
 *  @param action 按钮触发的方法
 *  @param nImage 默认图片
 *  @param hImage 按下图片
 */
- (void)createRightBarButtonItemWithTarget:(id)target
                                    action:(SEL)action
                               normalImage:(UIImage *)nImage
                          highlightedImage:(UIImage *)hImage;

/**
 *  创建导航栏右按钮
 *
 *  @param target target
 *  @param action 按钮触发的方法
 *  @param title  按钮文字
 */
- (void)createRightBarButtonItemWithTarget:(id)target
                                    action:(SEL)action
                                     title:(NSString *)title;

/**
 *  显示网络请求失败信息
 */
- (void)showNetError;
/**
 *  显示无网络失败信息
 */
-(void)showInternetError;
/**
 *  导航栏图片
 *
 *  @return 返回导航栏所用图片，默认为纯白色
 */
- (UIImage *)navgationBarImage;

/**
 *  导航栏右按钮字体或图标颜色
 *
 *  @return 返回导航栏右按钮字体或图标颜色
 */
- (UIColor *)rightItemTitleColor;

/**
 *  获取导航左按钮图片
 *
 *  @return 返回导航左按钮图片，默认为nil，当为nil时不自动创建导航左按钮
 */
- (UIImage *)leftItemImage;

/**
 *  导航栏标题颜色
 *
 *  @return 返回导航栏标题颜色
 */
- (UIColor *)titleColor;

/**
 *  隐藏顶部导航栏
 *  @return 是否隐藏导航栏
 */
- (BOOL)hiddenNavigationBar;
- (void)changeOrientation:(UIInterfaceOrientation)orientation;


@end
