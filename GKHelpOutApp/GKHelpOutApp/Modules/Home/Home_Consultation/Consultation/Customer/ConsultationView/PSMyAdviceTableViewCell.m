//
//  PSMyAdviceTableViewCell.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/1.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSMyAdviceTableViewCell.h"
//#import "PSSessionManager.h"
//#import "PSBusinessConstants.h"
#import "PSLawer.h"
#import "NSString+Utils.h"
@implementation PSMyAdviceTableViewCell

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
    _bgview = [[UIView alloc] init];
    _bgview.frame = CGRectMake(20,0,SCREEN_WIDTH-40,90);
    //bgview.layer.masksToBounds = YES;
    _bgview.backgroundColor = [UIColor whiteColor];
    _bgview.layer.shadowColor = [UIColor colorWithRed:14/255.0 green:39/255.0 blue:85/255.0 alpha:0.28].CGColor;
    _bgview.layer.shadowOffset = CGSizeMake(0,1);
    _bgview.layer.shadowOpacity = 1;
    _bgview.layer.shadowRadius = 3;
    _bgview.layer.cornerRadius = 5;
    [self addSubview:_bgview];
    
 
    _headImg = [UIImageView new];
    [_bgview addSubview:self.headImg];
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sidePidding);
        make.top.mas_equalTo(sidePidding);
        make.width.height.mas_equalTo(54);
    }];
    _headImg.layer.cornerRadius=27;
    _headImg.layer.masksToBounds=YES;
    
    
    _moneyButton=[UIButton new];
    [_bgview addSubview:_moneyButton];
    [_moneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImg.mas_right).offset(10);
        make.top.mas_equalTo(sidePidding);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
    }];
    _moneyButton.titleLabel.font=FontOfSize(14);
    [_moneyButton setTitleColor:UIColorFromRGB(255, 138, 7) forState:0];
    
    
    _timeLab=[UILabel new];
    [_bgview addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImg.mas_right).offset(10);
        make.top.mas_equalTo(_moneyButton.mas_bottom).offset(5);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(12);
    }];
    _timeLab.textColor=AppBaseTextColor1;
    _timeLab.font=FontOfSize(10);
    _timeLab.textAlignment=NSTextAlignmentLeft;
    
    
    
    _statusImg=[UIImageView new];
    [_bgview addSubview:_statusImg];
    [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.width.mas_equalTo(59);
        make.height.mas_equalTo(49);
    }];
  
    [_statusImg setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    _categoryButton=[UIButton new];
    [_bgview addSubview:_categoryButton];
    CGFloat btnW=57;
    [_categoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImg.mas_right).offset(10);
        make.top.mas_equalTo(self.timeLab.mas_bottom).offset(5);
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

  
}





-(void)setdetailButtonUI{
     _detailButton=[UIButton new];
    [_detailButton setTitle:@"详细内容" forState:0];
     _detailButton.titleLabel.font = FontOfSize(12);
    [_detailButton setTitleColor:AppBaseTextColor3 forState:0];
    [_bgview addSubview:_detailButton];
     _detailButton.frame=CGRectMake(SCREEN_WIDTH-128, 56, 68, 24);
}
-(void)fillWithModel:(PSConsultation*)model{
    _timeLab.text=[NSString timeChange:model.createdTime];
    [_moneyButton setTitle:[NSString stringWithFormat:@"¥%.2f",[model.reward floatValue]] forState:0];
    [ _categoryButton setTitle:model.category forState:UIControlStateNormal];
    if ([model.status isEqualToString:@"PENDING_PAYMENT"]) {
        [_statusImg setImage:[UIImage imageNamed:@"待支付"]];//待支付
        //[self setdetailButtonUI];
        [_bgview addSubview:self.detailButton];
    }
    else if ([model.status isEqualToString:@"PENDING_APPROVAL"]){
        [_statusImg setImage:[UIImage imageNamed:@"待处理"]];//待审核
         [_bgview addSubview:self.detailButton];
    }
    else if ([model.status isEqualToString:@"PENDING_ACCEPT"]){
        [_statusImg setImage:[UIImage imageNamed:@"待接单"]];
         [_bgview addSubview:self.detailButton];
      
    }
    else if ([model.status isEqualToString:@"ACCEPTED"]){
        [_statusImg setImage:[UIImage imageNamed:@"已接单"]];
        [_bgview addSubview: self.videoButton];

    }
    else if([model.status isEqualToString:@"PROCESSING"]){
        [_statusImg setImage:[UIImage imageNamed:@"待处理"]];
        [_bgview addSubview:self.detailButton];
    }

    else if ([model.status isEqualToString:@"COMPLETE"]){
       [_statusImg setImage:[UIImage imageNamed:@"已完成"]];
       [_bgview addSubview:self.detailButton];
    }
    else if ([model.status isEqualToString:@"CLOSED"]){
        [_statusImg setImage:[UIImage imageNamed:@"已关闭"]];
        [_bgview addSubview:self.detailButton];
    }
    else if([model.status isEqualToString:@"CANCELLED"]){
        [_statusImg setImage:[UIImage imageNamed:@"已取消"]]; //已完成
        [_bgview addSubview:self.detailButton];
    }
    else{

    }

    PSLawer*lawyer=[PSLawer mj_objectWithKeyValues:model.lawyer];
    if (lawyer.username) {
//        UIImage*image=[self stringToImage:lawyer.avatarThumb];
//        [self.headImg setImage:image];
        [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
         NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
        [SDWebImageManager.sharedManager.imageDownloader setValue:token forHTTPHeaderField:@"Authorization"];
       NSString*imageUrl=[NSString stringWithFormat:@"%@/users/%@/avatar",EmallHostUrl,lawyer.username];
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:imageUrl]];


    }
    else{
        [self setupHeadImg:model.category];
    }
}




-(void)setupHeadImg:(NSString*)category{
    if ([category isEqualToString:@"财产纠纷"]) {
        [self.headImg setImage:[UIImage imageNamed:@"咨询图-财务纠纷"]];
    }
    else if ([category isEqualToString:@"婚姻家庭"]){
        [self.headImg setImage:[UIImage imageNamed:@"咨询图-婚姻家庭"]];
    }
    else if ([category isEqualToString:@"交通事故"]){
        [self.headImg setImage:[UIImage imageNamed:@"咨询图-交通事故"]];
    }
    else if ([category isEqualToString:@"工伤赔偿"]){
        [self.headImg setImage:[UIImage imageNamed:@"咨询图-工伤赔偿"]];
    }
    else if ([category isEqualToString:@"合同纠纷"]){
        [self.headImg setImage:[UIImage imageNamed:@"咨询图-合同纠纷"]];
    }
    else if ([category isEqualToString:@"刑事辩护"]){
        [self.headImg setImage:[UIImage imageNamed:@"咨询图-刑事辩护"]];
    }
    else if ([category isEqualToString:@"房产纠纷"]){
        [self.headImg setImage:[UIImage imageNamed:@"咨询图-房产纠纷"]];
    }
    else if ([category isEqualToString:@"劳动就业"]){
        [self.headImg setImage:[UIImage imageNamed:@"咨询图-劳动就业"]];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -- SET
- (UIButton *)detailButton{
    if (!_detailButton) {
        _detailButton=[UIButton new];
        [_detailButton setTitle:@"详细内容" forState:0];
        _detailButton.titleLabel.font = FontOfSize(12);
        [_detailButton setTitleColor:AppBaseTextColor3 forState:0];
        // [_bgview addSubview:_detailButton];
        _detailButton.frame=CGRectMake(SCREEN_WIDTH-128, 56, 68, 24);
    }
    
    return _detailButton;
}

- (UIButton *)videoButton{
    if (!_videoButton) {
        [_videoButton setTitle:@"立即沟通" forState:0];
        [_videoButton setBackgroundColor:AppBaseTextColor3];
        [_videoButton setTitleColor:[UIColor whiteColor] forState:0];
        _videoButton.titleLabel.font = FontOfSize(10);
        _videoButton.layer.cornerRadius=2.0f;
       _videoButton.frame=CGRectMake(SCREEN_WIDTH-128, 56, 68, 24);
    }
    
    return _videoButton;
}

- (UIImage *)stringToImage:(NSString *)str {
    
    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *photo = [UIImage imageWithData:imageData ];
    
    return photo;
    
}
@end
