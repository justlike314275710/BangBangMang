//
//  PSEvaluateTableViewCell.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/5.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSEvaluateTableViewCell.h"

@implementation PSEvaluateTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self renderContents];
    }
    return self;
}

- (void)renderContents {
    
    UIView *bgview = [[UIView alloc] init];
    bgview.frame = CGRectMake(0,0,SCREEN_WIDTH-30,110);
    bgview.layer.masksToBounds = YES;
    bgview.backgroundColor = [UIColor whiteColor];
    bgview.layer.shadowColor = [UIColor colorWithRed:14/255.0 green:39/255.0 blue:85/255.0 alpha:0.28].CGColor;
    bgview.layer.shadowOffset = CGSizeMake(0,1);
    bgview.layer.shadowOpacity = 1;
    bgview.layer.shadowRadius = 3;
    bgview.layer.cornerRadius = 5;
    [self addSubview:bgview];
    
    UIView*line_view=[UIView new];
    line_view.backgroundColor=UIColorFromRGB(255, 138, 7);
    [bgview addSubview:line_view];
    [line_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(5);
        make.width.mas_equalTo(2);
        make.height.mas_equalTo(16);
    }];
    
    UILabel*evaluateTitleLable=[UILabel new];
    [bgview addSubview:evaluateTitleLable];
    evaluateTitleLable.text=@"评分:";
    evaluateTitleLable.font=FontOfSize(10);
    evaluateTitleLable.textColor=AppBaseTextColor1;
    [evaluateTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(12);
    }];


    _starsControl = [CDZStarsControl.alloc initWithFrame:CGRectMake(45, 0, 60 , 20) stars:5 starSize:CGSizeMake(10, 10) noramlStarImage:[UIImage imageNamed:@"灰星星"] highlightedStarImage:[UIImage imageNamed:@"黄星星"]];
    _starsControl.delegate = self;
    _starsControl.allowFraction = YES;
    _starsControl.score = 5.0f;
    [bgview addSubview:_starsControl];
    
    
    UILabel*evaluateLable=[UILabel new];
    [bgview addSubview:evaluateLable];
    evaluateLable.text=@"谢谢张律师的指导，帮我解决了困扰的事情，工作认真负责，很专业下次如果还有需要还要找他帮助！";
    evaluateLable.numberOfLines=0;
    evaluateLable.textColor=AppBaseTextColor1;
    evaluateLable.font=FontOfSize(10);
    [evaluateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(evaluateTitleLable.mas_bottom).offset(15);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(28);
    }];
    
    UILabel*nameLable=[UILabel new];
    nameLable.text=@"王二二";
    nameLable.textColor=AppBaseTextColor3;
    nameLable.font=FontOfSize(10);
    [bgview addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(evaluateLable.mas_bottom).offset(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(12);
    }];
    
    UILabel*timeLable=[UILabel new];
    timeLable.text=@"2018.9.17";
    timeLable.textColor=AppBaseTextColor1;
    timeLable.font=FontOfSize(10);
    [bgview addSubview:timeLable];
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLable.mas_right);
        make.top.mas_equalTo(evaluateLable.mas_bottom).offset(15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(12);
    }];
    
    UIImageView*iconView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"用户头像"]];
    [bgview addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(evaluateLable.mas_bottom).offset(12);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
}

@end
