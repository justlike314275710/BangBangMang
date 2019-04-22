//
//  SendLifeCircleLogic.m
//  GKHelpOutApp
//
//  Created by kky on 2019/4/22.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "SendLifeCircleLogic.h"

@implementation SendLifeCircleLogic

- (void)PostReleaseLifeCircleData:(RequestDataCompleted)completed failed:(RequestDataFailed)failedCallback {
    
    //NSString *apiUrl = NSStringFormat(URL_get_verification_code,self.phoneNumber);
    NSString*url=[NSString stringWithFormat:@"%@%@",@"http://192.168.0.230:8087",URL_lifeCircle_release];
    NSDictionary *parameters = @{@"content":self.content,@"circleoffriendsPicture":self.circleoffriendsPicture};
//    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    NSString *access_token = help_userManager.oathInfo.access_token;
    NSString *token = NSStringFormat(@"Bearer %@",access_token);
    [PPNetworkHelper setValue:token forHTTPHeaderField:@"Authorization"];
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

@end
