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

@property (nonatomic,strong)NSMutableArray *items;


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
//获取生活圈列表
- (void)refreshLifeCirclelistCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    self.page = 0;
    self.items = nil;
    self.hasNextPage = NO;
    self.dataStatus = PSDataInitial;
    [self requestMyLifeCircleCompleted:completedCallback failed:failedCallback];
    
}
- (void)loadMyLifeCircleListCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    self.page ++;
    [self requestMyLifeCircleCompleted:completedCallback failed:failedCallback];
    
}
-(void)requestMyLifeCircleCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    
    NSString*url=[NSString stringWithFormat:@"%@%@?page=%ld&size=%ld",ChatServerUrl,URL_myLifeCircle_List,self.page,self.size];
    switch (self.lifeCircleStyle) {
        case HMLifeCircleALL:
        {
            url = [NSString stringWithFormat:@"%@%@?page=%ld&size=%ld",ChatServerUrl,URL_allLifeCircle_List,self.page,self.size];
        }
            break;
        case HMLifeCircleMy:
        {
           url=[NSString stringWithFormat:@"%@%@?page=%ld&size=%ld",ChatServerUrl,URL_myLifeCircle_List,self.page,self.size];
        }
            break;
        case HMLifeCircleOther:
        {
            url=[NSString stringWithFormat:@"%@%@?username=%@page=%ld&size=%ld",ChatServerUrl,URL_otherLifeCircle_List,self.username,self.page,self.size];
        }
            break;
            
        default:
            break;
    }
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
    NSString *access_token = help_userManager.oathInfo.access_token;
    NSString *token = NSStringFormat(@"Bearer %@",access_token);
    [PPNetworkHelper setValue:token forHTTPHeaderField:@"Authorization"];
    [PPNetworkHelper GET:url parameters:nil success:^(id responseObject) {
        
//        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (ValidDict(responseObject)) {
            if (self.page == 0) {
                self.items = [NSMutableArray array];
            }
            if (self.items.count == 0) {
                self.dataStatus = PSDataEmpty;
            }else{
                self.dataStatus = PSDataNormal;
            }
            [self.items addObjectsFromArray:[TLMoment mj_objectArrayWithKeyValuesArray:responseObject[@"content"]]];
            NSArray*hasNextPageArray=[TLMoment mj_objectArrayWithKeyValuesArray:responseObject[@"TLMoment"]];
            self.hasNextPage = hasNextPageArray.count >= self.page;
            if (completedCallback) {
                completedCallback(responseObject);
            }
            
        } else {
            if (self.page > 0) {
                self.page --;
                self.hasNextPage = YES;
            }else{
                self.dataStatus = PSDataError;
            }
        }
        /*
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
         */
    } failure:^(NSError *error) {
        if (failedCallback) {
            failedCallback(error);
        }
        if (self.page > 0) {
            self.page --;
            self.hasNextPage = YES;
        }else{
            self.dataStatus = PSDataError;
        }
    }];
}

- (NSMutableArray *)datalist {
    return _items;
}


@end
