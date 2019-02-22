//
//  PSEvaluateViewmodel.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/9.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSEvaluateViewmodel.h"
#import <AFNetworking/AFNetworking.h>
//#import "PSBusinessConstants.h"
#import "PSLawyerComments.h"
#import "MJExtension.h"
@interface PSEvaluateViewmodel()
@property (nonatomic , strong) NSMutableArray *items;
@end

@implementation PSEvaluateViewmodel
{
    AFHTTPSessionManager *manager;
    
}
@synthesize dataStatus = _dataStatus;


- (id)init {
    self = [super init];
    if (self) {
        self.page = 0;
        self.pageSize = 10;
    }
    return self;
}

- (NSArray *)myEvaluateArray{
    return _items;
}

- (void)checkDataWithCallback:(CheckDataCallback)callback {
    if (self.rate.length == 0) {
        if (callback){
            callback(NO,@"请对律师服务进行评分");
        }
        return;
    }
//    if (self.content.length == 0) {
//        if (callback){
//            callback(NO,@"请输入您要评价的内容");
//        }
//        return;
//    }
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

-(void)requestAddEvaluateCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    
    manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString*token=help_userManager.oathInfo.access_token;
    NSString*url=[NSString stringWithFormat:@"%@/customer/comments",ConsultationHostUrl];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];

    
     NSDictionary*parmeters=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:[self.rate integerValue]],@"rate",self.isResolved, @"isResolved",self.cid,@"legalAdviceId",self.content,@"content", nil];
//    NSDictionary*parmeters=@{
//                             @"rate":[NSNumber numberWithInteger:[self.rate integerValue]],
//                             @"isResolved":self.isResolved,
//                             @"legalAdviceId":self.cid,
//                             @"content":self.content,
//                             };
    [manager POST:url parameters:parmeters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode==201) {
            if (completedCallback) {
                completedCallback(responseObject);
            }
        }
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failedCallback(error);
        }
        
    }];
}


- (void)refreshEvaluateCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    self.page = 0;
    self.items = nil;
    self.hasNextPage = NO;
    self.dataStatus = PSDataInitial;
     [self requestEvaluateCompleted:completedCallback failed:failedCallback];
}
- (void)loadMoreEvaluateCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    self.page++;
    [self requestEvaluateCompleted:completedCallback failed:failedCallback];
}

- (void)requestEvaluateCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    manager=[AFHTTPSessionManager manager];
    NSString*token=help_userManager.oathInfo.access_token;
    NSString*url=[NSString stringWithFormat:@"%@/customer/comments?lawyerId=%@",ConsultationHostUrl,self.lawyerId];
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
                self.dataStatus = PSDataEmpty;
            }else{
                self.dataStatus = PSDataNormal;
            }
            [self.items addObjectsFromArray:[PSLawyerComments mj_objectArrayWithKeyValuesArray:responseObject[@"content"]]];
            NSArray*hasNextPageArray=[PSLawyerComments mj_objectArrayWithKeyValuesArray:responseObject[@"content"]];
            self.totleNumber=responseObject[@"totalElements"];
   
            self.hasNextPage = hasNextPageArray.count >= self.pageSize;
            if (completedCallback) {
                completedCallback(responseObject);
            }
        }else {
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


@end
