//
//  PSLawyerView.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/2.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSLawyerView.h"

@implementation PSLawyerView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self renderContents];
    }
    return self;
}
-(void)renderContents{
    self.backgroundColor = [UIColor clearColor];
    
    UIImageView*backImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"律师信息底"]];
    [self addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    CGFloat radius = 30;
    CGFloat sidePidding=15;
    CGFloat topPidding=23;
    
    UIImageView*avatarBackView=[UIImageView new];
    [avatarBackView setImage:[UIImage imageNamed:@"头像底"]];
    [backImageView addSubview:avatarBackView];
    [avatarBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sidePidding);
        make.top.mas_equalTo(topPidding);
        make.width.height.mas_equalTo(2*radius+1);
    }];
    
    _avatarView=[UIImageView new];
    [_avatarView setImage:[UIImage imageNamed:@"律师详情－头像"]];
    [avatarBackView addSubview:_avatarView];
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(1);
        make.right.bottom.mas_equalTo(-1);
    }];

    _nicknameLabel = [UILabel new];
    _nicknameLabel.font = FontOfSize(14);
    _nicknameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    _nicknameLabel.textAlignment = NSTextAlignmentLeft;
    [backImageView addSubview:_nicknameLabel];
    [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).offset(10);
        make.top.mas_equalTo(topPidding);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(16);
    }];
    _nicknameLabel.text=@"张三";


    _addressLable = [UILabel new];
    _addressLable.font = FontOfSize(12);
    _addressLable.textColor = AppBaseTextColor1;
    _addressLable.textAlignment = NSTextAlignmentLeft;
    [backImageView addSubview:_addressLable];
    [_addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).offset(10);
        make.top.mas_equalTo(self.nicknameLabel.mas_bottom);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(16);
    }];
    _addressLable.text=@"执业律所：红黄蓝律师事务所";

    //self.categories=help_userManager.lawUserInfo.categories;
    [self bulidLawyerModel];
   // NSArray *arr = @[@"财务纠纷",@"婚姻家庭"];
    CGFloat btnW = 60;
    for (int i = 0; i < self.categories.count; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(80+i * (btnW+10), _addressLable.bottom + 60, btnW, 20)];
        [button setTitleColor:UIColorFromRGB(255, 138, 7) forState:UIControlStateNormal];
        [button setTitle:self.categories[i] forState:UIControlStateNormal];
        button.titleLabel.textAlignment =NSTextAlignmentLeft;
        //NSTextAlignmentCenter;
        button.titleLabel.font = FontOfSize(12);
        button.titleLabel.numberOfLines=0;
        [button.layer setCornerRadius:10.0];
        [button.layer setBorderWidth:1.0];
        button.layer.borderColor=(UIColorFromRGB(255, 138, 7)).CGColor;
        [backImageView addSubview:button];
    }
    
    UIButton*lawyerButton=[UIButton new];
    [backImageView addSubview:lawyerButton];
    [lawyerButton setTitle:@"认证律师" forState:0];
    [lawyerButton setImage:[UIImage imageNamed:@"认证icon"] forState:0];
    lawyerButton.titleLabel.font=FontOfSize(12);
    [lawyerButton setTitleColor:AppBaseTextColor3 forState:0];
    [lawyerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(topPidding);
    }];
    
}
- (void)bulidLawyerModel{

    self.categories=[[NSMutableArray alloc]init];
    for (int i=0; i<help_userManager.lawUserInfo.categories.count; i++) {
        if ([help_userManager.lawUserInfo.categories[i] isEqualToString:@"PROPERTY_DISPUTES"]) {
            [self.categories addObject:@"财产纠纷"];
        }
        else if ([help_userManager.lawUserInfo.categories[i] isEqualToString:@"MARRIAGE_FAMILY"]){
            [self.categories addObject:@"婚姻家庭"];
        }
        else if ([help_userManager.lawUserInfo.categories[i] isEqualToString:@"TRAFFIC_ACCIDENT"]){
            [self.categories addObject:@"交通事故"];
        }
        else if ([help_userManager.lawUserInfo.categories[i] isEqualToString:@"WORK_COMPENSATION"]){
            [self.categories addObject:@"工伤赔偿"];
        }
        else if ([help_userManager.lawUserInfo.categories[i] isEqualToString:@"CONTRACT_DISPUTE"]){
            [self.categories addObject:@"合同纠纷"];
        }
        else if ([help_userManager.lawUserInfo.categories[i] isEqualToString:@"CRIMINAL_DEFENSE"]){
            [self.categories addObject:@"刑事辩护"];
        }
        else if ([help_userManager.lawUserInfo.categories[i] isEqualToString:@"HOUSING_DISPUTES"]){
            [self.categories addObject:@"房产纠纷"];
        }
        else if ([help_userManager.lawUserInfo.categories[i] isEqualToString:@"LABOR_EMPLOYMENT"]){
            [self.categories addObject:@"劳动就业"];
        }}

}
/*
-(void)renderContents{
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat radius = 27;
    CGFloat sidePidding=15;
    _avatarView = [UIImageView new];
    _avatarView.layer.cornerRadius = radius;
    _avatarView.layer.borderWidth = 1.0;
    _avatarView.layer.borderColor = [UIColor whiteColor].CGColor;
//    _avatarView.photoWidth = radius * 2;
//    _avatarView.photoHeight = radius * 2;
    [_avatarView setImage:[UIImage imageNamed:@"头像"]];
    [self addSubview:_avatarView];
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(sidePidding);
        make.size.mas_equalTo(CGSizeMake(2 * radius, 2 * radius));
    }];
    
    _nicknameLabel = [UILabel new];
    _nicknameLabel.font = FontOfSize(14);
    _nicknameLabel.textColor = AppBaseTextColor1;
    _nicknameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_nicknameLabel];
    [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatarView.mas_right).offset(10);
        make.top.mas_equalTo(sidePidding);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
    }];
    _nicknameLabel.text=@"张三";
    
    
    _addressLable = [UILabel new];
    _addressLable.font = FontOfSize(12);
    _addressLable.textColor = AppBaseTextColor1;
    _addressLable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_addressLable];
    [_addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatarView.mas_right).offset(10);
        make.top.mas_equalTo(_nicknameLabel.mas_bottom);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(16);
    }];
    _addressLable.text=@"执业律所：红黄蓝律师事务所";
    
    
    NSArray *arr = @[@"财务纠纷",@"婚姻家庭"];
    CGFloat btnW = 60;
    for (int i = 0; i < arr.count; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(80+i * (btnW+5), CGRectGetMaxY(_addressLable.frame) + 50, btnW, 16)];
        [button setTitleColor:UIColorFromRGB(255, 138, 7) forState:UIControlStateNormal];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.titleLabel.textAlignment =NSTextAlignmentLeft;
        //NSTextAlignmentCenter;
        button.titleLabel.font = FontOfSize(12);
        button.titleLabel.numberOfLines=0;
        [button.layer setCornerRadius:8.0];
        [button.layer setBorderWidth:1.0];
        button.layer.borderColor=(UIColorFromRGB(255, 138, 7)).CGColor;
        [self addSubview:button];
    }
    
    UIView*bgView=[UIView new];
    [self addSubview:bgView];
    bgView.backgroundColor=[UIColor whiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(85);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    
    UIView*lineview_one=[UIView new];
    lineview_one.backgroundColor=AppBaseLineColor;
    [bgView addSubview:lineview_one];
    [lineview_one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((SCREEN_WIDTH-2*sidePidding)/3);
        make.top.mas_equalTo(bgView.mas_top).offset(10);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(44);
    }];
    
    
    
 
    
    UILabel*numberLable=[UILabel new];
    [bgView addSubview:numberLable];
    numberLable.textAlignment=NSTextAlignmentCenter;
    numberLable.font=FontOfSize(16);
    numberLable.textColor=[UIColor blackColor];
    numberLable.text=@"120";
    [numberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sidePidding);
        make.top.mas_equalTo(sidePidding);
        make.right.mas_equalTo(lineview_one.mas_left).offset(-sidePidding);
        make.height.mas_equalTo(20);
    }];
    
    UILabel*numberTitleLable=[UILabel new];
    [bgView addSubview:numberTitleLable];
    numberTitleLable.text=@"接单数";
    numberTitleLable.textAlignment=NSTextAlignmentCenter;
    numberTitleLable.font=FontOfSize(10);
    numberTitleLable.textColor=AppBaseTextColor1;
    [numberTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sidePidding);
        make.top.mas_equalTo(numberLable.mas_bottom);
        make.right.mas_equalTo(lineview_one.mas_left).offset(-sidePidding);
        make.height.mas_equalTo(18);
    }];
    
    UIView*lineview_two=[UIView new];
    [bgView addSubview:lineview_two];
    lineview_two.backgroundColor=AppBaseLineColor;
    [lineview_two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((SCREEN_WIDTH-2*sidePidding)*2/3);
        make.top.mas_equalTo(bgView.mas_top).offset(10);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(44);
    }];
    
    _starsControl = [CDZStarsControl.alloc initWithFrame:CGRectMake((SCREEN_WIDTH-2*sidePidding)/3+5, sidePidding, 85 , 20) stars:5 starSize:CGSizeMake(15, 15) noramlStarImage:[UIImage imageNamed:@"灰星星"] highlightedStarImage:[UIImage imageNamed:@"黄星星"]];
    
    _starsControl.delegate = self;
    _starsControl.allowFraction = YES;
    _starsControl.score = 3.6f;
    [bgView addSubview:_starsControl];
    
    UILabel*starsLable=[UILabel new];
    [bgView addSubview:starsLable];
    starsLable.text=@"评分";
    starsLable.textAlignment=NSTextAlignmentCenter;
    starsLable.font=FontOfSize(10);
    starsLable.textColor=AppBaseTextColor1;
    [starsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineview_one.mas_left).offset(sidePidding);
        make.top.mas_equalTo(35);
        make.right.mas_equalTo(lineview_two.mas_left).offset(-sidePidding);
        make.height.mas_equalTo(18);
    }];
   
    UILabel*GradeLable=[UILabel new];
    [bgView addSubview:GradeLable];
    GradeLable.textAlignment=NSTextAlignmentCenter;
    GradeLable.font=FontOfSize(16);
    GradeLable.textColor=[UIColor blackColor];
    GradeLable.text=@"二级";
    [GradeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineview_two.mas_left).offset(sidePidding);
        make.top.mas_equalTo(sidePidding);
        make.right.mas_equalTo(bgView.mas_right).offset(-sidePidding);
        make.height.mas_equalTo(20);
    }];
    
    UILabel*GradeTitleLable=[UILabel new];
    [bgView addSubview:GradeTitleLable];
    GradeTitleLable.text=@"等级";
    GradeTitleLable.textAlignment=NSTextAlignmentCenter;
    GradeTitleLable.font=FontOfSize(10);
    GradeTitleLable.textColor=AppBaseTextColor1;
    [GradeTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineview_two.mas_left).offset(sidePidding);
        make.top.mas_equalTo(GradeLable.mas_bottom);
        make.right.mas_equalTo(bgView.mas_right).offset(-sidePidding);
        make.height.mas_equalTo(18);
    }];
    
    
    UILabel*lawyerLable=[UILabel new];
    lawyerLable.font=FontOfSize(11);
    lawyerLable.textColor=AppBaseTextColor1;
    lawyerLable.numberOfLines=0;
    lawyerLable.text=@"律师介绍：本人现执业于红黄蓝律师事务所,研究生学历，有着丰富的办案经验，经办过很多的民事纠纷。在刑事辩护领域也取得了很多罪犯辩护 候审缓刑成功案例";
    [self addSubview:lawyerLable];
    [lawyerLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(bgView.mas_bottom).offset(15);
        make.right.mas_equalTo(-sidePidding);
        make.height.mas_equalTo(42);
    }];
    
 
}
*/
@end
