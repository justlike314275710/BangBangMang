//
//  lawyerGrab_Logic.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "lawyerGrab_Logic.h"
#import "PSConsultation.h"
#import "lawyerGrab.h"
@interface lawyerGrab_Logic ()
@property (nonatomic , strong) NSMutableArray *items;
@property (nonatomic , strong) NSMutableArray *grabItems;
@end

@implementation lawyerGrab_Logic
{
    AFHTTPSessionManager *manager;
    
}
@synthesize dataStatus = _dataStatus;
- (id)init {
    self = [super init];
    if (self) {
        self.page = 0;
        self.pageSize = 10;
        manager=[AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}


- (void)refreshLawyerAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    self.page = 0;
    self.items = nil;
    self.hasNextPage = NO;
    self.dataStatus = PSDataInitial;
    [self requestMyAdviceCompleted:completedCallback failed:failedCallback];
}
- (void)loadLawyerAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    self.page ++;
    [self requestMyAdviceCompleted:completedCallback failed:failedCallback];
}
//可抢定单
-(void)requestMyAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    manager=[AFHTTPSessionManager manager];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    NSString*url=[NSString stringWithFormat:@"%@/lawyer/rush/legal-advice",ConsultationHostUrl];
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
                self.dataStatus = PSDataEmpty;
            }else{
                self.dataStatus = PSDataNormal;
            }
            [self.items addObjectsFromArray:[lawyerGrab mj_objectArrayWithKeyValuesArray:responseObject[@"content"]]];
            NSArray*hasNextPageArray=[lawyerGrab mj_objectArrayWithKeyValuesArray:responseObject[@"content"]];
           self.hasNextPage = hasNextPageArray.count >= self.pageSize;
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
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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



-(void)POSTLawyergrabCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    manager=[AFHTTPSessionManager manager];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    NSString*url=[NSString stringWithFormat:@"%@/lawyer/rush/legal-advice/%@/accepted",ConsultationHostUrl,self.cid];
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completedCallback) {
            completedCallback(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedCallback) {
            failedCallback(error);
        }
    }];
}



- (void)refreshMygrabCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    self.page = 0;
    self.items = nil;
    self.hasNextPage = NO;
    self.dataStatus = PSDataInitial;
    [self GETMygrabCompleted:completedCallback failed:failedCallback];
}
- (void)loadMygrabCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    self.page ++;
     [self GETMygrabCompleted:completedCallback failed:failedCallback];
}


-(void)GETMygrabCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    manager=[AFHTTPSessionManager manager];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    NSString*url=[NSString stringWithFormat:@"%@/lawyer/my/legal-advice",ConsultationHostUrl];
    NSDictionary*parmeters=@{
                             @"page":[NSString stringWithFormat:@"%ld",(long)self.page],
                             @"size":[NSString stringWithFormat:@"%ld",(long)self.pageSize]
                             };
    [manager GET:url parameters:parmeters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode==200) {
            if (self.page == 0) {
                self.grabItems = [NSMutableArray array];
            }
            if (self.grabItems.count == 0) {
                self.dataStatus = PSDataEmpty;
            }else{
                self.dataStatus = PSDataNormal;
            }
            [self.grabItems addObjectsFromArray:[lawyerGrab mj_objectArrayWithKeyValuesArray:responseObject[@"content"]]];
            NSArray*hasNextPageArray=[lawyerGrab mj_objectArrayWithKeyValuesArray:responseObject[@"content"]];
            self.hasNextPage = hasNextPageArray.count >= self.pageSize;
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
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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


- (void)checkEvaluateDataWithCallback:(CheckDataCallback)callback {
    if (self.rate.length == 0) {
        if (callback){
            callback(NO,@"请对律师服务进行评分");
        }
        return;
    }
    
    if (self.isResolved.length==0) {
        if (callback){
            callback(NO,@"请选择是否解决问题");
        }
        return;
    }
    
    if (callback) {
        callback(YES,nil);
    }
}
-(void)GETLawyerDetailsCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    manager=[AFHTTPSessionManager manager];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    NSString*url=[NSString stringWithFormat:@"%@/lawyer/my/legal-advice/%@",ConsultationHostUrl,self.cid];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode==200) {
            if (completedCallback) {
                completedCallback(responseObject);
            }
        } else{
            self.dataStatus = PSDataError;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failedCallback) {
            failedCallback(error);
        }
    }];
}

-(void)requestCommentsCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    NSString *url =[NSString stringWithFormat:@"%@/lawyer/my/legal-advice/%@/comment",ConsultationHostUrl,self.cid];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode==204) {
            if (completedCallback) {
                completedCallback(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedCallback) {
            failedCallback(error);
        }
    }];
}



-(void)GETProcessedCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    NSString *url =[NSString stringWithFormat:@"%@/notifications/netease/%@/processed",ConsultationHostUrl,self.cid];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode==200||responses.statusCode==204) {
            if (completedCallback) {
                completedCallback(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedCallback) {
            failedCallback(error);
        }
    }];
}

-(NSArray *)myAdviceArray{
    return _grabItems;
}
- (NSArray *)rushAdviceArray{
    return _items;
}






@end
