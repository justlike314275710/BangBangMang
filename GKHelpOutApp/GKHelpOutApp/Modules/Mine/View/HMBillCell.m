//
//  HMBillCell.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMBillCell.h"
#import "NSString+Utils.h"

@implementation HMBillCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self renderContents];
    }
    return self;
}

- (void)renderContents {
    CGFloat spacex = 15;
    [self addSubview:self.titleLab];
    self.titleLab.frame = CGRectMake(spacex,spacex, 200, 20);
    
    [self addSubview:self.moneylab];
    self.moneylab.frame = CGRectMake(KScreenWidth-120,spacex,100, 20);
    
    [self addSubview:self.dataLab];
    self.dataLab.frame = CGRectMake(spacex,self.titleLab.bottom+10,200,20);
    
    [self addSubview:self.payWayLab];
    self.payWayLab.frame = CGRectMake(spacex,self.dataLab.bottom+2,200,20);
    
    [self addSubview:self.orderLab];
    self.orderLab.frame = CGRectMake(spacex,self.payWayLab.bottom+2,300,20);
    
}

-(void)setModel:(HMBillModel *)model {
    _model = model;
    if ([model.type isEqualToString:@"SERVICE_CHARGE"]) {
        self.titleLab.text = @"提现平台使用费";
    } else if([model.type isEqualToString:@"PAYMENT"]) {
        self.titleLab.text = @"法律咨询费用";
    } else if([model.type isEqualToString:@"REFUND"]) {
        self.titleLab.text = @"法律咨询退费";
    } else if([model.type isEqualToString:@"WITHDRAW"]) {
        self.titleLab.text = @"账户提现";
    } else if([model.type isEqualToString:@"REWARD"]) {
        self.titleLab.text = @"赏金";
    }
    self.moneylab.text = model.amount;
    if ([model.amount doubleValue]>0) {
        [self.moneylab setTextColor:UIColorFromRGB(255,96,0)];
    } else {
        [self.moneylab setTextColor:UIColorFromRGB(51, 51, 51)];
    }
    
    self.dataLab.text = [NSString timeChange:model.successTime];
    if ([_model.source isEqualToString:@"ALIPAY"]) {
        self.payWayLab.text = @"支付方式:支付宝";
    } else {
        self.payWayLab.text = @"支付方式:微信";
    }
    self.orderLab.text = NSStringFormat(@"订单编号:%@",model.orderNumber);
    
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.text = @"心理咨询费用";
        _titleLab.textColor = CFontColor1;
        _titleLab.font = FFont2;
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}

-(UILabel *)moneylab{
    if (!_moneylab) {
        _moneylab = [UILabel new];
        _moneylab.text = @"-200";
        _moneylab.textColor = CFontColor1;
        _moneylab.font = FFont2;
        _moneylab.textAlignment = NSTextAlignmentRight;
    }
    return _moneylab;
}

-(UILabel *)dataLab{
    if (!_dataLab) {
        _dataLab = [UILabel new];
        _dataLab.text = @"2018-11-13 19:33";
        _dataLab.textColor = CFontColor2;
        _dataLab.font = FFont1;
        _dataLab.textAlignment = NSTextAlignmentLeft;
    }
    return _dataLab;
}
-(UILabel *)payWayLab{
    if (!_payWayLab) {
        _payWayLab = [UILabel new];
        _payWayLab.text = @"支付方式: 支付宝";
        _payWayLab.textColor = CFontColor2;
        _payWayLab.font = FFont1;
        _payWayLab.textAlignment = NSTextAlignmentLeft;
    }
    return _payWayLab;
}
-(UILabel *)orderLab{
    if (!_orderLab) {
        _orderLab = [UILabel new];
        _orderLab.text = @"订单编号：41231231231231312";
        _orderLab.textColor = CFontColor2;
        _orderLab.font = FFont1;
        _orderLab.textAlignment = NSTextAlignmentLeft;
    }
    return _orderLab;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
