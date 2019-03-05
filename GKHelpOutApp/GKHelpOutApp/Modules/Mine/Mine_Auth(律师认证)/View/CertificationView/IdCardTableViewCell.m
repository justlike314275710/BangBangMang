//
//  IdCardTableViewCell.m
//  DSSettingDataSource
//
//  Created by 狂生烈徒 on 2019/2/26.
//  Copyright © 2019年 HelloAda. All rights reserved.
//

#import "IdCardTableViewCell.h"

@implementation IdCardTableViewCell
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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)renderContents{
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.frontCardButton];
    [self.contentView addSubview:self.backCardButton];
    
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable=[[UILabel alloc]initWithFrame:CGRectMake(15, 5,self.contentView .frame.size.width , 20)];
        _titleLable.text=@"身份证照片";
        _titleLable.font=[UIFont systemFontOfSize:12];
        _titleLable.textColor=[UIColor blackColor];
    }
    return _titleLable;
}

- (UIButton *)frontCardButton{
    if (!_frontCardButton) {
        CGFloat width=129.0f;
        CGFloat height=90.0f;
        CGFloat sidding=(SCREEN_WIDTH-width*2)/3;
        _frontCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_frontCardButton setBackgroundImage:[UIImage imageNamed:@"上传正面身份证底"] forState:UIControlStateNormal];
        [_frontCardButton setImage:[UIImage imageNamed:@"注册个人信息-上传照片"] forState:UIControlStateNormal];
        _frontCardButton.frame=CGRectMake(sidding, 30, width, height);
    }
    return _frontCardButton;
}

- (UIButton *)backCardButton{
    if (!_backCardButton) {
        CGFloat width=129.0f;
        CGFloat height=90.0f;
        CGFloat sidding=(SCREEN_WIDTH-width*2)/3;
        _backCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backCardButton setBackgroundImage:[UIImage imageNamed:@"上传背面身份证底"] forState:UIControlStateNormal];
        [_backCardButton setImage:[UIImage imageNamed:@"注册个人信息-上传照片"] forState:UIControlStateNormal];
        _backCardButton.frame=CGRectMake(sidding*2+129, 30, width, height);
    }
    return _backCardButton;
}

@end
