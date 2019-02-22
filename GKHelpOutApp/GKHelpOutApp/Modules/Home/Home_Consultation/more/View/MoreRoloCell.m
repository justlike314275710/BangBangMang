//
//  MoreRoloCell.m
//  PrisonService
//
//  Created by kky on 2018/10/25.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "MoreRoloCell.h"

@implementation MoreRoloCell


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
    bgview.frame = CGRectMake(20,0,SCREEN_WIDTH-40,102);
    bgview.layer.masksToBounds = YES;
    bgview.backgroundColor = [UIColor whiteColor];
    bgview.layer.shadowColor = [UIColor colorWithRed:14/255.0 green:39/255.0 blue:85/255.0 alpha:0.28].CGColor;
    bgview.layer.shadowOffset = CGSizeMake(0,1);
    bgview.layer.shadowOpacity = 1;
    bgview.layer.shadowRadius = 3;
    bgview.layer.cornerRadius = 5;
    [self addSubview:bgview];
    
    [bgview addSubview:self.stateImg];
    [self.stateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(56);
        make.height.mas_equalTo(47);
    }];
    
    [bgview addSubview:self.stateLab];
    [self.stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
    }];
    [self.stateLab setTransform:CGAffineTransformMakeRotation(-M_PI*0.25)];
    
    [bgview addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.stateImg.mas_right).offset(10);
        make.top.mas_equalTo(16);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    [bgview addSubview:self.headImg];
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.top.mas_equalTo(47);
        make.width.height.mas_equalTo(42);
    }];
    
    [bgview addSubview:self.officeLab];
    [self.officeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImg.mas_right).offset(16);
        make.top.mas_equalTo(45);
        make.width.mas_equalTo(SCREEN_WIDTH-200);
        make.height.mas_equalTo(30);
    }];
    
    [bgview addSubview:self.gradeLab];
    [self.gradeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImg.mas_right).offset(16);
        make.top.mas_equalTo(self.officeLab.mas_bottom).offset(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
    }];
    
    [bgview addSubview:self.levelLab];
    [self.levelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
    }];
    _starsControl = [CDZStarsControl.alloc initWithFrame:CGRectMake(117, 75, 85 , 20) stars:5 starSize:CGSizeMake(15, 15) noramlStarImage:[UIImage imageNamed:@"灰星星"] highlightedStarImage:[UIImage imageNamed:@"黄星星"]];

    _starsControl.delegate = self;
    _starsControl.allowFraction = YES;
    _starsControl.score = 3.6f;
    [bgview addSubview:_starsControl];
    
    
    [bgview addSubview:self.consultBtn];
    [self.consultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.officeLab);
        make.right.mas_equalTo(-14);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(22);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Setting&Getting
- (UIImageView *)stateImg {
    if (!_stateImg) {
        _stateImg = [UIImageView new];
        _stateImg.image = [UIImage imageNamed:@"繁忙标签底"];
    }
    return _stateImg;
}
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.text = @"尼古拉斯.藏三";
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.textColor = UIColorFromRGB(51,51,51);
        _nameLab.font = FontOfSize(12);
    }
    return _nameLab;
}

- (UILabel *)officeLab {
    if (!_officeLab) {
        _officeLab = [UILabel new];
        _officeLab.text = @"职业律所: 红黄蓝律师事务所";
        _officeLab.textAlignment = NSTextAlignmentLeft;
        _officeLab.textColor = UIColorFromRGB(51,51,51);
        _officeLab.font = FontOfSize(12);
        _officeLab.numberOfLines=0;
    }
    return _officeLab;
}

- (UILabel *)gradeLab {
    if (!_gradeLab) {
        _gradeLab = [UILabel new];
        _gradeLab.text = @"评分:";
        _gradeLab.textAlignment = NSTextAlignmentLeft;
        _gradeLab.textColor = UIColorFromRGB(51,51,51);
        _gradeLab.font = FontOfSize(12);
    }
    return _gradeLab;
}

- (UILabel *)stateLab {
    if (!_stateLab) {
        _stateLab = [UILabel new];
        _stateLab.text = @"繁忙";
        _stateLab.font = FontOfSize(11);
        [_stateLab setTextColor:[UIColor whiteColor]];
    }
    return _stateLab;
}

- (UILabel *)levelLab {
    if (!_levelLab) {
        _levelLab = [UILabel new];
        _levelLab.text = @"二级";
        _levelLab.font = FontOfSize(11);
        _levelLab.textColor = UIColorFromRGB(51,51,51);
        _levelLab.textAlignment = NSTextAlignmentRight;
    }
    return _levelLab;
}

- (UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [UIImageView new];
        _headImg.image = [UIImage imageNamed:@"头像"];
    }
    return _headImg;
}

- (UIButton *)consultBtn {
    if (!_consultBtn) {
        _consultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_consultBtn setTitle:@"立即咨询" forState:UIControlStateNormal];
        _consultBtn.titleLabel.font = FontOfSize(10);
        _consultBtn.layer.masksToBounds = YES;
        _consultBtn.layer.borderWidth = 1;
        _consultBtn.layer.cornerRadius = 11;
        _consultBtn.layer.borderColor = UIColorFromRGB(38, 76, 144).CGColor;
        [_consultBtn setTitleColor:UIColorFromRGB(38, 76, 144) forState:UIControlStateNormal];
    }
    return _consultBtn;
}



@end
