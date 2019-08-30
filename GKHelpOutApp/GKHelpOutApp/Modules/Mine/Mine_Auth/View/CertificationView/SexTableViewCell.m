//
//  SexTableViewCell.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/15.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "SexTableViewCell.h"

@implementation SexTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self renderContents];
    }
    return self;
}

-(void)renderContents{
    [self addSubview:self.titleLbl];
    [self addSubview:self.manBtn];
    [self addSubview:self.womenBtn];

}

-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.font = SYSTEMFONT(12);
        _titleLbl.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _titleLbl.frame=CGRectMake(KNormalSpace, 11, 80, 20);
        
    }
    return _titleLbl;
}


- (UIButton *)manBtn{
    if (!_manBtn) {
        _manBtn=[UIButton new];
        _manBtn.titleLabel.font=SYSTEMFONT(12);
        _manBtn.frame=CGRectMake(SCREEN_WIDTH-15-40-50, 11, 40, 20);
        [_manBtn setTitle:@"男" forState:0];
        [_manBtn setTitleColor:AppBaseTextColor1 forState:0];
        [_manBtn setImage:[UIImage imageNamed:@"已勾选"] forState:UIControlStateSelected];
        [_manBtn setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
    }
    return _manBtn;
}


- (UIButton *)womenBtn{
    if (!_womenBtn) {
        _womenBtn=[UIButton new];
        _womenBtn.titleLabel.font=SYSTEMFONT(12);
        _womenBtn.frame=CGRectMake(SCREEN_WIDTH-15-40, 11, 40, 20);
        [_womenBtn setTitle:@"女" forState:0];
        [_womenBtn setTitleColor:AppBaseTextColor1 forState:0];
        [_womenBtn setImage:[UIImage imageNamed:@"已勾选"] forState:UIControlStateSelected];
        [_womenBtn setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
    }
    return _womenBtn;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
