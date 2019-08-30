//
//  PersonTableViewCell.m
//  DSSettingDataSource
//
//  Created by 狂生烈徒 on 2019/2/26.
//  Copyright © 2019年 HelloAda. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#import "PersonTableViewCell.h"
@interface PersonTableViewCell()

@property (nonatomic, strong) UIView*mainView;
@property (nonatomic, strong) UILabel *titleLbl;//标题


@end
@implementation PersonTableViewCell

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
    //[self addSubview:self.mainView];
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.personText];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView *)mainView{
    if (!_mainView) {
        _mainView=[UIView new];
        _mainView.frame=CGRectMake(0, 0, self.contentView.frame.size.width, self.frame.size.height);
        //_mainView.backgroundColor=[UIColor whiteColor];
    }
    return _mainView;
}


- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(15, 5,self.contentView .frame.size.width , 20)];
        _titleLbl.text=@"个人简介";
        _titleLbl.font=[UIFont systemFontOfSize:12];
        _titleLbl.textColor=[UIColor blackColor];
    }
    return _titleLbl;
}


- (UITextView *)personText{
    if (!_personText) {
        _personText=[[dashedTextview alloc]initWithFrame:CGRectMake(15, 30,  SCREEN_WIDTH-30, 60)];
        _personText.placeholder=@"请简单介绍下自己,一百字以内";
        _personText.textColor=[UIColor blackColor];
//        _personText.layer.borderColor=[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0].CGColor;
//        _personText.layer.borderWidth = 0.5f;
//        _personText.layer.masksToBounds=YES;
        
        
    }
    return _personText;
}
@end
