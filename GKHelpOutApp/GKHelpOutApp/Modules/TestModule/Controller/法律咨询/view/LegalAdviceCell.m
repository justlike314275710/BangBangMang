//
//  LegalAdviceCell.m
//  GKHelpOutApp
//
//  Created by kky on 2019/2/26.
//  Copyright © 2019年 kky. All rights reserved.
//

#define LegalCellSpaceX  20

#import "LegalAdviceCell.h"
@interface LegalAdviceCell()

@property (nonatomic,strong) UIImageView *noReadDotImg;   //未读
@property (nonatomic,strong) UIImageView *avatarImg;      //头像
@property (nonatomic,strong) UIImageView *stateImg;       //订单状态
@property (nonatomic,strong) UILabel *moneyLab;           //订单类型
@property (nonatomic,strong) UILabel *timeLab;            //订单类型
@property (nonatomic,strong) UILabel *typeLab;            //订单类型
@property (nonatomic,strong) UILabel *detailLab;          //订单类型
@property (nonatomic,strong) UIButton *chatBtn;           //立即沟通

@end
@implementation LegalAdviceCell

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
    
    [bgView addSubview:self.chatBtn];
    self.chatBtn.frame = CGRectMake(KScreenWidth-90,self.stateImg.bottom,66,24);
    
    [bgView addSubview:self.moneyLab];
    self.moneyLab.frame = CGRectMake(_avatarImg.right+15,_avatarImg.y,150, 20);
    
    [bgView addSubview:self.timeLab];
    self.timeLab.frame = CGRectMake(_avatarImg.right+15,_moneyLab.bottom,150, 20);
    
    [bgView addSubview:self.typeLab];
    self.typeLab.frame = CGRectMake(_avatarImg.right+15,_timeLab.bottom,60, 20);
    ViewBorderRadius(self.typeLab, 10, 1, CFontColor_LawTitle);
    
    [bgView addSubview:self.detailLab];
    self.detailLab.frame = CGRectMake(KScreenWidth-120,_typeLab.y,100,20);

    
}

- (void)setNoRead:(BOOL)noRead {
    //ui变化
    if (noRead) {
        self.noReadDotImg.hidden = NO;
        self.chatBtn.hidden = NO;
        self.detailLab.hidden = YES;
        self.noReadDotImg.x = LegalCellSpaceX;
    } else {
        self.noReadDotImg.hidden = YES;
        self.chatBtn.hidden = YES;
        self.detailLab.hidden = NO;
        self.avatarImg.x = LegalCellSpaceX;
    }
    self.timeLab.x = _avatarImg.right+15;
    self.moneyLab.x = _avatarImg.right+15;
    self.typeLab.x = _avatarImg.right+15;
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
        _typeLab.font = FFont1;
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




@end
