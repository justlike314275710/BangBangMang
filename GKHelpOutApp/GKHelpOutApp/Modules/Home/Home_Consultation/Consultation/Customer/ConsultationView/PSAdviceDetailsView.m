//
//  PSAdviceDetailsView.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/6.
//  Copyright © 2018年 calvin. All rights reserved.

#import "PSAdviceDetailsView.h"
#import "MJExtension.h"

@implementation PSAdviceDetailsView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self renderContents];
    }
    return self;
}





-(void)renderContents{
    self.backgroundColor = [UIColor whiteColor];
    CGFloat radius = 42;
    CGFloat sidePidding=15;
    _avatarView = [UIImageView new];
    [self addSubview:_avatarView];
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sidePidding);
        make.top.mas_equalTo(sidePidding);
        make.size.mas_equalTo(CGSizeMake(2 * radius, 2 * radius));
    }];
    [_avatarView setImage:[UIImage imageNamed:@"订单大头像"]];
    _avatarView.layer.masksToBounds = YES;
    _avatarView.layer.cornerRadius = radius;
    _avatarView.layer.borderWidth=1;
    _avatarView.layer.borderColor=[UIColor whiteColor].CGColor;
    
    
    _nicknameLabel = [UILabel new];
    _nicknameLabel.font = FontOfSize(14);
    _nicknameLabel.textColor = [UIColor blackColor];
    _nicknameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_nicknameLabel];
    [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatarView.mas_right).offset(10);
        make.top.mas_equalTo(sidePidding+5);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(16);
    }];
    _nicknameLabel.text=@"王二二";
    
    _lawerTimeLabel = [UILabel new];
    _lawerTimeLabel.font = FontOfSize(12);
    _lawerTimeLabel.textColor = AppBaseTextColor1;
    _lawerTimeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_lawerTimeLabel];
    [_lawerTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(_avatarView.mas_right).offset(10);
        make.top.mas_equalTo(_nicknameLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(16);
    }];
   
    _categoryButton=[UIButton new];
    [self addSubview:_categoryButton];
    [_categoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatarView.mas_right).offset(10);
        make.top.mas_equalTo(sidePidding);
        make.width.mas_equalTo(69);
        make.height.mas_equalTo(20);
    }];
    [_categoryButton setTitleColor:UIColorFromRGB(255, 138, 7) forState:UIControlStateNormal];
    [ _categoryButton setTitle:@"财务纠纷" forState:UIControlStateNormal];
    _categoryButton.titleLabel.textAlignment =NSTextAlignmentLeft;
    //NSTextAlignmentCenter;
    _categoryButton.titleLabel.font = FontOfSize(10);
    _categoryButton.titleLabel.numberOfLines=0;
    [_categoryButton.layer setCornerRadius:10.0];
    [_categoryButton.layer setBorderWidth:1.0];
    _categoryButton.layer.borderColor=(UIColorFromRGB(255, 138, 7)).CGColor;
    
    
    _numberLable=[UILabel new];
    _numberLable.font = FontOfSize(12);
    _numberLable.textColor = AppBaseTextColor1;
    _numberLable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_numberLable];
    [_numberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatarView.mas_right).offset(10);
        make.top.mas_equalTo(_lawerTimeLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(16);
    }];
    
   _titleLable=[UILabel new];
    _titleLable.font = FontOfSize(12);
    _titleLable.textColor = AppBaseTextColor1;
    _titleLable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLable];
    _titleLable.text=@"评分:";
    _titleLable.frame=CGRectMake(110, 70+18-5, 36, 12);
    
    _starsControl = [CDZStarsControl.alloc initWithFrame:CGRectMake(140, 65+18-5, 85 , 20) stars:5 starSize:CGSizeMake(15, 15) noramlStarImage:[UIImage imageNamed:@"灰星星"] highlightedStarImage:[UIImage imageNamed:@"黄星星"]];
    
    _starsControl.delegate = self;
    _starsControl.allowFraction = YES;
    _starsControl.enabled=NO;
    [self addSubview:_starsControl];

    
    _rewardLable=[UILabel new];
    _rewardLable.font = FontOfSize(13);
    _rewardLable.textColor = UIColorFromRGB(255, 102, 0);
    _rewardLable.textAlignment = NSTextAlignmentRight;
    [self addSubview: _rewardLable];
    [ _rewardLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-sidePidding);
        make.top.mas_equalTo(sidePidding);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(16);
    }];
    

//    UIView*lineView=[UIView new];
//    [self addSubview:lineView];
//    lineView.backgroundColor=AppBaseLineColor;
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(120);
//        make.left.mas_equalTo(sidePidding);
//        make.right.mas_equalTo(-sidePidding);
//        make.height.mas_equalTo(1);
//    }];
    
    
    _payStatusLable=[UILabel new];
     [self addSubview:_payStatusLable];
    [_payStatusLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_avatarView.mas_bottom).offset(15);
        make.left.mas_equalTo(sidePidding);
        make.right.mas_equalTo(-sidePidding);
        make.height.mas_equalTo(16);
    }];
   // _payStatusLable.text=@"已退款";
    _payStatusLable.textColor=[UIColor redColor];
    _payStatusLable.textAlignment=NSTextAlignmentLeft;
    _payStatusLable.font=FontOfSize(14);
   
    

    UILabel*payTips=[UILabel new];
     [self addSubview:payTips];
    [payTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_payStatusLable.mas_bottom).offset(10);
        make.left.mas_equalTo(sidePidding);
        make.right.mas_equalTo(-sidePidding);
        make.height.mas_equalTo(48);
    }];
    payTips.text=@"＊三天内无人接单，系统自动取消 ;\n  无人接单／律师拒单后，付款金额将于7个工作日内原路返回。\n  每笔订单视频通话时长为20分钟，通话时长未用完结束;\n  订单一律不退还费用!";
    payTips.numberOfLines=0;
    payTips.textColor=AppBaseTextColor1;
    payTips.font=FontOfSize(10);
   
    
    UIView*lineboomView=[UIView new];
    [self addSubview:lineboomView];
    lineboomView.backgroundColor=AppBaseLineColor;
    [lineboomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payTips.mas_bottom).offset(15);
        make.left.mas_equalTo(sidePidding);
        make.right.mas_equalTo(-sidePidding);
        make.height.mas_equalTo(1);
    }];
    
    
}

@end
