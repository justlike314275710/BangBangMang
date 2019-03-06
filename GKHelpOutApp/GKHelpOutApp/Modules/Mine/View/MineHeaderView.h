//
//  MineHeaderView.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/6/13.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 我的页面 头部 view
 */
@protocol headerViewDelegate <NSObject>

-(void)headerViewClick;
-(void)nickNameViewClick;
-(void)cerLawViewClick;

@end

@interface MineHeaderView : UIView

@property(nonatomic, strong) YYAnimatedImageView *headImgView; //头像
@property(nonatomic, strong) UserInfo *userInfo;//用户信息
@property(nonatomic, assign) id<headerViewDelegate> delegate;
@property(nonatomic, strong) UILabel *nickNameLab;   //展示昵称
@property(nonatomic, strong) UILabel *phoneNuberLab; //展示的电话号码

@end
