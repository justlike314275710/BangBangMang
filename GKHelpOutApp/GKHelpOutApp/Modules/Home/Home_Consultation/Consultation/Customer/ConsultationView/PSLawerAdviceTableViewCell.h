//
//  PSLawerAdviceTableViewCell.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/12/19.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSConsultation.h"
@interface PSLawerAdviceTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *moneyLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UIImageView *ratingImg;

@property (nonatomic , strong) UIButton *statusButton;
@property (nonatomic , strong) UIButton *categoryButton;
-(void)fillWithModel:(PSConsultation*)model;

@end
