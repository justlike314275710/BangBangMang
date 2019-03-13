//
//  PSLawerAdviceTableViewCell.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/12/19.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSLawerAdviceTableViewCell.h"
//#import "PSSessionManager.h"
//#import "PSBusinessConstants.h"
@implementation PSLawerAdviceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
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
    CGFloat sidePidding=16.0f;
    UIView *bgview = [[UIView alloc] init];
    bgview.frame = CGRectMake(20,0,SCREEN_WIDTH-40,153);
    bgview.backgroundColor = [UIColor whiteColor];
    bgview.layer.shadowColor = [UIColor colorWithRed:14/255.0 green:39/255.0 blue:85/255.0 alpha:0.28].CGColor;
    bgview.layer.shadowOffset = CGSizeMake(0,1);
    bgview.layer.shadowOpacity = 1;
    bgview.layer.shadowRadius = 3;
    bgview.layer.cornerRadius = 5;
    [self addSubview:bgview];
    
    
    UIView*headViewBG=[[UIView alloc]init];
    headViewBG.backgroundColor= [UIColor colorWithRed:255/255.0 green:246/255.0 blue:233/255.0 alpha:1.0];
    [bgview addSubview:headViewBG];
    [headViewBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
    }];
    UILabel*headLable=[UILabel new];
    [headViewBG addSubview:headLable];
    [headLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
    }];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"指定订单" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:182/255.0 green:114/255.0 blue:52/255.0 alpha:1.0]}];
    
    headLable.attributedText = string;
    headLable.textAlignment=NSTextAlignmentCenter;
    headLable.font=FontOfSize(12);
   
    
    _nameLab=[UILabel new];
    [bgview addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sidePidding);
        make.top.mas_equalTo(35);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    _nameLab.font=FontOfSize(12);
    _nameLab.textAlignment=NSTextAlignmentLeft;
    
    
    _headImg = [UIImageView new];
    [bgview addSubview:self.headImg];
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sidePidding);
        make.top.mas_equalTo(_nameLab.mas_bottom).mas_offset(5);
        make.width.height.mas_equalTo(42);
    }];
    _headImg.layer.cornerRadius=21;
    _headImg.layer.masksToBounds=YES;
    
 
    
    
    _statusButton=[UIButton new];
    [bgview addSubview:_statusButton];
    [_statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-sidePidding);
        make.top.mas_equalTo(35);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
    }];
    _statusButton.titleLabel.font=FontOfSize(12);
    
    _moneyLab=[UILabel new];
    [bgview addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImg.mas_right).offset(10);
        make.top.mas_equalTo(self.nameLab.mas_bottom);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    _moneyLab.textColor=UIColorFromRGB(243, 72, 0);
    _moneyLab.font=FontOfSize(10);
    
    _categoryButton=[UIButton new];
    [bgview addSubview:_categoryButton];
    CGFloat btnW=57;
    [_categoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImg.mas_right).offset(10);
        make.top.mas_equalTo(self.moneyLab.mas_bottom).offset(5);
        make.width.mas_equalTo(btnW);
        make.height.mas_equalTo(20);
    }];
    [ _categoryButton setTitleColor:UIColorFromRGB(255, 138, 7) forState:UIControlStateNormal];
     _categoryButton.titleLabel.textAlignment =NSTextAlignmentLeft;
    //NSTextAlignmentCenter;
     _categoryButton.titleLabel.font = FontOfSize(10);
     _categoryButton.titleLabel.numberOfLines=0;
    [_categoryButton.layer setCornerRadius:10.0];
    [_categoryButton.layer setBorderWidth:1.0];
    _categoryButton.layer.borderColor=(UIColorFromRGB(255, 138, 7)).CGColor;
    
    _timeLab=[UILabel new];
    [bgview addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_moneyLab.mas_right).offset(5);
        make.top.mas_equalTo(self.nameLab.mas_bottom);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    }];
    _timeLab.text=@"2018-08-03 12:13";
    _timeLab.textColor=AppBaseTextColor1;
    _timeLab.font=FontOfSize(10);
    _timeLab.textAlignment=NSTextAlignmentLeft;
    
    UIView*line_view=[UIView new];
    [bgview addSubview:line_view];
    [line_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImg.mas_bottom).mas_equalTo(5);
        make.right.mas_equalTo(-sidePidding);
        make.left.mas_equalTo(sidePidding);
        make.height.mas_equalTo(1);
    }];
    line_view.backgroundColor=AppBaseLineColor;
    
    _contentLab=[UILabel new];
    [bgview addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_view.mas_bottom).mas_equalTo(5);
        make.right.mas_equalTo(-sidePidding);
        make.left.mas_equalTo(sidePidding);
        make.height.mas_equalTo(40);
    }];
    _contentLab.numberOfLines=0;
    [_contentLab setTextColor:AppBaseTextColor1];
    // _contentLab.text=@"我想咨询个人隐私问题，我对象通过他在派出所的朋友关 系私自调出我的微信消费记录聊天记录，侵犯我的权利...";
    _contentLab.font=FontOfSize(12);
    
    
}


-(void)fillWithModel:(PSConsultation*)model{
    self.nameLab.text=@"";
    NSString*avatarUrl=@"";
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:@"登录－头像"]];
    NSString*yearTime=[model.createdTime substringToIndex:10];
    NSRange range1 = NSMakeRange(11, 5);
    NSString*minunteTime=[model.createdTime substringWithRange:range1];
    _timeLab.text=[NSString stringWithFormat:@"%@ %@",yearTime,minunteTime];
    _contentLab.text=model.des;
    _moneyLab.text=[NSString stringWithFormat:@"¥%.2f",[model.reward floatValue]];
    [ _categoryButton setTitle:model.category forState:UIControlStateNormal];
    if ([model.status isEqualToString:@"PENDING_PAYMENT"]) {
        model.payStatus=@"待付款";
        [_statusButton setTitleColor:UIColorFromRGB(255, 138, 7) forState:0];
    }
    else if ([model.status isEqualToString:@"PENDING_APPROVAL"]){
        model.payStatus=@"待审核";
        [_statusButton setTitleColor:AppBaseTextColor3 forState:0];
    }
    else if ([model.status isEqualToString:@"PENDING_ACCEPT"]){
        model.payStatus=@"待接单";
        [_statusButton setTitleColor:AppBaseTextColor3 forState:0];
    }
    else if ([model.status isEqualToString:@"ACCEPTED"]){
        model.payStatus=@"已接单";
        [_statusButton setTitleColor:AppBaseTextColor3 forState:0];
    }
    else if ([model.status isEqualToString:@"COMPLETE"]){
        model.payStatus=@"已完成";
        [_statusButton setTitleColor:AppBaseTextColor3 forState:0];
    }
    else if ([model.status isEqualToString:@"CLOSED"]){
        model.payStatus=@"已关闭";
        [_statusButton setTitleColor:[UIColor redColor] forState:0];
    }
    else if([model.status isEqualToString:@"CANCELLED"]){
        model.payStatus=@"已取消";
        [_statusButton setTitleColor:[UIColor redColor] forState:0];
    }
    else{
        
    }
    [_statusButton setTitle:model.payStatus forState:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
