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
    
    NSString *apiUrl = NSStringFormat(URL_get_verification_code,@"15526477756");
    NSString*url=[NSString stringWithFormat:@"%@%@",EmallHostUrl,apiUrl];
    [PPNetworkHelper POST:url parameters:nil success:^(id responseObject) {
        
        if (completed) {
            completed(responseObject);
        }
        
    } failure:^(NSError *error) {
        if (failedCallback) {
            failedCallback(error);
        }
        
//        completion(NO,error.localizedDescription);
    }];
}

- (void)getOauthTokenData:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    
    NSDictionary*parmeters=@{
                             @"username":@"15526477756",
                             @"password":@"5423",
                             @"grant_type":@"password"
                             };
    NSString*uid=@"consumer.m.app";
    NSString*cipherText=@"1688c4f69fc6404285aadbc996f5e429";
    NSString * part1 = [NSString stringWithFormat:@"%@:%@",uid,cipherText];
    NSData *data = [part1 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *stringBase64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString * authorization = [NSString stringWithFormat:@"Basic %@",stringBase64];

    NSString*url=[NSString stringWithFormat:@"%@%@",EmallHostUrl,URL_get_oauth_token];

    NSMutableURLRequest *formRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:parmeters error:nil];

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
            if (failedCallback) {
                failedCallback(error);
            }
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString*code=body[@"error"];
            NSString*error_description = body[@"error_description"];
            if (error_description) {
                [MBProgressHUD showInfoMessage:error_description];
            } else {
                [MBProgressHUD showInfoMessage:@"服务器异常"];
            }
        }
        else {
            if (responseStatusCode == 200) { //
                //保存最新的Ouath认证信息
                OauthInfo *oauthInfo = [OauthInfo modelWithJSON:responseObject];
                self.oathInfo = oauthInfo;
                @weakify(self);
                [self removeUserOuathInfo:^{
                    [weak_self saveUserOuathInfo];
                    //登录
                    [weak_self logInAction];
                }];
            }
        }
    }];
    
    [dataTask resume];

}

#pragma mark ————— 登录
-(void)logInAction {
    if (self.lgoinComplete) {
        self.lgoinComplete();
    }
}

#pragma mark ————— 储存用户公共服务获取的信息 —————
-(void)saveUserOuathInfo {
    if (self.oathInfo) {
        YYCache *cache = [[YYCache alloc]initWithName:KOauthModelCache];
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
@end
