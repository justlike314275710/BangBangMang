//
//  LifeCircleManager.m
//  GKHelpOutApp
//
//  Created by kky on 2019/4/29.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "LifeCircleManager.h"

@implementation LifeCircleManager

+ (LifeCircleManager *)sharedInstance {
    static LifeCircleManager *lifeCircleManager = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken,^{
        if (!lifeCircleManager) {
            lifeCircleManager = [[self alloc] init];
        }
    });
    return lifeCircleManager;
}
//朋友圈是否有最新消息
- (void)requestLifeCircleNewDatacompleted:(CheckDataCallback)callback {
    
    NSString*url=[NSString stringWithFormat:@"%@%@",ChatServerUrl,URL_LifeCircle_getNewest];
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    NSString *access_token = help_userManager.oathInfo.access_token;
    NSString *token = NSStringFormat(@"Bearer %@",access_token);
    [PPNetworkHelper setValue:token forHTTPHeaderField:@"Authorization"];
    [PPNetworkHelper GET:url parameters:nil success:^(id responseObject) {
        if (ValidDict(responseObject)) {
            NSString *username = responseObject[@"username"];
            if (ValidStr(username)&&username.length>0) {
                if (callback) {
                    callback(YES,username);
                }
            } else {
                if (callback) {
                    callback(NO,@"");
                }
            }
        }
    } failure:^(NSError *error) {
        if (error) {
            if (callback) {
                callback(NO,@"");
            }
        }
    }];
}



@end
