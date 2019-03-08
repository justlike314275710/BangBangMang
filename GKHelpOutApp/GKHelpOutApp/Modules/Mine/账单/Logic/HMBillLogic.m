//
//  HMBillLogin.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMBillLogic.h"
@interface HMBillLogic()
@property (nonatomic,strong)NSMutableArray *items;

@end

@implementation HMBillLogic
{
    AFHTTPSessionManager *manager;
    
}
@synthesize dataStatus = _dataStatus;
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

//获取账单详情
- (void)refreshMyAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    self.page = 0;
    self.items = nil;
    self.hasNextPage = NO;
    self.dataStatus = DSDataInitial;
    [self requestMyAdviceCompleted:completedCallback failed:failedCallback];
    
}
- (void)loadMyAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    self.page ++;
    [self requestMyAdviceCompleted:completedCallback failed:failedCallback];
}


-(void)requestMyAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    manager=[AFHTTPSessionManager manager];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    NSString*url=[NSString stringWithFormat:@"%@/bill?",ConsultationHostUrl];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    NSDictionary*parmeters=@{
                             @"page":[NSString stringWithFormat:@"%ld",(long)self.page],
                             @"size":[NSString stringWithFormat:@"%ld",(long)self.pageSize]
                             };
    [manager GET:url parameters:parmeters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode==200) {
            if (self.page == 0) {
                self.items = [NSMutableArray array];
            }
            if (self.items.count == 0) {
                self.dataStatus = DSDataEmpty;
            }else{
                self.dataStatus = DSDataNormal;
            }
//            [self.items addObjectsFromArray:[PSConsultation mj_objectArrayWithKeyValuesArray:responseObject[@"content"]]];
//            NSArray*hasNextPageArray=[PSConsultation mj_objectArrayWithKeyValuesArray:responseObject[@"content"]];
//            self.hasNextPage = hasNextPageArray.count >= self.pageSize;
            if (completedCallback) {
                completedCallback(responseObject);
            }
            
            
        } else {
            if (self.page > 0) {
                self.page --;
                self.hasNextPage = YES;
            }else{
                self.dataStatus = DSDataError;
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedCallback) {
            failedCallback(error);
        }
        if (self.page > 0) {
            self.page --;
            self.hasNextPage = YES;
        }else{
            self.dataStatus = DSDataError;
        }
    }];
    
}

@end
