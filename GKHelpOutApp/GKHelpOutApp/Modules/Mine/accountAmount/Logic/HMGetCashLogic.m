//
//  HMGetCashLogic.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/8.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMGetCashLogic.h"

@implementation HMGetCashLogic
{
    AFHTTPSessionManager *manager;
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        manager=[AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

///<提现
- (void)postGetCashDatacompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    
    NSDictionary *params = @{@"amount":self.amount,@"verificationCode":self.verificationCode};
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    NSString*url=NSStringFormat(@"%@%@",ConsultationHostUrl,URL_Lawyer_aliPaywithdrawal);
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode==201||responses.statusCode==200||responses.statusCode==204) {
                if (completedCallback) {
                    completedCallback(responseObject);
                }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    failedCallback(error);
                }
    }];
}

- (void)checkDataWithCallback:(CheckDataCallback)callback {
    if (self.amount.length<=0) {
        if (callback){
            callback(NO,@"请输入提现金额");
        }
        return;
    }
    if ([self.amount floatValue]<1) {
        if (callback){
            callback(NO,@"提现金额不能少于1元");
        }
        return;
    }
    if ([self.amount floatValue]>[help_userManager.lawUserInfo.rewardAmount floatValue]) {
        if (callback){
            callback(NO,@"提现金额不能大于账户余额");
        }
        return;
    }
    if (self.verificationCode.length<=0) {
        if (callback){
            callback(NO,@"请输入验证码");
        }
        return;
    }
    if (callback) {
        callback(YES,nil);
    }
}



@end
