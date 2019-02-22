//
//  MoreRoloCell.h
//  PrisonService
//
//  Created by kky on 2018/10/25.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDZStarsControl.h"
@interface MoreRoloCell : UITableViewCell<CDZStarsControlDelegate>

@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UIImageView *stateImg;
@property (nonatomic,strong) UILabel *stateLab;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *levelLab;
@property (nonatomic,strong) UILabel *officeLab;
@property (nonatomic,strong) UILabel *gradeLab;
@property (nonatomic,strong) UIButton *consultBtn;
@property (nonatomic,strong) UIImageView *ratingImg;
@property (nonatomic,strong) CDZStarsControl *starsControl;
@property (nonatomic,assign) NSInteger starNumber;
@end

