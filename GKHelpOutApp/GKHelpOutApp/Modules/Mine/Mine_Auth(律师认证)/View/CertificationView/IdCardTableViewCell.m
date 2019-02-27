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
        _frontCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_frontCardButton setBackgroundImage:[UIImage imageNamed:@"上传正面身份证底"] forState:UIControlStateNormal];
        [_frontCardButton setImage:[UIImage imageNamed:@"注册个人信息-上传照片"] forState:UIControlStateNormal];
        _frontCardButton.frame=CGRectMake(40, 30, 129, 90);
    }
    return _frontCardButton;
}

- (UIButton *)backCardButton{
    if (!_backCardButton) {
        _backCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backCardButton setBackgroundImage:[UIImage imageNamed:@"上传背面身份证底"] forState:UIControlStateNormal];
        [_backCardButton setImage:[UIImage imageNamed:@"注册个人信息-上传照片"] forState:UIControlStateNormal];
        _backCardButton.frame=CGRectMake(70+129, 30, 129, 90);
    }
    return _backCardButton;
}

@end
