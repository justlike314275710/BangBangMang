//
//  PSConsultationOtherTableViewCell.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/10/29.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSConsultationOtherTableViewCell.h"
#import "PSConsultationViewModel.h"
@implementation PSConsultationOtherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.image = [[UIImage imageNamed:@"serviceHallServiceBg"] stretchImage];
        [self addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(0);
        }];
        CGFloat sidePidding=15.0f;
        UIButton*consulationButton=[[UIButton alloc]initWithFrame:CGRectMake(sidePidding, sidePidding, 100, 20)];
        [consulationButton setImage:[UIImage imageNamed:@"咨询费用"]forState:0];
        [consulationButton setTitle:@"咨询费用" forState:0 ];
        consulationButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [consulationButton setTitleColor:[UIColor blackColor] forState:0];
        consulationButton.titleLabel.font=FontOfSize(12);
        [bgImageView addSubview:consulationButton];
        
        UILabel*consulationLable=[[UILabel alloc]initWithFrame:CGRectMake(47, consulationButton.bottom+10, SCREEN_WIDTH-100, 12)];
        consulationLable.textColor=AppBaseTextColor1;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"咨询费用越多，回复效率与质量越高!"];
        NSRange range1=[[str  string]rangeOfString:@"效率"];
        [str  addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(255, 138, 7, 1) range:range1];
        NSRange range2=[[str string]rangeOfString:@"质量"];
        [str  addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(255, 138, 7, 1) range:range2];
        //[str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(255, 138, 7, 1) range:NSMakeRange(10,5)];
        consulationLable.attributedText = str;
        consulationLable.font=FontOfSize(10);
        [bgImageView addSubview:consulationLable];
        bgImageView.userInteractionEnabled=YES;
        
        UILabel*moneyLable=[[UILabel alloc]initWithFrame:CGRectMake(sidePidding, 90, 60, 20)];
        moneyLable.font=FontOfSize(12);
        moneyLable.text=@"输入金额:";
        [bgImageView addSubview:moneyLable];
        
        _moneyTextField=[[UITextField alloc]initWithFrame:CGRectMake(76, 86, SCREEN_WIDTH-164, 32)];
        _moneyTextField.borderStyle= UITextBorderStyleRoundedRect;
        _moneyTextField.layer.borderWidth=1.0f;
        _moneyTextField.layer.borderColor=AppBaseLineColor.CGColor;
        _moneyTextField.layer.cornerRadius=4.0f;
        _moneyTextField.keyboardType=UIKeyboardTypeDecimalPad;
        _moneyTextField.placeholder = @"最低金额不低于20元";
        _moneyTextField.font = FontOfSize(12);
        //        NSString *holderText = @"最低金额不低于20元";
        //        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
        //        [placeholder addAttribute:NSFontAttributeName
        //                            value:[UIFont boldSystemFontOfSize:12]
        //                            range:NSMakeRange(0, holderText.length)];
        //        _moneyTextField.attributedPlaceholder = placeholder;
        [bgImageView addSubview:_moneyTextField];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_moneyTextField.right+3, _moneyTextField.y,40, 30)];
        label.text = @"20分钟";
        label.textAlignment = NSTextAlignmentLeft;
        [label setTextColor:UIColorFromRGB(38, 76, 144)];
        label.font = FontOfSize(12);
        [bgImageView addSubview:label];
        
        
        CGFloat protocolSidePadding = RELATIVE_WIDTH_VALUE(30);
        self.protocolLabel = [YYLabel new];
        [bgImageView addSubview:self.protocolLabel];
        [self.protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(protocolSidePadding);
            make.right.mas_equalTo(bgImageView.mas_right).offset(-15);
            make.top.mas_equalTo(_moneyTextField.mas_bottom).offset(5);
            make.height.mas_equalTo(30);
        }];
        //        UILabel*tipsLable=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-140, 125, 100, 12)];
        //        tipsLable.textColor=AppBaseTextColor1;
        //        NSMutableAttributedString *tipsStr = [[NSMutableAttributedString alloc] initWithString:@"最低金额不低于20元"];
        //        NSRange range3=[[tipsStr  string]rangeOfString:@"20元"];
        //        [tipsStr  addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(255, 138, 7, 1) range:range3];
        //        tipsLable.attributedText = tipsStr;
        //        tipsLable.font=FontOfSize(10);
        //        [bgImageView addSubview:tipsLable];
        
    }
    return self;
}
- (void)updateProtocolText {
    NSString*read_agree=NSLocalizedString(@"read_agree", nil);
    NSString*usageProtocol=NSLocalizedString(@"usageProtocol", nil);
    NSMutableAttributedString *protocolText = [NSMutableAttributedString new];
    UIFont *textFont = FontOfSize(12);
    [protocolText appendAttributedString:[[NSAttributedString alloc] initWithString:read_agree attributes:@{NSFontAttributeName:textFont,NSForegroundColorAttributeName:AppBaseTextColor2}]];
    [protocolText appendAttributedString:[[NSAttributedString  alloc] initWithString: usageProtocol attributes:@{NSFontAttributeName:textFont,NSForegroundColorAttributeName:AppBaseTextColor3}]];
    [protocolText appendAttributedString:[[NSAttributedString  alloc] initWithString:@" " attributes:@{NSFontAttributeName:textFont,NSForegroundColorAttributeName:AppBaseTextColor3}]];
    PSConsultationViewModel*ViewModel =[[PSConsultationViewModel alloc]init];
    UIImage *statusImage =ViewModel.agreeProtocol ? [UIImage imageNamed:@"sessionProtocolSelected"] : [UIImage imageNamed:@"sessionProtocolNormal"];
    [protocolText appendAttributedString:[NSAttributedString attachmentStringWithContent:statusImage contentMode:UIViewContentModeCenter attachmentSize:statusImage.size alignToFont:textFont alignment:YYTextVerticalAlignmentCenter]];
    protocolText.alignment = NSTextAlignmentLeft ;
    self.protocolLabel.attributedText = protocolText;
    self.protocolLabel.numberOfLines=0;
}


@end
