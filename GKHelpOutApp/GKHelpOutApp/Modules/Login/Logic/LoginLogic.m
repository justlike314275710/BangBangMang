//
//  LoginLogic.m
//  UniversalApp
//


#import "LoginLogic.h"
#import <AFNetworking.h>
#import "OauthInfo.h"

@interface LoginLogic ()

@property (nonatomic, strong) OauthInfo *oathInfo;


@end

@implementation LoginLogic


-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)getVerificationCodeData:(RequestDataCompleted)completed failed:(RequestDataFailed)failedCallback {
    
    NSString*url=[NSString stringWithFormat:@"%@%@",EmallHostUrl,URL_get_verification_code];
    NSDictionary*parameters=@{@"phoneNumber":self.phoneNumber};
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    [PPNetworkHelper POST:url parameters:parameters success:^(id responseObject) {
        
        if (completed) {
            completed(responseObject);
        }
    } failure:^(NSError *error) {
        if (failedCallback) {
            failedCallback(error);
        }
    }];
}

#pragma mark —————— Check Data
- (void)checkDataWithCallback:(CheckDataCallback)callback {
    
    if (self.phoneNumber.length == 0) {
        if (callback) {
            NSString*please_enter_phone_number = @"请输入手机号码";
            callback(NO,please_enter_phone_number);
        }
        return;
    }
    
    if (self.messageCode.length == 0) {
        if (callback) {
            NSString*please_enter_verify_code = @"请输入短信验证码";
            callback(NO,please_enter_verify_code);
        }
        return;
    }
    if (callback) {
        callback(YES,nil);
    }
    
}

- (void)checkDataWithPhoneCallback:(CheckDataCallback)callback {
    if (self.phoneNumber.length == 0) {
        if (callback) {
            NSString*please_enter_phone_number = @"请输入手机号码";
            callback(NO,please_enter_phone_number);
        }
        return;
    }
    if (callback) {
        callback(YES,nil);
    }
}





@end
