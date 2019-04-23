//
//  LifeCircleLogic.m
//  GKHelpOutApp
//
//  Created by kky on 2019/4/22.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "LifeCircleLogic.h"
#import "TLMoment.h"

@interface LifeCircleLogic()


@end


@implementation LifeCircleLogic

-(instancetype)init{
    self = [super init];
    if (self) {
        self.page = 0;
        self.size = 10;
    }
    return self;
}

//发布朋友圈
- (void)getLifeCircleListData:(RequestDataCompleted)completed failed:(RequestDataFailed)failedCallback {
    
    NSString*url=[NSString stringWithFormat:@"%@%@?page=%ld&size=%ld",ChatServerUrl,URL_lifeCircle_List,self.page,self.size];
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
    //    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    NSString *access_token = help_userManager.oathInfo.access_token;
    NSString *token = NSStringFormat(@"Bearer %@",access_token);
    [PPNetworkHelper setValue:token forHTTPHeaderField:@"Authorization"];
    [PPNetworkHelper GET:url parameters:nil success:^(id responseObject) {
        if (ValidDict(responseObject)) {
            NSArray *content = [responseObject valueForKey:@"content"];
            for (NSDictionary *dic in content) {
                TLMoment *monent = [TLMoment modelWithJSON:dic];
                [self.datalist addObject:monent];
            }
        }
        if (completed) {
            completed(responseObject);
        }
    } failure:^(NSError *error) {
        if (failedCallback) {
            failedCallback(error);
        }
    }];
}

-(NSMutableArray *)datalist {
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

@end
