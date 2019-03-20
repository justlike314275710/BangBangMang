//
//  PSLawerViewModel.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/2.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSLawerViewModel.h"
#import <AFNetworking/AFNetworking.h>
#import "MJExtension.h"
#import "PSTipsView.h"
#import "PSLoadingView.h"

@interface PSLawerViewModel()
@property (nonatomic , strong) NSMutableArray *items;
@end

@implementation PSLawerViewModel
{
    AFHTTPSessionManager *manager;
    
}
@synthesize dataStatus = _dataStatus;


- (id)init {
    self = [super init];
    if (self) {
        self.page = 1;
        self.pageSize = 10;
    }
    return self;
}
- (NSArray *)myLawerArray{
    return _items;
}


-(void)requestMyAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    manager=[AFHTTPSessionManager manager];
   NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    NSString *url = @"http://10.10.10.17:8086/customer/lawyers";
    manager.requestSerializer.timeoutInterval = 10.f;

    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    NSDictionary*parmeters=@{
                             @"page":[NSString stringWithFormat:@"%ld",(long)self.page],
                             @"size":[NSString stringWithFormat:@"%ld",(long)self.pageSize],
                             @"category":self.category
                             };
    [manager GET:url parameters:parmeters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        NSLog(@"****%@",responseObject);
        if (responses.statusCode==200) {
            self.items = [NSMutableArray new];
//            self.items=[PSConsultation mj_objectArrayWithKeyValuesArray:responseObject[@"content"]];
            if (self.items.count == 0) {
                self.dataStatus = PSDataEmpty;
            }else{
                self.dataStatus = PSDataNormal;
            }
            if (completedCallback) {
                completedCallback(responseObject);
            }
            
        } else {
            if (self.page > 1) {
                self.page --;
                self.hasNextPage = YES;
            }else{
                self.dataStatus = PSDataError;
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedCallback) {
            failedCallback(error);
        }
        if (self.page > 1) {
            self.page --;
            self.hasNextPage = YES;
        }else{
            self.dataStatus = PSDataError;
        }
    }];}

- (void)refreshLawyerCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    
    self.page = 1;
    self.items = nil;
    self.hasNextPage = NO;
    self.dataStatus = PSDataInitial;
    [self requestMyAdviceCompleted:completedCallback failed:failedCallback];
}
- (void)loadMoreLawyerCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    self.page ++;
    [self requestMyAdviceCompleted:completedCallback failed:failedCallback];
}


@end
