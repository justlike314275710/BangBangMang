//
//  LawyerAuthenticationTableViewCell.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/2/26.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "LawyerAuthenticationTableViewCell.h"

@implementation LawyerAuthenticationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self renderContents];
    }
    return self;
}
-(void)renderContents{
    [self.contentView addSubview:self.SubmissionButton];
    [self.contentView addSubview:self.protocolLabel];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIButton *)SubmissionButton{
    if (!_SubmissionButton) {
         _SubmissionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_SubmissionButton setBackgroundColor:AppBaseTextColor3];
        [_SubmissionButton setTitle:@"同意协议并提交申请" forState:0];
        _SubmissionButton .titleLabel.font=[UIFont systemFontOfSize:14];
        _SubmissionButton.frame=CGRectMake(20, 50, SCREEN_WIDTH-40, 44);
    }
    return _SubmissionButton;
}

- (YYLabel *)protocolLabel{
    if (!_protocolLabel) {
        _protocolLabel=[YYLabel new];
        _protocolLabel.frame=CGRectMake((SCREEN_WIDTH-200)/2, 15, 200, 14);
        [self updateProtocolText];
    }
    return _protocolLabel;
}

- (void)updateProtocolText {
    NSString*read_agree=@"点击按钮即同意";
    NSString*usageProtocol=@"《法律咨询协议》";
    NSMutableAttributedString *protocolText = [NSMutableAttributedString new];
    UIFont *textFont = FontOfSize(12);
    [protocolText appendAttributedString:[[NSAttributedString alloc] initWithString:read_agree attributes:@{NSFontAttributeName:textFont,NSForegroundColorAttributeName:AppBaseTextColor2}]];
    [protocolText appendAttributedString:[[NSAttributedString  alloc] initWithString: usageProtocol attributes:@{NSFontAttributeName:textFont,NSForegroundColorAttributeName:AppBaseTextColor3}]];
    [protocolText appendAttributedString:[[NSAttributedString  alloc] initWithString:@" " attributes:@{NSFontAttributeName:textFont,NSForegroundColorAttributeName:AppBaseTextColor3}]];

    [protocolText appendAttributedString:[NSAttributedString attachmentStringWithContent:nil contentMode:UIViewContentModeCenter attachmentSize:CGSizeZero alignToFont:textFont alignment:YYTextVerticalAlignmentCenter]];
    protocolText.alignment = NSTextAlignmentLeft ;
    self.protocolLabel.attributedText = protocolText;
    self.protocolLabel.numberOfLines=0;
}

@end
