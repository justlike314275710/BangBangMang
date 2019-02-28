//
//  ModifyoldPhoneNumberViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/2/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "ModifyoldPhoneNumberViewController.h"
#import "LoginLogic.h"

@interface ModifyoldPhoneNumberViewController ()
@property(nonatomic,strong) UIScrollView *scrollview;
@property (nonatomic,strong) UILabel *msglab;
@property (nonatomic,strong) UILabel *phonelab;
@property (nonatomic,strong) UILabel *codelab;
@property (nonatomic,strong) UITextField *phoneField;
@property (nonatomic,strong) UITextField *codeField;
@property (nonatomic,strong) UIButton *nextStep;
@property (nonatomic,strong) UIButton *getCodeBtn;
@property(nonatomic,assign)  NSInteger seconds;
@property (nonatomic, weak)  NSTimer *timer; //倒计时

@property(nonatomic,retain) LoginLogic *logic;//逻辑层


@end

@implementation ModifyoldPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更换手机号码";
    self.isShowLiftBack = YES;
    _logic = [LoginLogic new];
    [self setupUI];
}

#pragma mark --- PrivateMethod
-(void)setupUI {
    
    [self.view addSubview:self.scrollview];
    
    UILabel *k_phoneNumber = [[UILabel alloc] init];
    k_phoneNumber.frame = CGRectMake(44,81,50,21);
    k_phoneNumber.text = @"手机号:";
    k_phoneNumber.font = FFont1;
    k_phoneNumber.textColor = CFontColor1;
    [self.scrollview addSubview:k_phoneNumber];
    
    [self.scrollview addSubview:self.phoneField];
    self.phoneField.frame = CGRectMake(k_phoneNumber.right,k_phoneNumber.y, self.scrollview.width-k_phoneNumber.right-10-15, 21);
    
    
    UILabel *k_codeLabel = [[UILabel alloc] init];
    k_codeLabel.frame = CGRectMake(44,k_phoneNumber.bottom + 30,50,21);
    k_codeLabel.text = @"验证码:";
    k_codeLabel.font = FFont1;
    k_codeLabel.textColor = CFontColor1;
    [self.scrollview addSubview:k_codeLabel];
    
    self.getCodeBtn.frame = CGRectMake(self.scrollview.width-125,k_codeLabel.y,100,21);
    [self.scrollview addSubview:self.getCodeBtn];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(45,k_phoneNumber.bottom+5, self.scrollview.width-90, 1)];
    line1.backgroundColor = CLineColor;
    [self.scrollview addSubview:line1];
    
    self.codeField.frame = CGRectMake(k_codeLabel.right,k_codeLabel.y,self.scrollview.width-k_codeLabel.right-_getCodeBtn.width, 21);
    [self.scrollview addSubview: self.codeField];
    
    UIView *v_line = [[UIView alloc] initWithFrame:CGRectMake(self.codeField.right-10, k_codeLabel.y+3, 1,15)];
    v_line.backgroundColor = CFontColor3;
    [self.scrollview addSubview:v_line];
    
    @weakify(self)
    [_getCodeBtn addTapBlock:^(UIButton *btn) {
        [weak_self codeClicks];
    }];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(45,k_codeLabel.bottom+5, self.scrollview.width-90, 1)];
    line2.backgroundColor = CLineColor;
    [self.scrollview addSubview:line2];
    
    [self.scrollview addSubview:self.nextStep];
    _nextStep.frame = CGRectMake(45,186,self.scrollview.width-90,KNormalBBtnHeight);
    [_nextStep addTapBlock:^(UIButton *btn) {
//        [weak_self UserAccoutLogin];
    }];
    
}

//MARK:获取验证码
- (void)codeClicks {
    [self getCode];
}

//MARK:获取验证码
- (void)getCode {
    
    self.getCodeBtn.enabled = NO;
    _logic.phoneNumber = self.phonelab.text;
    [_logic checkDataWithPhoneCallback:^(BOOL successful, NSString *tips) {
        if (successful) {
            [self.logic getVerificationCodeData:^(id data) {
                [PSTipsView showTips:@"已发送"];
                self.seconds=60;
                [self startTimer];
                
            } failed:^(NSError *error) {
                NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                //                NSString*code=body[@"error"];
                NSString*message = body[@"message"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showWarnMessage:message];
                    self.getCodeBtn.enabled=YES;
                });
                
            }];
            
        } else {
            self.getCodeBtn.enabled = YES;
            [MBProgressHUD showWarnMessage:tips];
        }
    }];
}

//开启定时器
- (void)startTimer {
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

#pragma mark --- Setting&&Getting

- (UIScrollView *)scrollview {
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, KScreenWidth, KScreenHeight)];
        _scrollview.backgroundColor = CViewBgColor;
    }
    return _scrollview;
}

- (UITextField *)phoneField {
    if (!_phoneField) {
        _phoneField = [[UITextField alloc] init];
        _phoneField.placeholder = @"请输入旧的手机号码";
        _phoneField.textAlignment = NSTextAlignmentLeft;
        _phoneField.textColor = CFontColor2;
        _phoneField.font = FFont1;
    }
    return _phoneField;
}
- (UITextField *)codeField {
    if (!_codeField) {
        _codeField = [[UITextField alloc] init];
        _codeField.placeholder = @"请输入验证码";
        _codeField.textAlignment = NSTextAlignmentLeft;
        _codeField.textColor = CFontColor2;
        _codeField.font = FFont1;
        
    }
    return _codeField;
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

- (UIButton *)nextStep {
    
    if (!_nextStep) {
        _nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextStep setTitleColor:CFontColor_BtnTitle forState:UIControlStateNormal];
        [_nextStep setBackgroundImage:IMAGE_NAMED(@"loginbtnbgicon") forState:UIControlStateNormal];
    }
    return _nextStep;
}

@end
