//
//  PSRemittancePayStateViewController.m
//  PrisonService
//
//  Created by kky on 2018/10/29.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSRemittancePayStateViewController.h"


@interface PSRemittancePayStateViewController ()
@property (nonatomic, strong) UIImageView *payStateImg;
@property (nonatomic, strong) UILabel *payStateLab;
@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UILabel *payWayLab; //支付方式
@property (nonatomic, strong) UILabel *namelab;


@end

@implementation PSRemittancePayStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self p_setUI];
}

- (void)p_setUI {
    
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *completeBtnText =@"完成";
    [completeBtn setTitle:completeBtnText forState:UIControlStateNormal];
    [completeBtn setTitleColor:UIColorFromRGB(38, 76, 144) forState:UIControlStateNormal];
    completeBtn.titleLabel.numberOfLines = 0;
    completeBtn.titleLabel.font = FontOfSize(14);
    [self.view addSubview:completeBtn];
    @weakify(self);
    [completeBtn bk_whenTapped:^{
        @strongify(self);
        if (self.state == payScuess) {
            if (self.completeBlock) {
                [self dismissViewControllerAnimated:NO completion:nil];
                self.completeBlock(payScuess);
            }
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    
    [self.view addSubview:self.payStateImg];
    [self.payStateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(71);
        make.height.mas_equalTo(63);
        make.top.mas_equalTo(72);
    }];
    
    [self.view addSubview:self.payStateLab];
    [self.payStateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.payStateImg.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    }];
    
    [self.view addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.payStateLab.mas_bottom).offset(25);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *k_payWayLab = [UILabel new];
    NSString *k_payWayLabText = @"付款方式";
    k_payWayLab.text = k_payWayLabText;
    k_payWayLab.textColor = UIColorFromRGB(102, 102, 102);
    k_payWayLab.font = FontOfSize(12);
    [self.view addSubview:k_payWayLab];
    [k_payWayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(self.amountLab.mas_bottom).offset(40);
    }];
    
    [self.view addSubview:self.payWayLab];
    [self.payWayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(k_payWayLab);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    if (self.payWay==payWayRemittance) {
    
        UILabel *k_nameLab = [UILabel new];
        NSString *k_nameLabText = @"汇款至服刑人员";
        k_nameLab.text = k_nameLabText;
        k_nameLab.textColor = UIColorFromRGB(102, 102, 102);
        k_nameLab.font = FontOfSize(12);
        [self.view addSubview:k_nameLab];
        [k_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(k_payWayLab.mas_bottom).offset(10);
        }];
        [self.view addSubview:self.namelab];
        [self.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(k_nameLab);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(20);
        }];
    }
   
}

#pragma mark - Setting&Getting
- (UIImageView *)payStateImg {
    if (!_payStateImg) {
        _payStateImg = [UIImageView new];
        _payStateImg.image = [UIImage imageNamed:@"payfail"];
        if (self.state == payScuess) {
            _payStateImg.image = [UIImage imageNamed:@"payscuess"];
        }
    }
    return _payStateImg;
}
- (UILabel *)payStateLab {
    if (!_payStateLab) {
        _payStateLab = [UILabel new];
        _payStateLab.font = FontOfSize(14);
        _payStateLab.textAlignment = NSTextAlignmentCenter;
        NSString *text = @"";
        if (self.state == payScuess) {
            text =  @"支付成功";
            _payStateLab.textColor = UIColorFromRGB(38,76,144);
        } else if(self.state == payFailure) {
            text = @"支付失败";
            _payStateLab.textColor = UIColorFromRGB(189, 8, 8);
        } else {
            text =  @"支付取消";
            _payStateLab.textColor = UIColorFromRGB(189, 8, 8);
        }
        _payStateLab.text = text;
    }
    return _payStateLab;
}

- (UILabel *)amountLab {
    if (!_amountLab) {
        _amountLab = [UILabel new];
        _amountLab.font = FontOfSize(30);
        _amountLab.textColor = [UIColor blackColor];
        _amountLab.text = [NSString stringWithFormat:@"¥%@",self.info.money];
        _amountLab.textAlignment = NSTextAlignmentCenter;
    }
    return _amountLab;
}

- (UILabel *)payWayLab {
    if (!_payWayLab) {
        _payWayLab = [UILabel new];
        _payWayLab.font = FontOfSize(12);
        _payWayLab.textColor = UIColorFromRGB(51,51,51);
        _payWayLab.textAlignment = NSTextAlignmentRight;
        NSString *text = @"";
        if ([self.info.payment isEqualToString:@"WEIXIN"]) {
            text =  @"微信";
        } else {
            text =  @"支付宝";
        }
        _payWayLab.text = text;
    }
    return _payWayLab;
}

- (UILabel *)namelab {
    if (!_namelab) {
        _namelab = [UILabel new];
        _namelab.font = FontOfSize(12);
        _namelab.textColor = UIColorFromRGB(51,51,51);
        _namelab.textAlignment = NSTextAlignmentRight;
        //_namelab.text = [NSString stringWithFormat:@"%@",self.prisoner.name];
    }
    return _namelab;
}






@end
