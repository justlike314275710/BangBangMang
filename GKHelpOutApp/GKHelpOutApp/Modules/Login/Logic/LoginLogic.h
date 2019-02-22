//
//  LoginLogic.h
//  UniversalApp
//


#import <Foundation/Foundation.h>


@interface LoginLogic : HpBaseLogic

@property (nonatomic,copy) NSString *phoneNumber;

@property (nonatomic,copy) NSString *messageCode; //验证码

@property (nonatomic,copy) Complete lgoinComplete; //登录


//判断电话号码
- (void)checkDataWithPhoneCallback:(CheckDataCallback)callback;

//获取验证码
- (void)getVerificationCodeData:(RequestDataCompleted)completed failed:(RequestDataFailed)failedCallback;

//获取认证授权token
- (void)getOauthTokenData:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

@end
