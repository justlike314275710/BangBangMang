//
//  LoginViewController.m
//  MiAiApp
//

//

#import "LoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "LoginLogic.h"

@interface LoginViewController ()

@property(nonatomic,strong) LoginLogic *logic;//逻辑层
@property(nonatomic,strong) UIScrollView *scrollview;
@property(nonatomic,strong) UITextField *phoneNumberField;
@property(nonatomic,strong) UITextField *codeField;
@property(nonatomic,strong) UIButton *getCodeBtn;
@property(nonatomic,strong) UIButton *loginBtn;
@property(nonatomic,assign) NSInteger seconds;

@property (nonatomic, weak) NSTimer *timer; //倒计时


@end

@implementation LoginViewController

#pragma mark --- LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHidenNaviBar = YES;
    _logic = [LoginLogic new];
    @weakify(self)
    _logic.lgoinComplete = ^{
        [weak_self UserAccoutLogin];
    };
    
    [self setupUI];
    
    /*
    YYLabel *snowBtn = [[YYLabel alloc] initWithFrame:CGRectMake(0, 200, 150, 60)];
    snowBtn.text = @"微信登录";
    snowBtn.font = SYSTEMFONT(20);
    snowBtn.textColor = KWhiteColor;
    snowBtn.backgroundColor = CNavBgColor;
    snowBtn.textAlignment = NSTextAlignmentCenter;
    snowBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    snowBtn.centerX = KScreenWidth/2;
    
    kWeakSelf(self);
    snowBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        //        [MBProgressHUD showTopTipMessage:NSStringFormat(@"%@马上开始",str) isWindow:YES];
        
        [weakself WXLogin];
    };
    
    [self.view addSubview:snowBtn];
    
    YYLabel *snowBtn2 = [[YYLabel alloc] initWithFrame:CGRectMake(0, 300, 150, 60)];
    snowBtn2.text = @"QQ登录";
    snowBtn2.font = SYSTEMFONT(20);
    snowBtn2.textColor = KWhiteColor;
    snowBtn2.backgroundColor = KRedColor;
    snowBtn2.textAlignment = NSTextAlignmentCenter;
    snowBtn2.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    snowBtn2.centerX = KScreenWidth/2;
    
    snowBtn2.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        //        [MBProgressHUD showTopTipMessage:NSStringFormat(@"%@马上开始",str) isWindow:YES];
        
        [weakself QQLogin];
    };
    
    [self.view addSubview:snowBtn2];
    
    YYLabel *skipBtn = [[YYLabel alloc] initWithFrame:CGRectMake(0, 400, 150, 60)];
    skipBtn.text = @"跳过登录";
    skipBtn.font = SYSTEMFONT(20);
    skipBtn.textColor = KBlueColor;
    skipBtn.backgroundColor = KClearColor;
    skipBtn.textAlignment = NSTextAlignmentCenter;
    skipBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    skipBtn.centerX = KScreenWidth/2;
    
    skipBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        //        [MBProgressHUD showTopTipMessage:NSStringFormat(@"%@马上开始",str) isWindow:YES];
        
        [weakself LoginAction];
        
    };
    
    [self.view addSubview:skipBtn];
    
    
    YYLabel *getCodeBtn = [[YYLabel alloc] initWithFrame:CGRectMake(0,500, 150, 60)];
    getCodeBtn.text = @"获取验证码";
    getCodeBtn.font = SYSTEMFONT(20);
    getCodeBtn.textColor = KBlueColor;
    getCodeBtn.backgroundColor = KClearColor;
    getCodeBtn.textAlignment = NSTextAlignmentCenter;
    getCodeBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    getCodeBtn.centerX = KScreenWidth/2;
    
    getCodeBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        //        [MBProgressHUD showTopTipMessage:NSStringFormat(@"%@马上开始",str) isWindow:YES];
        
        [weakself getCode];
    };
    
    [self.view addSubview:getCodeBtn];
     
     */

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --- PrivateMethod
-(void)setupUI {
    
    [self.view addSubview:self.scrollview];
    
    UIImageView *headImg = [UIImageView new];
    headImg.frame = CGRectMake(0,0,KScreenWidth,200);
    headImg.backgroundColor = [UIColor redColor];
    headImg.image = IMAGE_NAMED(@"me");
    [self.scrollview addSubview:headImg];
    
    UILabel *k_phoneNumber = [[UILabel alloc] init];
    k_phoneNumber.frame = CGRectMake(20,headImg.bottom+20,70,21);
    k_phoneNumber.text = @"手机号:";
    [self.scrollview addSubview:k_phoneNumber];
    
    [self.scrollview addSubview:self.phoneNumberField];
    self.phoneNumberField.frame = CGRectMake(k_phoneNumber.right+10, headImg.bottom+20, KScreenWidth-k_phoneNumber.right-10-15, 21);
    self.phoneNumberField.backgroundColor = [UIColor grayColor];
    
    
    UILabel *k_codeLabel = [[UILabel alloc] init];
    k_codeLabel.frame = CGRectMake(20,k_phoneNumber.bottom + 20,70,21);
    k_codeLabel.text = @"验证码:";
    [self.scrollview addSubview:k_codeLabel];
    
    self.getCodeBtn.frame = CGRectMake(KScreenWidth-135,k_codeLabel.y,120,21);
    [self.scrollview addSubview:self.getCodeBtn];
    
    self.codeField.frame = CGRectMake(k_codeLabel.right+10,k_codeLabel.y,KScreenWidth-k_codeLabel.right-_getCodeBtn.width-30, 21);
    self.codeField.backgroundColor = [UIColor grayColor];
    [self.scrollview addSubview:self.codeField];
    @weakify(self)
    [_getCodeBtn addTapBlock:^(UIButton *btn) {
        [weak_self codeClicks];
    }];

    [self.scrollview addSubview:self.loginBtn];
    _loginBtn.frame = CGRectMake(15,self.getCodeBtn.bottom+25,KScreenWidth-30,45);
    [_loginBtn addTapBlock:^(UIButton *btn) {
        [weak_self UserAccoutLogin];
    }];
 
}

//开启定时器
- (void)startTimer {
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)handleTimer {
    
    if (_seconds > 0) {
        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"重发(%ld)",(long)_seconds] forState:UIControlStateDisabled];
        _seconds --;
        if (self.seconds==0)
        {
            self.getCodeBtn.enabled = YES;
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}

//MARK:获取验证码
- (void)codeClicks {
    [self getCode];
}

-(void)WXLogin{
    
    [help_userManager login:kUserLoginTypeWeChat completion:^(BOOL success, NSString *des) {
        if (success) {
            DLog(@"登录成功");
        }else{
            DLog(@"登录失败：%@", des);
        }
    }];
}
-(void)QQLogin{
    
    [help_userManager login:kUserLoginTypeQQ completion:^(BOOL success, NSString *des) {
        if (success) {
            DLog(@"登录成功");
        }else{
            DLog(@"登录失败：%@", des);
        }
    }];
}
//用户账号登录
-(void)UserAccoutLogin {
    
    self.logic.phoneNumber = self.phoneNumberField.text;
    self.logic.messageCode = self.codeField.text;
    [_logic checkDataWithCallback:^(BOOL successful, NSString *tips) {
        if (successful) {
            NSDictionary *params = @{@"username":self.phoneNumberField.text,
                                     @"password":self.codeField.text,
                                     @"grant_type":@"password"
                                     };
            [help_userManager loginToServer:params completion:^(BOOL success, NSString *des) {
                
            }];
        } else {
            [MBProgressHUD showWarnMessage:tips];
        }
    }];
}

//获取Ouath
-(void)LoginAction{
    
    [_logic getOauthTokenData:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
//MARK:获取验证码
- (void)getCode {
    
    self.getCodeBtn.enabled = NO;
    _logic.phoneNumber = self.phoneNumberField.text;
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

#pragma mark --- Setting&&Getting
- (UIScrollView *)scrollview {
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,20, KScreenWidth, KScreenHeight)];
        _scrollview.backgroundColor = CViewBgColor;
    }
    return _scrollview;
}

- (UITextField *)phoneNumberField {
    if (!_phoneNumberField) {
        _phoneNumberField = [[UITextField alloc] init];
        _phoneNumberField.placeholder = @"请输入手机号码";
        _phoneNumberField.textAlignment = NSTextAlignmentLeft;
    }
    return _phoneNumberField;
}
- (UITextField *)codeField {
    if (!_codeField) {
        _codeField = [[UITextField alloc] init];
        _codeField.placeholder = @"请输入验证码";
        _codeField.textAlignment = NSTextAlignmentLeft;
    }
    return _codeField;
}

- (UIButton *)getCodeBtn {
    if (!_getCodeBtn) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _getCodeBtn.backgroundColor = [UIColor whiteColor];
    }
    return _getCodeBtn;
}

- (UIButton *)loginBtn {
    
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [UIColor whiteColor];
    }
    return _loginBtn;
}





@end
