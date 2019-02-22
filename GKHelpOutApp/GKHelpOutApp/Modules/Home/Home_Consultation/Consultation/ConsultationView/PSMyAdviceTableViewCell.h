//
//  PSMyAdviceTableViewCell.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/1.
//  Copyright © 2018年 calvin. All rights reserved.
//
typedef NS_ENUM(NSInteger, PSAdviceType) {
    PSAdviceTypeNone,
    PSAdviceTypeHeader,
    
};
#import <UIKit/UIKit.h>
#import "PSConsultation.h"
@interface PSMyAdviceTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UIImageView *ratingImg;
@property (nonatomic , strong) UIButton *moneyButton;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic , strong) UIButton *categoryButton;
@property (nonatomic , assign) PSAdviceType *type;
@property (nonatomic,strong)  UIImageView *statusImg;

@property (nonatomic , strong)  UIView *bgview ;
@property (nonatomic , strong)  UIButton*detailButton;
@property (nonatomic , strong)  UIButton*videoButton;

-(void)fillWithModel:(PSConsultation*)model;

-(void)fillWithpubicAvatar:(NSString*)avatar;

@end
