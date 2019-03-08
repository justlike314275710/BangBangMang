//
//  PSAdviceDetailsView.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/6.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZJImageMagnification.h"
#import "CDZStarsControl.h"
@interface PSAdviceDetailsView : UIView
@property (nonatomic , strong) NSArray *imagesArray;
@property (nonatomic, strong, readonly) UIImageView *avatarView;
@property (nonatomic, strong, readonly) UILabel *nicknameLabel;
@property (nonatomic, strong, readonly) UILabel *lawerTimeLabel;
@property (nonatomic, strong, readonly) UILabel *lawerAddressLabel;
@property (nonatomic, strong, readonly) UILabel *rewardLable;
@property (nonatomic, strong, readonly) UILabel *contentLable;
@property (nonatomic, strong, readonly) UILabel *payStatusLable;
//@property (nonatomic, strong, readonly) UITextView*contentTextView;
@property (nonatomic , strong) NSArray *categories;
@property (nonatomic , strong) NSMutableArray*scanBigImageArray;
@property (nonatomic , strong)  UIImageView *imageView;
@property (nonatomic , strong) UIButton *categoryButton;

@property (nonatomic,strong) CDZStarsControl *starsControl;
@property (nonatomic , strong)   UILabel*titleLable;
@property (nonatomic , strong) UILabel* numberLable;

@property (nonatomic , strong) NSString *cid;
@end
