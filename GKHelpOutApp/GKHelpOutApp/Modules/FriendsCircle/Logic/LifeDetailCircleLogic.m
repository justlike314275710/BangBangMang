//
//  LifeDetailCircleLogic.m
//  GKHelpOutApp
//
//  Created by kky on 2019/4/24.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "LifeDetailCircleLogic.h"

@implementation LifeDetailCircleLogic

-(void)requestLifeCircleDetailCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    
    NSString*url=[NSString stringWithFormat:@"%@%@/%@",ChatServerUrl,URL_LifeCircle_detail,self.circleoffriendsId];
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    NSString *access_token = help_userManager.oathInfo.access_token;
    NSString *token = NSStringFormat(@"Bearer %@",access_token);
    [PPNetworkHelper setValue:token forHTTPHeaderField:@"Authorization"];
    [PPNetworkHelper GET:url parameters:nil success:^(id responseObject) {
        if (ValidDict(responseObject)) {
          
        }
    } failure:^(NSError *error) {
        if (failedCallback) {
            failedCallback(error);
        }
    }];
}

-(void)requestLifeCircleDetailCommentCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    
    NSString*url=[NSString stringWithFormat:@"%@%@",ChatServerUrl,URL_LifeCircle_comment];
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
    NSString *access_token = help_userManager.oathInfo.access_token;
    NSString *token = NSStringFormat(@"Bearer %@",access_token);
    NSDictionary *parameters = @{@"content":self.content,@"circleoffriendsId":self.circleoffriendsId};
    [PPNetworkHelper setValue:token forHTTPHeaderField:@"Authorization"];
    [PPNetworkHelper POST:url parameters:parameters success:^(id responseObject) {
        if (ValidDict(responseObject)) {
            
        }
    } failure:^(NSError *error) {
        
    }];
}

//点赞朋友圈
-(void)requestLifeCircleDetailPraiseCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    
    NSString*url=[NSString stringWithFormat:@"%@%@",ChatServerUrl,URL_LifeCircle_praise];
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
    NSString *access_token = help_userManager.oathInfo.access_token;
    NSString *token = NSStringFormat(@"Bearer %@",access_token);
    NSDictionary *parameters = @{@"circleoffriendsId":self.circleoffriendsId};
    [PPNetworkHelper setValue:token forHTTPHeaderField:@"Authorization"];
    [PPNetworkHelper POST:url parameters:parameters success:^(id responseObject) {
        if (ValidDict(responseObject)) {
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}

@end
