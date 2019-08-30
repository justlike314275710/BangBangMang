//
//  LawyerAdviceTableViewCell.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//
#define LegalCellSpaceX  20
#import "LawyerAdviceTableViewCell.h"
@implementation LawyerAdviceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    CGFloat SHeight = 90;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,15, KScreenWidth, SHeight)];
    bgView.backgroundColor = KWhiteColor;
    bgView.layer.shadowColor = [UIColor colorWithRed:14/255.0 green:39/255.0 blue:85/255.0 alpha:0.28].CGColor;
    bgView.layer.shadowOffset = CGSizeMake(0,1);
    bgView.layer.shadowOpacity = 1;
    bgView.layer.shadowRadius = 3;
    [self addSubview:bgView];
    
    [bgView addSubview:self.noReadDotImg];
    self.noReadDotImg.frame = CGRectMake(LegalCellSpaceX,(SHeight-15)/2, 15, 15);
    
    [bgView addSubview:self.avatarImg];
    self.avatarImg.frame = CGRectMake(_noReadDotImg.right+7,(SHeight-54)/2, 54, 54);
    ViewRadius(self.avatarImg,54/2);
    
    [bgView addSubview:self.stateImg];
    self.stateImg.frame = CGRectMake(KScreenWidth-60,0,60, 50);
    
    //    [bgView addSubview:self.chatBtn];
    //    self.chatBtn.frame = CGRectMake(KScreenWidth-90,self.stateImg.bottom,66,24);
    
    [bgView addSubview:self.moneyLab];
    self.moneyLab.frame = CGRectMake(_avatarImg.right+15,_avatarImg.y,150, 20);
    
    [bgView addSubview:self.timeLab];
    self.timeLab.frame = CGRectMake(_avatarImg.right+15,_moneyLab.bottom,150, 20);
    
    [bgView addSubview:self.typeLab];
    self.typeLab.frame = CGRectMake(_avatarImg.right+15,_timeLab.bottom,57, 20);
    ViewBorderRadius(self.typeLab, 10, 1, CFontColor_LawTitle);
    
    [bgView addSubview:self.detailLab];
    self.detailLab.frame = CGRectMake(KScreenWidth-120,_timeLab.bottom,100,20);
    
    
    [bgView addSubview:self.chatBtn];
    self.chatBtn.frame = CGRectMake(KScreenWidth-90,_timeLab.bottom-3,66,24);
    
    [bgView addSubview:self.lawyerMoneyLab];
    self.lawyerMoneyLab.frame=CGRectMake(KScreenWidth-110, _moneyLab.y, 66, 12);
    
}

- (void)setNoRead:(BOOL)noRead {
    //ui变化
    if (noRead) {
        self.noReadDotImg.hidden = NO;
        self.chatBtn.hidden = NO;
        self.detailLab.hidden = YES;
        self.lawyerMoneyLab.hidden=YES;
        self.noReadDotImg.x = LegalCellSpaceX;
    } else {
        self.noReadDotImg.hidden = YES;
        self.chatBtn.hidden = YES;
        self.detailLab.hidden = NO;
        self.lawyerMoneyLab.hidden=YES;
        self.avatarImg.x = LegalCellSpaceX;
    }
    self.timeLab.x = _avatarImg.right+15;
    self.moneyLab.x = _avatarImg.right+15;
    self.typeLab.x = _avatarImg.right+15;
}

-(void)fillWithModel:(lawyerGrab*)model{
    if ([model.status isEqualToString:@"PENDING_PAYMENT"]) {
        [_stateImg setImage:[UIImage imageNamed:@"待支付"]];//待支付
        self.chatBtn.hidden=YES;
        self.detailLab.hidden=NO;
    }
    else if ([model.status isEqualToString:@"PENDING_APPROVAL"]){
        [_stateImg setImage:[UIImage imageNamed:@"待处理"]];//待审核
        self.chatBtn.hidden=YES;
        self.detailLab.hidden=NO;
    }
    else if ([model.status isEqualToString:@"PENDING_ACCEPT"]){
        [_stateImg setImage:[UIImage imageNamed:@"待接单"]];
        self.chatBtn.hidden=YES;
        self.detailLab.hidden=NO;
    }
    else if ([model.status isEqualToString:@"ACCEPTED"]){
        [_stateImg setImage:[UIImage imageNamed:@"已接单"]];
        self.chatBtn.hidden=NO;
        self.detailLab.hidden=YES;
    }
    else if([model.status isEqualToString:@"PROCESSING"]){
        [_stateImg setImage:[UIImage imageNamed:@"待处理"]];
        self.chatBtn.hidden=YES;
        self.detailLab.hidden=NO;
    }
    
    else if ([model.status isEqualToString:@"COMPLETE"]){
        [_stateImg setImage:[UIImage imageNamed:@"已完成"]];
        self.chatBtn.hidden=YES;
        self.detailLab.hidden=NO;
    }
    else if ([model.status isEqualToString:@"CLOSED"]){
        [_stateImg setImage:[UIImage imageNamed:@"已关闭"]];
        self.chatBtn.hidden=YES;
        self.detailLab.hidden=NO;
    }
    else if([model.status isEqualToString:@"CANCELLED"]){
        [_stateImg setImage:[UIImage imageNamed:@"已取消"]];
        self.chatBtn.hidden=YES;
        self.detailLab.hidden=NO;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark - Setting&&Getting

- (UILabel *)lawyerMoneyLab{
    if (!_lawyerMoneyLab) {
        _lawyerMoneyLab=[UILabel new];
        _lawyerMoneyLab.textColor = CFontColor_LawTitle;
        _lawyerMoneyLab.textAlignment = NSTextAlignmentRight;
        _lawyerMoneyLab.font = FontOfSize(11);
        _lawyerMoneyLab.text=@"¥39.90";
    }
    return _lawyerMoneyLab;
}

- (UIImageView *)noReadDotImg {
    if (!_noReadDotImg) {
        _noReadDotImg = [UIImageView new];
        _noReadDotImg.image = IMAGE_NAMED(@"提醒红点");
    }
    return _noReadDotImg;
}
- (UIImageView *)avatarImg {
    if (!_avatarImg) {
        _avatarImg = [UIImageView new];
        _avatarImg.image = IMAGE_NAMED(@"lawHead");
    }
    return _avatarImg;
}

- (UIImageView *)stateImg {
    if (!_stateImg) {
        _stateImg = [UIImageView new];
        _stateImg.image = IMAGE_NAMED(@"已接单");
    }
    return _stateImg;
}

- (UIButton *)chatBtn {
    if (!_chatBtn) {
        _chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chatBtn setBackgroundImage:IMAGE_NAMED(@"立即沟通底") forState:UIControlStateNormal];
        [_chatBtn setTitle:@"立即沟通" forState:UIControlStateNormal];
        _chatBtn.titleLabel.textColor = CFontColor_BtnTitle;
        _chatBtn.titleLabel.font = SFFont;
    }
    return _chatBtn;
}

-(UILabel *)moneyLab {
    if (!_moneyLab) {
        _moneyLab = [UILabel new];
        _moneyLab.text = @"¥39.90";
        _moneyLab.textColor = CFontColor_LawTitle;
        _moneyLab.textAlignment = NSTextAlignmentLeft;
        _moneyLab.font = FFont2;
    }
    return _moneyLab;
}

-(UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [UILabel new];
        _timeLab.text = @"2018-08-10 11:15";
        _timeLab.textColor = CFontColor2;
        _timeLab.textAlignment = NSTextAlignmentLeft;
        _timeLab.font = SFFont;
    }
    return _timeLab;
}

-(UILabel *)typeLab {
    if (!_typeLab) {
        _typeLab = [UILabel new];
        _typeLab.text = @"财务纠纷";
        _typeLab.textColor = CFontColor_LawTitle;
        _typeLab.textAlignment = NSTextAlignmentCenter;
        _typeLab.font = FontOfSize(11);
    }
    return _typeLab;
}

-(UILabel *)detailLab {
    if (!_detailLab) {
        _detailLab = [UILabel new];
        _detailLab.text = @"详细内容";
        _detailLab.textColor = CFontColor3;
        _detailLab.textAlignment = NSTextAlignmentRight;
        _detailLab.font = FFont1;
    }
    return _detailLab;
}





-(void)setupHeadImg:(NSString*)category{
    if ([category isEqualToString:@"财产纠纷"]) {
        [self.avatarImg setImage:[UIImage imageNamed:@"咨询图-财务纠纷"]];
    }
    else if ([category isEqualToString:@"婚姻家庭"]){
        [self.avatarImg setImage:[UIImage imageNamed:@"咨询图-婚姻家庭"]];
    }
    else if ([category isEqualToString:@"交通事故"]){
        [self.avatarImg setImage:[UIImage imageNamed:@"咨询图-交通事故"]];
    }
    else if ([category isEqualToString:@"工伤赔偿"]){
        [self.avatarImg setImage:[UIImage imageNamed:@"咨询图-工伤赔偿"]];
    }
    else if ([category isEqualToString:@"合同纠纷"]){
        [self.avatarImg setImage:[UIImage imageNamed:@"咨询图-合同纠纷"]];
    }
    else if ([category isEqualToString:@"刑事辩护"]){
        [self.avatarImg setImage:[UIImage imageNamed:@"咨询图-刑事辩护"]];
    }
    else if ([category isEqualToString:@"房产纠纷"]){
        [self.avatarImg setImage:[UIImage imageNamed:@"咨询图-房产纠纷"]];
    }
    else if ([category isEqualToString:@"劳动就业"]){
        [self.avatarImg setImage:[UIImage imageNamed:@"咨询图-劳动就业"]];
    }
    
}


@end
