//
//  ModifyoldPhoneNumberViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/2/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "ModifyoldPhoneNumberViewController.h"
#import "ModifyNewPhoneNumberViewController.h"
#import "LoginLogic.h"
#import "ReactiveObjC.h"

@interface ModifyoldPhoneNumberViewController ()
@property(nonatomic,strong)  UIScrollView *scrollview;
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
-(void)setupUI{
    
    [self.view addSubview:self.scrollview];
    
    [self.scrollview addSubview:self.msglab];
    _msglab.frame = CGRectMake(16,16,KScreenWidth-32,45);
    _msglab.text = NSStringFormat(@"＊更换手机号，下次登录可使用新手机号登录。当前手机号:%@",help_userManager.curUserInfo.username);
    
    UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(0,_msglab.bottom+5, self.scrollview.width, 1)];
    line0.backgroundColor =  [UIColor clearColor]; //CLineColor;
    [self.scrollview addSubview:line0];
    
    UIView *BgView = [UIView new];
    BgView.backgroundColor = KWhiteColor;
    BgView.frame=CGRectMake(0,line0.bottom,KScreenWidth,44);
    [self.scrollview addSubview:BgView];
    /*
    UILabel *k_phoneNumber = [[UILabel alloc] init];
    k_phoneNumber.frame = CGRectMake(15,11,50,22);
    k_phoneNumber.text = @"手机号:";
    k_phoneNumber.font = FFont1;
    k_phoneNumber.textColor = CFontColor1;
    [BgView addSubview:k_phoneNumber];
    [BgView addSubview:self.phoneField];
    self.phoneField.frame = CGRectMake(k_phoneNumber.right,k_phoneNumber.y, self.scrollview.width-k_phoneNumber.right-10-15, 21);
    
    */
    UILabel *k_codeLabel = [[UILabel alloc] init];
    k_codeLabel.frame = CGRectMake(15,11/*55-44*/,50,22);
    k_codeLabel.text = @"验证码:";
    k_codeLabel.font = FFont1;
    k_codeLabel.textColor = CFontColor1;
    [BgView addSubview:k_codeLabel];
    
    self.getCodeBtn.frame = CGRectMake(self.scrollview.width-125,k_codeLabel.y,100,21);
    [BgView addSubview:self.getCodeBtn];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0,44-44, self.scrollview.width, 1)];
    line1.backgroundColor = CLineColor;
    [BgView addSubview:line1];
    
    self.codeField.frame = CGRectMake(k_codeLabel.right,k_codeLabel.y,self.scrollview.width-k_codeLabel.right-_getCodeBtn.width, 21);
    [BgView addSubview: self.codeField];
    
    [self.codeField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        if (x.length>0) {
            self.nextStep.enabled = YES;
            [self.nextStep setBackgroundImage:IMAGE_NAMED(@"提交按钮底框") forState:UIControlStateNormal];
        } else {
            self.nextStep.enabled = NO;
            [self.nextStep setBackgroundImage:IMAGE_NAMED(@"n提交按钮底框") forState:UIControlStateNormal];
        }
    }];
    
    UIView *v_line = [[UIView alloc] initWithFrame:CGRectMake(self.codeField.right-10, k_codeLabel.y+3, 1,15)];
    v_line.backgroundColor = CFontColor3;
    [BgView addSubview:v_line];
    
    @weakify(self)
    [_getCodeBtn addTapBlock:^(UIButton *btn) {
        @strongify(self);
        [self codeClicks];
    }];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0,BgView.bottom, self.scrollview.width, 1)];
    line2.backgroundColor = CLineColor;
    [self.scrollview addSubview:line2];
    
    [self.scrollview addSubview:self.nextStep];
    _nextStep.frame = CGRectMake(15,186,self.scrollview.width-30,KNormalBBtnHeight);
    [_nextStep addTapBlock:^(UIButton *btn) {
//        ModifyNewPhoneNumberViewController *ModfiyNewVC = [[ModifyNewPhoneNumberViewController alloc] init];
        [self_weak_ UserAccoutLogin];
    }];
    
}

-(void)UserAccoutLogin {
//    self.logic.phoneNumber = self.phoneField.text;
    self.logic.messageCode = self.codeField.text;
    [_logic checkDataWithCallback:^(BOOL successful, NSString *tips) {
        if (successful) {
            NSDictionary *params = @{@"username":help_userManager.curUserInfo.username
                                     @"password":self.codeField.text,
                                     @"grant_type":@"password"
                                     };
            
            [self requestData:params];
        } else {
            [MBProgressHUD showWarnMessage:tips];
        }
    }];
}
//MARK:判断手机号是否正确
- (void)requestData:(NSDictionary*)params {
    
    NSString*uid=@"consumer.m.app";
    NSString*cipherText=@"1688c4f69fc6404285aadbc996f5e429";
    NSString *part1 = [NSString stringWithFormat:@"%@:%@",uid,cipherText];
    NSData   *data = [part1 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *stringBase64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString * authorization = [NSString stringWithFormat:@"Basic %@",stringBase64];
    NSString*url=[NSString stringWithFormat:@"%@%@",EmallHostUrl,URL_get_oauth_token];
    NSMutableURLRequest *formRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:params error:nil];
    [formRequest setValue:@"application/x-www-form-urlencoded; charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    [formRequest setValue:authorization forHTTPHeaderField:@"Authorization"];
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer* responseSerializer = [AFJSONResponseSerializer serializer];
    [responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil]];
    manager.responseSerializer= responseSerializer;
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:formRequest uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        if (error) {
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (data) {
                id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString*code=body[@"error"];
                NSString*error_description = body[@"error_description"];
        
            }
        }
        else {
            
            if (responseStatusCode == 200) {
                ModifyNewPhoneNumberViewController *ModfiyNewVC = [[ModifyNewPhoneNumberViewController alloc] init];
                [self.navigationController pushViewController:ModfiyNewVC animated:YES];
            }
        }
    }];
    
    [dataTask resume];
}

//MARK:获取验证码
- (void)codeClicks {
    [self getCode];
}

//MARK:获取验证码
- (void)getCode {
    self.getCodeBtn.enabled = NO;
    _logic.phoneNumber = self.phoneField.text;
    [_logic checkDataWithPhoneCallback:^(BOOL successful, NSString *tips) {
        if (successful) {
            [self.logic getVerificationCodeData:^(id data) {
                [PSTipsView showTips:@"已发送"];
                self.seconds=60;
                [self startTimer];
                
            } failed:^(NSError *error) {
                NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                if (data) {
                    id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSString*message = body[@"message"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD showWarnMessage:message];
                        self.getCodeBtn.enabled=YES;
                    });
                }
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
-(void)handleTimer {
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
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneField.text = help_userManager.curUserInfo.username;
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
        _codeField.keyboardType = UIKeyboardTypeNumberPad;
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
        _nextStep.enabled = NO;
        [_nextStep setTitleColor:CFontColor_BtnTitle forState:UIControlStateNormal];
        [_nextStep setBackgroundImage:IMAGE_NAMED(@"n提交按钮底框") forState:UIControlStateNormal];
    }
    return _nextStep;
}
-(UILabel *)msglab {
    if (!_msglab) {
        _msglab = [UILabel new];
        _msglab.textAlignment = NSTextAlignmentLeft;
        _msglab.textColor = CFontColor2;
        _msglab.font = FFont1;
        _msglab.numberOfLines = 2;
    }
    return _msglab;
}

@end
