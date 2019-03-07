//
//  HMAccontBalaceLogic.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/5.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMAccontBalaceLogic.h"

@implementation HMAccontBalaceLogic
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
//绑定支付宝
- (void)getBingLawyerAuthSignData:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    NSString*url=NSStringFormat(@"%@%@",ConsultationHostUrl,URL_Lawyer_aliPayAuthSign);
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode==201||responses.statusCode==200) {
            if (completedCallback) {
                completedCallback(responseObject);
            }
        }
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failedCallback(error);
        }
    }];
}
///<绑定支付宝
- (void)postBingLawyerAlipayData:(NSString *)authCode completed:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary *params = @{@"authCode":authCode};
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    NSString*url=NSStringFormat(@"%@%@",ConsultationHostUrl,URL_Lawyer_aliPayBind);
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        
        if (responses.statusCode==201||responses.statusCode==200||responses.statusCode == 204) {
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

///<解绑支付宝
- (void)postUnBingLawyerAlipayData:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    NSString*url=NSStringFormat(@"%@%@",ConsultationHostUrl,URL_Lawyer_aliPayUnBind);
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
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

@end
