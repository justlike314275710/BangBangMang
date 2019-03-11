//
//  ModifyNewPhoneNumberViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/2/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "ModifyNewPhoneNumberViewController.h"
#import "LoginLogic.h"
#import "ReactiveObjC.h"
#import "ModifyDataViewController.h"
#import "RMTimer.h"

@interface ModifyNewPhoneNumberViewController ()

@property(nonatomic,strong)  UIScrollView *scrollview;
@property (nonatomic,strong) UILabel *phonelab;
@property (nonatomic,strong) UILabel *codelab;
@property (nonatomic,strong) UITextField *phoneField;
@property (nonatomic,strong) UITextField *codeField;
@property (nonatomic,strong) UIButton *nextStep;
@property (nonatomic,strong) UIButton *getCodeBtn;
@property (nonatomic,assign) NSInteger seconds;
@property (nonatomic,retain) LoginLogic *logic;//逻辑层

@end

@implementation ModifyNewPhoneNumberViewController

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
    
    UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(0,20, self.scrollview.width, 1)];
    line0.backgroundColor = CLineColor;
    [self.scrollview addSubview:line0];
    
    UIView *BgView = [UIView new];
    BgView.backgroundColor = KWhiteColor;
    BgView.frame=CGRectMake(0,line0.bottom,KScreenWidth,88);
    [self.scrollview addSubview:BgView];
    
    UILabel *k_phoneNumber = [[UILabel alloc] init];
    k_phoneNumber.frame = CGRectMake(15,11,50,22);
    k_phoneNumber.text = @"手机号:";
    k_phoneNumber.font = FFont1;
    k_phoneNumber.textColor = CFontColor1;
    [BgView addSubview:k_phoneNumber];
    [BgView addSubview:self.phoneField];
    self.phoneField.frame = CGRectMake(k_phoneNumber.right,k_phoneNumber.y, self.scrollview.width-k_phoneNumber.right-10-15, 21);
    UILabel *k_codeLabel = [[UILabel alloc] init];
    k_codeLabel.frame = CGRectMake(15,55,50,22);
    k_codeLabel.text = @"验证码:";
    k_codeLabel.font = FFont1;
    k_codeLabel.textColor = CFontColor1;
    [BgView addSubview:k_codeLabel];
    
    self.getCodeBtn.frame = CGRectMake(self.scrollview.width-125,k_codeLabel.y,100,21);
    [BgView addSubview:self.getCodeBtn];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0,44, self.scrollview.width, 1)];
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
       @strongify(self)
        [self getCode];
    }];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0,BgView.bottom, self.scrollview.width, 1)];
    line2.backgroundColor = CLineColor;
    [self.scrollview addSubview:line2];
    
    [self.scrollview addSubview:self.nextStep];
    _nextStep.frame = CGRectMake(15,160,self.scrollview.width-30,KNormalBBtnHeight);
    [_nextStep addTapBlock:^(UIButton *btn) {
        @strongify(self)
        [self changePhoneNumber];
    }];
    
}
-(void)changePhoneNumber{
    
    if (self.phoneField.text.length<11) {
        [PSTipsView showTips:@"请输入正确额手机号码！"];
        return;
    }
    if (self.codeField.text.length<4) {
        [PSTipsView showTips:@"请输入正确的验证码！"];
        return;
    }
    UserInfo *user = help_userManager.curUserInfo;
    NSLog(@"%@",user);
    [[PSLoadingView sharedInstance]show];
    NSString*url=[NSString stringWithFormat:@"%@%@",EmallHostUrl,URL_modify_PhoneNumber];
    NSDictionary*parmeters=@{
                             @"phoneNumber":self.phoneField.text,
                             @"verificationCode":self.codeField.text
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString*token=[NSString stringWithFormat:@"Bearer %@",help_userManager.oathInfo.access_token];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager PUT:url parameters:parmeters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode==204) {
            [PSTipsView showTips:@"修改号码成功"];
            help_userManager.curUserInfo.username = self.phoneField.text;
            [help_userManager saveUserInfo];
            [[PSLoadingView sharedInstance]dismiss];
            //发送通知
            KPostNotification(KNotificationModifyDataChange,nil);
            KPostNotification(KNotificationMineDataChange, nil);
            [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[ModifyDataViewController class]]) {
                    [self.navigationController popToViewController:obj animated:YES];
                    *stop = YES;
                }
            }];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[PSLoadingView sharedInstance]dismiss];
        NSLog(@"%@",error);
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (ValidData(data)) {
            id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString*code=body[@"code"];
            NSString*message=body[@"message"];
            [PSTipsView showTips:message];
        }
    }];
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
    RMTimer *sharedTimer = [RMTimer sharedTimer];
    @weakify(self);
    [sharedTimer resumeTimerWithDuration:self.seconds interval:1 handleBlock:^(NSInteger currentTime) {
        @strongify(self);
        self.getCodeBtn.enabled = NO;
        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"重发(%ld)",currentTime] forState:UIControlStateDisabled];
        [self.getCodeBtn setTitleColor:KGrayColor forState:UIControlStateDisabled];
        
    } timeOutBlock:^{
        @strongify(self);
        self.getCodeBtn.enabled = YES;
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
- (UITextField *)phoneField {
    if (!_phoneField) {
        _phoneField = [[UITextField alloc] init];
        _phoneField.placeholder = @"请输入新的手机号码";
        _phoneField.textAlignment = NSTextAlignmentLeft;
        _phoneField.textColor = CFontColor2;
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneField.font = FFont1;
    }
    return _phoneField;
}
- (UITextField *)codeField {
    if (!_codeField) {
        _codeField = [[UITextField alloc] init];
        _codeField.placeholder = @"请输入验证码";
        _codeField.textAlignment = NSTextAlignmentLeft;
        _codeField.keyboardType = UIKeyboardTypeNumberPad;
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
        [_nextStep setTitle:@"确认" forState:UIControlStateNormal];
        _nextStep.enabled = NO;
        [_nextStep setTitleColor:CFontColor_BtnTitle forState:UIControlStateNormal];
        [_nextStep setBackgroundImage:IMAGE_NAMED(@"n提交按钮底框") forState:UIControlStateNormal];
    }
    return _nextStep;
}
@end
