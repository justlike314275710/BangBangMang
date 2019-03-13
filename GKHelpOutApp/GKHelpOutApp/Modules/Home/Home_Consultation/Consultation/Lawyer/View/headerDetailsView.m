//
//  headerDetailsView.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/11.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "headerDetailsView.h"

@implementation headerDetailsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    _avaterImage = [UIImageView new];
    [self addSubview:_avaterImage ];
    [_avaterImage  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sidePidding);
        make.top.mas_equalTo(sidePidding);
        make.size.mas_equalTo(CGSizeMake(2 * radius, 2 * radius));
    }];
    [_avaterImage  setImage:[UIImage imageNamed:@"登录－头像"]];
    _avaterImage .layer.masksToBounds = YES;
    _avaterImage .layer.cornerRadius = radius;
    _avaterImage .layer.borderWidth=1;
    _avaterImage .layer.borderColor=[UIColor whiteColor].CGColor;
    
    
    _namelable = [UILabel new];
    _namelable .font = FontOfSize(14);
    _namelable .textColor = [UIColor blackColor];
    _namelable .textAlignment = NSTextAlignmentLeft;
    [self addSubview:_namelable ];
    [_namelable  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avaterImage.mas_right).offset(10);
        make.top.mas_equalTo(sidePidding+5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(16);
    }];
    _namelable .text=@"王二二";
    
    _timelable= [UILabel new];
    _timelable.font = FontOfSize(12);
    _timelable.textColor =AppBaseTextColor1;
    _timelable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_timelable];
    [_timelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avaterImage.mas_right).offset(10);
        make.top.mas_equalTo(self.namelable.mas_bottom).offset(5);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(16);
    }];
    
   // ViewBorderRadius(self.typeLab, 10, 1, CFontColor_LawTitle);
    _catagoylable=[UILabel new];
    [self addSubview: _catagoylable];
    [ _catagoylable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.namelable.mas_right).offset(10);
        make.top.mas_equalTo(sidePidding+2);
        make.width.mas_equalTo(69);
        make.height.mas_equalTo(20);
    }];
    ViewBorderRadius(_catagoylable, 10, 1, CFontColor_LawTitle);
    _catagoylable.textColor=CFontColor_LawTitle;
    _catagoylable.text=@"财务纠纷";
    _catagoylable.font=FontOfSize(12);
    _catagoylable.textAlignment=NSTextAlignmentCenter;

    
    _moneylable=[UILabel new];
     [self addSubview: _moneylable];
    [ _moneylable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(sidePidding);
        make.width.mas_equalTo(69);
        make.height.mas_equalTo(20);
    }];
    _moneylable.textColor=CFontColor_LawTitle;
    _moneylable.font=FontOfSize(14);
    _moneylable.text=@"¥39.9";
    
    
    _timelable=[UILabel new];
    _timelable.font = FontOfSize(12);
    _timelable.textColor = AppBaseTextColor1;
    _timelable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_timelable];
    [_timelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avaterImage.mas_right).offset(10);
        make.top.mas_equalTo(self.namelable.mas_bottom).offset(20);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(16);
    }];
   // _timelable.text=@"2018-08-08  10:19";
    
   
    _numberlable=[UILabel new];
    _numberlable.font = FontOfSize(12);
    _numberlable.textColor = AppBaseTextColor1;
    _numberlable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_numberlable];
    [_numberlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avaterImage.mas_right).offset(10);
        make.top.mas_equalTo(self.timelable.mas_bottom).offset(5);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(16);
    }];
 //   _numberlable.text=@"编号：127927336493434";
    
    UIView*lineView=[UIView new];
    lineView.backgroundColor =[UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sidePidding);
        make.right.mas_equalTo(-sidePidding);
        make.top.mas_equalTo(self.avaterImage.mas_bottom).offset(10);
        make.height.mas_equalTo(2);
    }];
    
}

@end
