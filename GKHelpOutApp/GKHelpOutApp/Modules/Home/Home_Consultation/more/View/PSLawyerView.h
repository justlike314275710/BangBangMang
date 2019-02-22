//
//  PSLawyerView.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/2.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYPhotoBrowser.h"
#import "CDZStarsControl.h"
@interface PSLawyerView : UIView<CDZStarsControlDelegate>
@property (nonatomic, strong, readonly) UIImageView *avatarView;
@property (nonatomic, strong, readonly) UILabel *nicknameLabel;
@property (nonatomic , strong) UILabel* addressLable;//执教律所
@property (nonatomic,strong) CDZStarsControl *starsControl;

@end
