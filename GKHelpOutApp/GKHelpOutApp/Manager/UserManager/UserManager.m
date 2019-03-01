//
//  UserManager.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/22.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "UserManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import <AFNetworking.h>

@implementation UserManager

SINGLETON_FOR_CLASS(UserManager);

-(instancetype)init{
    self = [super init];
    if (self) {
        //被踢下线
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKick)
                                                     name:KNotificationOnKick
                                                   object:nil];
    }
    return self;
}

#pragma mark ————— 三方登录 —————
-(void)login:(UserLoginType )loginType completion:(loginBlock)completion{
    [self login:loginType params:nil completion:completion];
}

#pragma mark ————— 带参数登录 —————
-(void)login:(UserLoginType )loginType params:(NSDictionary *)params completion:(loginBlock)completion{
    //友盟登录类型
    UMSocialPlatformType platFormType;
    
    if (loginType == kUserLoginTypeQQ) {
        platFormType = UMSocialPlatformType_QQ;
    }else if (loginType == kUserLoginTypeWeChat){
        platFormType = UMSocialPlatformType_WechatSession;
    }else{
        platFormType = UMSocialPlatformType_UnKnown;
    }
    //第三方登录
    if (loginType != kUserLoginTypePwd) {
        [MBProgressHUD showActivityMessageInView:@"授权中..."];
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platFormType currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                [MBProgressHUD hideHUD];
                if (completion) {
                    completion(NO,error.localizedDescription);
                }
            } else {
                
                UMSocialUserInfoResponse *resp = result;

                
                //登录参数
                NSDictionary *params = @{@"openid":resp.openid, @"nickname":resp.name, @"photo":resp.iconurl, @"sex":[resp.unionGender isEqualToString:@"男"]?@1:@2, @"cityname":resp.originalResponse[@"city"], @"fr":@(loginType)};
                
                self.loginType = loginType;
                //登录到服务器
                [self loginToServer:params completion:completion];
            }
        }];
    }else{
        //账号登录 暂未提供
        
    }
}
#pragma mark ————— 注册账号或者判断账号是否存在 —————
-(void)requestEcomRegister:(NSDictionary *)parmeters {
    NSString *url = NSStringFormat(@"%@%@",EmallHostUrl,URL_post_registe);
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
//    NSDictionary*parmeters=@{
//                             @"phoneNumber":self.phoneNumber,
//                             @"verificationCode":self.verificationCode,
//                             @"name":self.phoneNumber,//姓名是手机号码
//                             @"group":@"CUSTOMER"
//                             };
    [manager POST:url parameters:parmeters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
//        self.statusCode=responses.statusCode;
//        if (completedCallback) {
//            completedCallback(responseObject);
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failedCallback) {
//            failedCallback(error);
//        }
        
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSString*code=body[@"code"];
        if ([code isEqualToString:@"user.Existed"]) {
//            [self EcommerceOfLogin];
            [self loginToServer:parmeters completion:nil];
        }
        else if ([code isEqualToString:@"user.password.NotMatched"]){
            NSString*account_error=NSLocalizedString(@"account_error", nil);
            [PSTipsView showTips:account_error];
        }
        else if ([code isEqualToString:@"sms.verification-code.NotMatched"]){
            [PSTipsView showTips:@"验证码错误"];
        }
        else if ([code isEqualToString:@"unauthorized"]){
            [PSTipsView showTips:@"账号不存在"];
        }
        else if ([code isEqualToString:@"user.group.NotMatched"]){
            [PSTipsView showTips:@"账号不属于该群组"];
        }
        else if ([code isEqualToString:@"invalid_grant"]){
            [PSTipsView showTips:@"账号已禁用"];
        }
        else {
//            [self showNetError:error];
        }
//        
    }];
    
    [PPNetworkHelper POST:url parameters:parmeters success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSString*code=body[@"code"];
        if ([code isEqualToString:@"user.Existed"]) {
            //            [self EcommerceOfLogin];
         
        }
        else if ([code isEqualToString:@"user.password.NotMatched"]){
            NSString*account_error=NSLocalizedString(@"account_error", nil);
            [PSTipsView showTips:account_error];
        }
        else if ([code isEqualToString:@"sms.verification-code.NotMatched"]){
            [PSTipsView showTips:@"验证码错误"];
        }
        else if ([code isEqualToString:@"unauthorized"]){
            [PSTipsView showTips:@"账号不存在"];
        }
        else if ([code isEqualToString:@"user.group.NotMatched"]){
            [PSTipsView showTips:@"账号不属于该群组"];
        }
        else if ([code isEqualToString:@"invalid_grant"]){
            [PSTipsView showTips:@"账号已禁用"];
        }
        else {
            //            [self showNetError:error];
        }
        
    }];
}

#pragma mark ————— 手动登录到服务器 —————
-(void)loginToServer:(NSDictionary *)params completion:(loginBlock)completion{
//    NSDictionary*parmeters=@{
//                             @"username":@"15526477756",
//                             @"password":@"9619",
//                             @"grant_type":@"password"
//                             };
<<<<<<< HEAD
//    NSString*uid=@"consumer.m.app";
//    NSString*cipherText=@"1688c4f69fc6404285aadbc996f5e429";
    NSString*uid=@"assistant.app";
    NSString*cipherText=@"506a7b6dfc5d42fe857ea9494bb24014";
=======
    NSString *username = [params valueForKey:@"name"];
    NSString *password = [params valueForKey:@"verificationCode"];
    NSDictionary *paames = @{
                          @"username":username,
                          @"password":password,
                          @"grant_type":@"password"
                          };
    
    
    NSString*uid=@"assistant.app";
    NSString*cipherText=@"506a7b6dfc5d42fe857ea9494bb24014";
//    NSString*uid=@"consumer.m.app";
//    NSString*cipherText=@"1688c4f69fc6404285aadbc996f5e429";
>>>>>>> 1c6b88ee5eec4c869388b38a48cfc23099958e23
    NSString *part1 = [NSString stringWithFormat:@"%@:%@",uid,cipherText];
    NSData   *data = [part1 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *stringBase64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString * authorization = [NSString stringWithFormat:@"Basic %@",stringBase64];
    
    NSString*url=[NSString stringWithFormat:@"%@%@",EmallHostUrl,URL_get_oauth_token];
    
    NSMutableURLRequest *formRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:paames error:nil];
    
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
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error_description) {
                        [MBProgressHUD showInfoMessage:error_description];
                    } else {
                        [MBProgressHUD showInfoMessage:@"登录失败"];
                    }
                    [MBProgressHUD hideHUD];
                });
            } else {
                    [MBProgressHUD showInfoMessage:@"登录失败"];
            }
        }
        else {
            if (responseStatusCode == 200) { //
                //保存最新的Ouath认证信息
                //登录成功
                OauthInfo *oauthInfo = [OauthInfo modelWithJSON:responseObject];
                self.oathInfo = oauthInfo;
                @weakify(self);
                [self removeUserOuathInfo:^{
                    @strongify(self)
                    [self saveUserOuathInfo];
                    self.curUserInfo = [[UserInfo alloc] init];
                    self.curUserInfo.username = [params valueForKey:@"username"];
                    //获取云信账号信息
                    [self getIMMinfo];
                    
                }];
            }
        }
    }];
    
    [dataTask resume];
    
    
    /*
    OauthInfo *oauthInfo = [self loadOuathInfo];
    NSString *access_token = oauthInfo.access_token;
    NSString *token = NSStringFormat(@"Bearer %@",access_token);
    
    [PPNetworkHelper setValue:token forHTTPHeaderField:@"Authorization"];
    dispatch_async(dispatch_get_main_queue(), ^{
       [MBProgressHUD showActivityMessageInView:@"登录中..."];
    });
    NSString *url = NSStringFormat(@"%@%@",ServerUrl,URL_user_login);
    
    [PPNetworkHelper POST:url parameters:nil success:^(id responseObject) {
        [self LoginSuccess:responseObject completion:completion];
        
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        if (completion) {
            completion(NO,error.localizedDescription);
        }
    }];
     
     */
}
#pragma mark ————— 获取网易云账号密码   ————
- (void)getIMMinfo {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showActivityMessageInView:@"登录中..."];
    });
    NSString *access_token = self.oathInfo.access_token;
    NSString *token = NSStringFormat(@"Bearer %@",access_token);
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = NSStringFormat(@"%@%@",EmallHostUrl,URL_get_im_info);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = responseObject;
        UserInfo *userInfo = [UserInfo modelWithDictionary:data];
        userInfo.username = self.curUserInfo.username;
        self.curUserInfo = userInfo;
         NSLog(@"%@",self.curUserInfo);
        //登录成功储存用户信息
        [self saveUserInfo];
        //登录云信
        [self LoginSuccess:data completion:^(BOOL success, NSString *des) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        
        }];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //token 过期重新获取token
        NSString *errorInfo = error.userInfo[@"NSLocalizedDescription"];
        if ([errorInfo isEqualToString:@"Request failed: unauthorized (401)"]) {
            [self refreshOuathToken];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        

    }];
}

#pragma mark ————— 重新刷新获取Token —————
- (void)refreshOuathToken {
    NSString *refresh_token = self.oathInfo.refresh_token?self.oathInfo.refresh_token:@"";
    NSDictionary*parmeters=@{
                             @"refresh_token":refresh_token,
                             @"grant_type":@"refresh_token"
                             };
    [self loginToServer:parmeters completion:nil];
    
}

#pragma mark ————— 自动登录到服务器 —————
-(void)autoLoginToServer:(loginBlock)completion{

    [self getIMMinfo];
//    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_auto_login) parameters:nil success:^(id responseObject) {
//        [self LoginSuccess:responseObject completion:completion];
//
//    } failure:^(NSError *error) {
//        if (completion) {
//            completion(NO,error.localizedDescription);
//        }
//    }];
}

#pragma mark ————— 登录成功处理 —————
-(void)LoginSuccess:(id )responseObject completion:(loginBlock)completion{
    
    if (ValidDict(responseObject)) {
        NSDictionary *data = responseObject;
        if (ValidStr(data[@"account"]) && ValidStr(data[@"token"])) {
            //登录IM
            [[IMManager sharedIMManager] IMLogin:data[@"account"] IMPwd:data[@"token"] completion:^(BOOL success, NSString *des) {
                if (success) {
                    self.isLogined = YES;
                    
                    if (completion) {
                        completion(YES,nil);
                    }
                    KPostNotification(KNotificationLoginStateChange, @YES);
                }else{
                    if (completion) {
                        completion(NO,@"IM登录失败");
                    }
                    KPostNotification(KNotificationLoginStateChange, @NO);
                }
            }];
        }else{
            if (completion) {
                completion(NO,@"登录返回数据异常");
            }
            KPostNotification(KNotificationLoginStateChange, @NO);
        }
    }else{
        if (completion) {
            completion(NO,@"登录返回数据异常");
        }
        KPostNotification(KNotificationLoginStateChange, @NO);
    }
    
}
#pragma mark ————— 储存用户信息 —————
-(void)saveUserInfo{
    if (self.curUserInfo) {
        YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
        NSDictionary *dic = [self.curUserInfo modelToJSONObject];
        [cache setObject:dic forKey:KUserModelCache];
    }
    
}
#pragma mark ————— 加载缓存的用户信息 —————
-(BOOL)loadUserInfo{
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    NSDictionary * userDic = (NSDictionary *)[cache objectForKey:KUserModelCache];
    if (userDic) {
        self.curUserInfo = [UserInfo modelWithJSON:userDic];
        return YES;
    }
    return NO;
}

#pragma mark ————— 加载公共服务token信息 —————
-(BOOL)loadUserOuathInfo{
    YYCache *cache = [[YYCache alloc]initWithName:KOauthCacheName];
    NSDictionary * userDic = (NSDictionary *)[cache objectForKey:KOauthModelCache];
    if (userDic) {
        self.oathInfo = [OauthInfo modelWithJSON:userDic];
        return YES;
    }
    return NO;
}
#pragma mark ————— 储存用户公共服务获取的信息 —————
-(void)saveUserOuathInfo {
    if (self.oathInfo) {
        YYCache *cache = [[YYCache alloc]initWithName:KOauthCacheName];
        NSDictionary *dic = [self.oathInfo modelToJSONObject];
        [cache setObject:dic forKey:KOauthModelCache];
    }
}

#pragma mark ————— 移除用户公共服务获取的信息 —————
-(void)removeUserOuathInfo:(Complete)complete {
    YYCache *cache = [[YYCache alloc]initWithName:KOauthModelCache];
    [cache removeAllObjectsWithBlock:^{
        if (complete) {
            complete();
        }
    }];
}

#pragma mark ————— 获取oauthtoken
- (OauthInfo *)loadOuathInfo {
    YYCache *cache = [[YYCache alloc] initWithName:KOauthModelCache];
    NSDictionary * oauthInfo = (NSDictionary *)[cache objectForKey:KOauthModelCache];
    if (oauthInfo) {
        OauthInfo *curOauthInfo = [OauthInfo modelWithJSON:oauthInfo];
        return curOauthInfo;
    }
    return nil;
}

#pragma mark ————— 被踢下线 —————
-(void)onKick{
    [self logout:nil];
}
#pragma mark ————— 退出登录 —————
- (void)logout:(void (^)(BOOL, NSString *))completion{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLogout object:nil];//被踢下线通知用户退出直播间
    
    [[IMManager sharedIMManager] IMLogout];
    
    self.curUserInfo = nil;
    self.oathInfo = nil;
    self.isLogined = NO;

//    //移除缓存
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    [cache removeAllObjectsWithBlock:^{
        if (completion) {
            completion(YES,nil);
        }
    }];
    YYCache *cache1 = [[YYCache alloc] initWithName:KOauthCacheName];
    [cache1 removeAllObjectsWithBlock:^{
        if (completion) {
            completion(YES,nil);
        }
    }];
    
    KPostNotification(KNotificationLoginStateChange, @NO);
}
@end
