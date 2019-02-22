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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --- PrivateMethod
-(void)setupUI {
    
    [self.view addSubview:self.scrollview];
    UIImageView *headImg = [UIImageView new];
    headImg.frame = CGRectMake(0,0,KScreenWidth,KScreenHeight);
    headImg.image = IMAGE_NAMED(@"loginbgIcon");
    headImg.userInteractionEnabled = YES;
    [self.scrollview addSubview:headImg];
    
    UIImageView *mideleBgImg = [UIImageView new];
    mideleBgImg.userInteractionEnabled = YES;
    mideleBgImg.frame = CGRectMake(KNormalSpaceX,(KScreenHeight-260)/2-20,KScreenWidth-2*KNormalSpaceX,260);
    mideleBgImg.image = IMAGE_NAMED(@"loginmidbgicon");
    [self.scrollview addSubview:mideleBgImg];
    
    UIImageView *circleImg = [UIImageView new];
    circleImg.frame = CGRectMake((KScreenWidth-100)/2, mideleBgImg.y-50,100,100);
    circleImg.image = [UIImage imageNamed:@"loginciricom"];
    [self.scrollview addSubview:circleImg];
    
    UIImageView *logoImg = [UIImageView new];
    logoImg.frame = CGRectMake(30,27,40,46);
    logoImg.image = [UIImage imageNamed:@"logo"];
    [circleImg addSubview:logoImg];
    

    UILabel *k_phoneNumber = [[UILabel alloc] init];
    k_phoneNumber.frame = CGRectMake(44,81,50,21);
    k_phoneNumber.text = @"手机号:";
    k_phoneNumber.font = FFont1;
    k_phoneNumber.textColor = CFontColor1;
    [mideleBgImg addSubview:k_phoneNumber];
    
    [mideleBgImg addSubview:self.phoneNumberField];
    self.phoneNumberField.frame = CGRectMake(k_phoneNumber.right,k_phoneNumber.y, mideleBgImg.width-k_phoneNumber.right-10-15, 21);

    
    
    UILabel *k_codeLabel = [[UILabel alloc] init];
    k_codeLabel.frame = CGRectMake(44,k_phoneNumber.bottom + 30,50,21);
    k_codeLabel.text = @"验证码:";
    k_codeLabel.font = FFont1;
    k_codeLabel.textColor = CFontColor1;
    [mideleBgImg addSubview:k_codeLabel];
    
    self.getCodeBtn.frame = CGRectMake(mideleBgImg.width-125,k_codeLabel.y,100,21);
    [mideleBgImg addSubview:self.getCodeBtn];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(45,k_phoneNumber.bottom+5, mideleBgImg.width-90, 1)];
    line1.backgroundColor = CLineColor;
    [mideleBgImg addSubview:line1];
    
    self.codeField.frame = CGRectMake(k_codeLabel.right,k_codeLabel.y,mideleBgImg.width-k_codeLabel.right-_getCodeBtn.width, 21);
    [mideleBgImg addSubview: self.codeField];
    
    UIView *v_line = [[UIView alloc] initWithFrame:CGRectMake(self.codeField.right-10, k_codeLabel.y+3, 1,15)];
    v_line.backgroundColor = CFontColor3;
    [mideleBgImg addSubview:v_line];
    
    @weakify(self)
    [_getCodeBtn addTapBlock:^(UIButton *btn) {
        [weak_self codeClicks];
    }];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(45,k_codeLabel.bottom+5, mideleBgImg.width-90, 1)];
    line2.backgroundColor = CLineColor;
    [mideleBgImg addSubview:line2];

    [mideleBgImg addSubview:self.loginBtn];
    _loginBtn.frame = CGRectMake(45,186,mideleBgImg.width-90,KNormalBBtnHeight);
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
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, KScreenWidth, KScreenHeight)];
        _scrollview.backgroundColor = CViewBgColor;
    }
    return _scrollview;
}

- (UITextField *)phoneNumberField {
    if (!_phoneNumberField) {
        _phoneNumberField = [[UITextField alloc] init];
        _phoneNumberField.placeholder = @"请输入手机号码";
        _phoneNumberField.textAlignment = NSTextAlignmentLeft;
        _phoneNumberField.textColor = CFontColor2;
        _phoneNumberField.font = FFont1;
    }
    return _phoneNumberField;
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

- (UIButton *)loginBtn {
    
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:CFontColor_BtnTitle forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:IMAGE_NAMED(@"loginbtnbgicon") forState:UIControlStateNormal];

    }
    return _loginBtn;
}





@end
