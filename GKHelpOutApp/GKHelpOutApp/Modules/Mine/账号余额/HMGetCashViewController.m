//
//  HMGetCashViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMGetCashViewController.h"
#import "HMGetCashResultViewController.h"

@interface HMGetCashViewController ()
@property(nonatomic,strong)UIScrollView *scrollvew;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)YYAnimatedImageView *headImgView;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UITextField *cashTextField;
@property(nonatomic,strong)UILabel *msgCodeLab;
@property(nonatomic,strong)UIButton*getCodeBtn;
@property(nonatomic,strong)UITextField *codeField;
@property(nonatomic,strong)UIButton *submitBtn;

@end

@implementation HMGetCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"提现";
    [self setupUI];
}

-(void)setupUI{
    CGFloat spacex = 15;
    [self.view addSubview:self.scrollvew];
    self.bgView.frame = CGRectMake(spacex,spacex,KScreenWidth-2*spacex,300);
    [self.scrollvew addSubview:_bgView];
    //头像
    self.headImgView.frame = CGRectMake((self.bgView.width-80)/2,20,80, 80);
    [self.bgView addSubview:_headImgView];
    //名字
    self.nameLab.frame =CGRectMake((self.bgView.width-200)/2,self.headImgView.bottom+8,200,20);
    [self.bgView addSubview:self.nameLab];
    
    UILabel*tqcashLab = [[UILabel alloc] initWithFrame:CGRectMake(20,161,100, 20)];
    tqcashLab.text = @"提取现金";
    tqcashLab.font = FFont1;
    tqcashLab.textColor=CFontColor1;
    [self.bgView addSubview:tqcashLab];
    
    self.cashTextField.frame=CGRectMake(tqcashLab.left,tqcashLab.bottom+10,self.bgView.width-38,40);
    [self.bgView addSubview:self.cashTextField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(tqcashLab.left,self.cashTextField.bottom+1, self.bgView.width-38, 1)];
    line.backgroundColor = CLineColor;
    [self.bgView addSubview:line];
    
    UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(tqcashLab.left, line.bottom+10,200,21)];
    msgLab.font = FFont1;
    msgLab.textColor = CFontColor1;
    msgLab.textAlignment = NSTextAlignmentLeft;
    msgLab.text=@"额外扣除25%平台佣金费";
    [self.bgView addSubview:msgLab];
    
    self.msgCodeLab.frame = CGRectMake(spacex,self.bgView.bottom+8,KScreenWidth-2*spacex,40);
    [self.scrollvew addSubview:self.msgCodeLab];
    
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(spacex,self.msgCodeLab.bottom+5,KScreenWidth-2*spacex,40)];
    centerView.backgroundColor = KWhiteColor;
    centerView.layer.cornerRadius = 4;
    [self.scrollvew addSubview:centerView];
    
    UILabel *k_codeLabel = [[UILabel alloc] init];
    k_codeLabel.frame = CGRectMake(20,10,50,20);
    k_codeLabel.text = @"验证码:";
    k_codeLabel.font = FFont1;
    k_codeLabel.textColor = CFontColor1;
    [centerView addSubview:k_codeLabel];
    
    self.getCodeBtn.frame = CGRectMake(centerView.width-120,10,100,20);
    [centerView addSubview:self.getCodeBtn];

    self.codeField.frame = CGRectMake(k_codeLabel.right+10,10,100,20);
    [centerView addSubview: self.codeField];
    
    UIView *v_line = [[UIView alloc] initWithFrame:CGRectMake(self.getCodeBtn.left-10,k_codeLabel.y+3, 1,15)];
    v_line.backgroundColor = CFontColor3;
    [centerView addSubview:v_line];
    
    UILabel *tipLab = [[UILabel alloc]initWithFrame:CGRectMake((KScreenWidth-150)/2,centerView.bottom+20,150,20)];
    tipLab.textAlignment=NSTextAlignmentCenter;
    tipLab.font = FFont1;
    tipLab.textColor=CFontColor2;
    tipLab.text=@"2小时内到账";
    [self.scrollvew addSubview:tipLab];
    
    self.submitBtn.frame =CGRectMake(spacex,KScreenHeight-74-kTopHeight,KScreenWidth-2*spacex,44);
    [self.scrollvew addSubview:self.submitBtn];
    
}
#pragma makr - TouchEvent
-(void)submitAction:(UIButton*)sender {
    HMGetCashResultViewController *GetCashResultVC = [[HMGetCashResultViewController alloc] init];
    [self.navigationController pushViewController:GetCashResultVC animated:YES];
}

#pragma mark -Setting&Getting
-(UIScrollView*)scrollvew{
    if (!_scrollvew) {
        _scrollvew=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    }
    return _scrollvew;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        _bgView.layer.cornerRadius = 4;
    }
    return _bgView;
}
-(YYAnimatedImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [YYAnimatedImageView new];
        _headImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headImgView.backgroundColor = [UIColor redColor];
        _headImgView.userInteractionEnabled = YES;
//        [_headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewClick)]];
        ViewRadius(_headImgView,40);
        [self.bgView addSubview:_headImgView];
        [_headImgView setImageWithURL:[NSURL URLWithString:help_userManager.curUserInfo.avatar] options:YYWebImageOptionRefreshImageCache];
    }
    return _headImgView;
}
-(UILabel*)nameLab{
    if (!_nameLab) {
        _nameLab=[UILabel new];
        _nameLab.text = help_userManager.curUserInfo.nickname;
        _nameLab.textColor = CFontColor1;
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = FFont1;
    }
    return _nameLab;
}
-(UITextField*)cashTextField{
    if (!_cashTextField) {
        _cashTextField=[UITextField new];
        _cashTextField.textColor = CFontColor1;
        _cashTextField.textAlignment = NSTextAlignmentLeft;
        _cashTextField.font = FFont1;
        _cashTextField.placeholder = @"请输入提现金额";
        _cashTextField.leftViewMode = UITextFieldViewModeAlways;
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20,40)];
        label.text=@"¥";
        _cashTextField.leftView = label;
    }
    return _cashTextField;
}
-(UILabel*)msgCodeLab{
    if (!_msgCodeLab) {
        _msgCodeLab=[UILabel new];
        _msgCodeLab.text = @"提现需要短信确认，验证码已发送至手机：138****6768，轻按提示操作。";
        _msgCodeLab.numberOfLines = 0;
        _msgCodeLab.textColor = CFontColor2;
        _msgCodeLab.textAlignment = NSTextAlignmentLeft;
        _msgCodeLab.font = FFont1;
    }
    return _msgCodeLab;
}
- (UIButton *)getCodeBtn {
    if (!_getCodeBtn) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:CFontColor3 forState:UIControlStateNormal];
        _getCodeBtn.titleLabel.font = FFont1;
    }
    return _getCodeBtn;
}
- (UITextField *)codeField {
    if (!_codeField) {
        _codeField = [[UITextField alloc] init];
        _codeField.placeholder = @"请输入验证码";
        _codeField.textAlignment = NSTextAlignmentLeft;
        _codeField.textColor = CFontColor2;
        _codeField.font = FFont1;
        _codeField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codeField;
}
-(UIButton*)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _submitBtn.titleLabel.font = SYSTEMFONT(16);
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_submitBtn setBackgroundImage:IMAGE_NAMED(@"提交按钮底框") forState:UIControlStateNormal];
        _submitBtn.backgroundColor = KWhiteColor;
        [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}







@end
