//
//  PSConsultationOtherTableViewCell.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/10/29.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSConsultationOtherTableViewCell.h"
#import "PSConsultationViewModel.h"
#import "ReactiveObjC.h"
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
        bgImageView.userInteractionEnabled=YES;
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
        consulationButton.titleLabel.font=FontOfSize(14);
        [bgImageView addSubview:consulationButton];
        
        
        
        _moneyTextField=[[UITextField alloc]initWithFrame:CGRectMake(15, consulationButton.bottom+15, SCREEN_WIDTH-60, 34)];
        _moneyTextField.borderStyle= UITextBorderStyleRoundedRect;
        _moneyTextField.layer.borderWidth=1.0f;
        _moneyTextField.layer.borderColor=AppBaseLineColor.CGColor;
        _moneyTextField.layer.cornerRadius=4.0f;
        _moneyTextField.keyboardType=UIKeyboardTypeDecimalPad;
        _moneyTextField.clearButtonMode=UITextFieldViewModeAlways;
        _moneyTextField.placeholder = @"请输入咨询金额,不少于100元";
        _moneyTextField.font = FontOfSize(12);
        [bgImageView addSubview:_moneyTextField];
        [_moneyTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            if (x.length==0) {
                for (int i=0; i<3; i++) {
                    UIButton *btn = (UIButton *)[self viewWithTag:i+100];
                    btn.selected=NO;
                }
            }
            else if ([x isEqualToString:@"100"]){
                UIButton *btn = (UIButton *)[self viewWithTag:100];
                btn.selected=YES;
            }
            else if ([x isEqualToString:@"200"]){
                UIButton *btn = (UIButton *)[self viewWithTag:101];
                btn.selected=YES;
            }
            else if ([x isEqualToString:@"300"]){
                UIButton *btn = (UIButton *)[self viewWithTag:102];
                btn.selected=YES;
            }
            else{
                for (int i=0; i<3; i++) {
                    UIButton *btn = (UIButton *)[self viewWithTag:i+100];
                    btn.selected=NO;
                }
            }
            
        }];
        
        
        
        CGFloat pading=15.0f;
        CGFloat tempW=(SCREEN_WIDTH-90)/3;
        int i = 0;
        NSArray *titleArray = @[@"100元",@"200元",@"300元"];
        for (NSString *title in titleArray) {
            UIButton *btn = [[UIButton alloc] init];
            btn.frame = CGRectMake(i*tempW+pading*(i+1), self.moneyTextField.bottom+15, tempW, 34);
            [btn setTitle:title forState:UIControlStateNormal];
            btn .titleLabel.font=FontOfSize(12);
            
            btn.tag = i+100;
            //btn.contentMode = UIViewContentModeCenter;
            [btn setTitleColor:AppBaseTextColor3 forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            btn.layer.masksToBounds=YES;
            btn.layer.cornerRadius=4.0f;
            [btn.layer setBorderWidth:1.0];
            [btn.layer setBorderColor:AppBaseTextColor3.CGColor];
            [btn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[self imageWithColor:AppBaseTextColor3] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [bgImageView addSubview:btn];
            i++;
        }
        
        
        
        UIButton*timeButton=[[UIButton alloc]initWithFrame:CGRectMake(sidePidding, self.moneyTextField.bottom+60, 100, 20)];
        [timeButton setImage:[UIImage imageNamed:@"咨询时长icon"]forState:0];
        [timeButton setTitle:@"咨询时长" forState:0 ];
        timeButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [timeButton setTitleColor:[UIColor blackColor] forState:0];
        timeButton.titleLabel.font=FontOfSize(14);
        [bgImageView addSubview:timeButton];
        
        UILabel*timeLable=[[UILabel alloc]initWithFrame: CGRectMake(SCREEN_WIDTH-3*sidePidding-50, timeButton.top, 50, 20)];
        timeLable.text=@"20分钟";
        //timeLable.textAlignment=NSTextAlignmentRight;
        timeLable.font=FontOfSize(14);
        timeLable.textColor=AppBaseTextColor3;
        [bgImageView addSubview:timeLable];
        
        CGFloat protocolSidePadding = RELATIVE_WIDTH_VALUE(30);
        self.protocolLabel = [YYLabel new];
        [bgImageView addSubview:self.protocolLabel];
        [self.protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(protocolSidePadding);
            make.right.mas_equalTo(bgImageView.mas_right).offset(-15);
            make.top.mas_equalTo(timeLable.mas_bottom).offset(15);
            make.height.mas_equalTo(30);
        }];
        
        
    }
    return self;
}

-(void)titleBtnClick:(UIButton *)btn
{
    if (btn!= self.selectedBtn) {
        self.selectedBtn.selected = NO;
        btn.selected = YES;
        self.selectedBtn = btn;
        self.moneyTextField.text=[btn.titleLabel.text substringToIndex:3];
    }else{
        self.selectedBtn.selected = YES;
        
    }
    if (self.buttonAction) {
        self.buttonAction(self.moneyTextField.text);
    }
}

- (void)handlerButtonAction:(ButtonClick)block
{
    self.buttonAction = block;
}



- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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
    UIImage *statusImage =ViewModel.agreeProtocol ? [UIImage imageNamed:@"已勾选"] : [UIImage imageNamed:@"未勾选"];
    
    
    [protocolText appendAttributedString:[NSAttributedString attachmentStringWithContent:statusImage contentMode:UIViewContentModeCenter attachmentSize:statusImage.size alignToFont:textFont alignment:YYTextVerticalAlignmentCenter]];
    protocolText.alignment = NSTextAlignmentLeft ;
    self.protocolLabel.attributedText = protocolText;
    self.protocolLabel.numberOfLines=0;
}


@end
