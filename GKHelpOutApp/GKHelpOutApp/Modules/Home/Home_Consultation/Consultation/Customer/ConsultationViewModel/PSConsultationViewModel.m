//
//  PSConsultationViewModel.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/10/29.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSConsultationViewModel.h"
//#import "PSUploadConsultaionResponse.h"
//#import "PSUploadConsultaionRequest.h"
#import <AFNetworking/AFNetworking.h>
//#import "PSConsultationRequest.h"
//#import "PSConsultationResponse.h"
#import "PSLoadingView.h"
#import "PSConsultation.h"
#import "MJExtension.h"
//#import "PSBusinessConstants.h"
#import "UIImage+WLCompress.h"
//#import "PSSessionManager.h"

@interface PSConsultationViewModel ()
//@property (nonatomic, strong) PSUploadConsultaionRequest*uploadRequest;
//@property (nonatomic , strong) PSConsultationRequest *consultationRequest;
@property (nonatomic , strong) NSMutableArray *items;
@property (nonatomic, strong) NSArray<PSConsultation,Optional> *consultationsArray;

@end
@implementation PSConsultationViewModel
{
    AFHTTPSessionManager *manager;
    
}
@synthesize dataStatus = _dataStatus;
- (id)init {
    self = [super init];
    if (self) {
        self.page = 0;
        self.pageSize = 10;
        self.agreeProtocol=YES;
        manager=[AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

-(void)requestAddEvaluateCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
     NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    NSString*url=[NSString stringWithFormat:@"%@/customer/comments",ConsultationHostUrl];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    
    NSDictionary*parmeters=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:[self.rate integerValue]],@"rate",self.isResolved, @"isResolved",self.adviceId,@"legalAdviceId",self.content,@"content", nil];

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
-(void)requestAddConsultationCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    [[PSLoadingView sharedInstance]show];
    NSString*urlSting=[NSString stringWithFormat:@"%@/customer/legal-advice/rush",ConsultationHostUrl];
    
        NSURL *url = [NSURL URLWithString:urlSting];
         NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
         request.HTTPMethod = @"POST";
         [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
          NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
          [request addValue:token forHTTPHeaderField:@"Authorization"];
    NSDictionary*dict=[[NSDictionary alloc]init];
    dict=[NSDictionary dictionaryWithObjectsAndKeys:self.reward,@"reward",self.category,@"category", nil];

         NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
         request.HTTPBody = data;
         // 4.发送请求
         NSURLSession*session=[NSURLSession sharedSession];
    NSURLSessionDataTask*task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        NSInteger responseStatusCode = [httpResponse statusCode];
         self.statusCode=responseStatusCode;
        if (error) {
            if (failedCallback) {
                failedCallback(error);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [PSTipsView showTips:@"提交咨询失败"];
                [[PSLoadingView sharedInstance]dismiss];
            });
                                             
        }
        else{
            id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            if (responseStatusCode==201) {
                id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
          
                if (completedCallback) {
                    completedCallback(result);
                }
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [PSTipsView showTips:@"发布成功,请耐心等待律师接单"];
                    [[PSLoadingView sharedInstance]dismiss];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [PSTipsView showTips:@"提交咨询失败!"];
                    [[PSLoadingView sharedInstance]dismiss];
                });
            }
            
           
        }
    }];
    [task resume];

}

-(void)requestAddLawyerConsultationCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    [[PSLoadingView sharedInstance]show];
    NSString*urlSting=[NSString stringWithFormat:@"%@/customer/legal-advice/assign",ConsultationHostUrl];
    
    NSURL *url = [NSURL URLWithString:urlSting];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [request addValue:token forHTTPHeaderField:@"Authorization"];
    NSDictionary*dict=[[NSDictionary alloc]init];
    self.customerAvatarURL=@"";
        if (!self.attachments) {
            dict=[NSDictionary dictionaryWithObjectsAndKeys:self.category,@"category",self.describe,@"description",self.lawyerId,@"lawyerId",self.attachments,@"attachments", nil];
        }

        else{
            dict=[NSDictionary dictionaryWithObjectsAndKeys:self.category,@"category",self.describe,@"description",self.lawyerId,@"lawyerId",self.attachments,@"attachments", nil];
        }
  
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = data;
    // 4.发送请求
    NSURLSession*session=[NSURLSession sharedSession];
    NSURLSessionDataTask*task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        self.statusCode=responseStatusCode;
        if (error) {
            if (failedCallback) {
                failedCallback(error);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [PSTipsView showTips:@"提交咨询失败"];
                [[PSLoadingView sharedInstance]dismiss];
            });
            
        }
        else{
            id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            if (responseStatusCode==201) {
                id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                
                if (completedCallback) {
                    completedCallback(result);
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [PSTipsView showTips:@"发布成功,请耐心等待律师接单"];
                    [[PSLoadingView sharedInstance]dismiss];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [PSTipsView showTips:@"提交咨询失败!"];
                    [[PSLoadingView sharedInstance]dismiss];
                });
            }
            
            
        }
    }];
    [task resume];
}

- (void)checkLawyerDataWithCallback:(CheckDataCallback)callback {
 
    if (self.describe.length == 0) {
        if (callback){
            callback(NO,@"请输入您要描述的问题");
        }
        return;
    }
    
    if (callback) {
        callback(YES,nil);
    }
}
- (void)checkDataWithCallback:(CheckDataCallback)callback {
//    if (self.categories.count == 0) {
//        if (callback){
//            callback(NO,@"请选择咨询类别");
//        }
//        return;
//    }
//    if (self.describe.length == 0) {
//        if (callback){
//            callback(NO,@"请输入您要描述的问题");
//        }
//        return;
//    }
//    if (self.reward<20&&self.reward!=0) {
//        
//        if (callback){
//            callback(NO,@"最低金额不能低于20元");
//        }
//        return;
//    }
//
    if ([self.reward doubleValue]==0||self.reward.length<1) {

        if (callback){
            callback(NO,@"请输入咨询费用");
        }
        return;
    }
    if (!self.agreeProtocol) {
        if (callback) {
            callback(NO,@"请先阅读并同意《法律咨询协议》");
        }
        return;
    }
    if (callback) {
        callback(YES,nil);
    }
    

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





#define boundary @"6o2knFse3p53ty9dmcQvWAIx1zInP11uCfbm"
- (void)uploadConsultationImagesCompleted:(CheckDataCallback)callback{
     [[PSLoadingView sharedInstance]show];
    //1 创建请求
    NSString*urlSting=[NSString stringWithFormat:@"%@/files",EmallHostUrl];
    NSURL *url = [NSURL URLWithString:urlSting];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"post";
    request.allHTTPHeaderFields = @{
                                    @"Content-Type":[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary]
                                    };
    NSData *compressData = [self.consultaionImage compressWithLengthLimit:500.0f * 500.0f];
    request.HTTPBody = [self makeBody:@"file" fileName:@"file" data:compressData];
    //UIImageJPEGRepresentation(self.consultaionImage, 0.1)
     NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [request addValue:token forHTTPHeaderField:@"Authorization"];


    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        self.code=httpResponse.statusCode;
         id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        if (data) {
                if (self.code==201) {
                    id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                    self.consultaionId=result[@"id"];
                    if (callback) {
                    callback(YES,self.consultaionId);
                    }
                     [[PSLoadingView sharedInstance]dismiss];

                } else {
                     [[PSLoadingView sharedInstance]dismiss];
                    [PSTipsView showTips:@"上传图片失败"];
                }
        }
        else{
            [[PSLoadingView sharedInstance]dismiss];
            [PSTipsView showTips:@"上传图片失败"];
        }

    }];
}

- (NSData *)makeBody:(NSString *)fieldName fileName:(NSString *)fileName data:(NSData *)fileData{
    NSMutableData *data = [NSMutableData data];
    NSMutableString *str = [NSMutableString string];
    [str appendFormat:@"--%@\r\n",boundary];
    [str appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",fieldName,fileName];
    [str appendString:@"Content-Type: image/jpeg\r\n\r\n"];
    [data appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:fileData];
    NSString *tail = [NSString stringWithFormat:@"\r\n--%@--",boundary];
    [data appendData:[tail dataUsingEncoding:NSUTF8StringEncoding]];
    return [data copy];
}



- (void)refreshMyAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    self.page = 0;
    self.items = nil;
    self.hasNextPage = NO;
    self.dataStatus = PSDataInitial;
    [self requestMyAdviceCompleted:completedCallback failed:failedCallback];
    
    
}
- (void)loadMyAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
      self.page ++;
    [self requestMyAdviceCompleted:completedCallback failed:failedCallback];
}


-(void)requestMyAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
     manager=[AFHTTPSessionManager manager];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
        NSString*url=[NSString stringWithFormat:@"%@/customer/legal-advice",ConsultationHostUrl];
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
            [self.items addObjectsFromArray:[PSConsultation mj_objectArrayWithKeyValuesArray:responseObject[@"content"]]];
            NSArray*hasNextPageArray=[PSConsultation mj_objectArrayWithKeyValuesArray:responseObject[@"content"]];
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

- (void)getChatUsernameCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    manager=[AFHTTPSessionManager manager];
    
     NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    NSString *url =[NSString stringWithFormat:@"%@/im/users/%@/account",EmallHostUrl,self.userName];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.chatMessageAccount=responseObject[@"account"];
        if (completedCallback) {
            completedCallback(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failedCallback(error);
        }
    }];
}


- (void)refreshMyAdviceDetailsCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    manager=[AFHTTPSessionManager manager];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    NSString *url =[NSString stringWithFormat:@"%@/customer/legal-advice/%@",ConsultationHostUrl,self.adviceId];
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

-(void)deleteConsultationCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    manager=[AFHTTPSessionManager manager];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    NSString *url =[NSString stringWithFormat:@"%@/customer/legal-advice/%@",ConsultationHostUrl,self.adviceId];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager DELETE:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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


-(void)cancelConsultationCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    manager=[AFHTTPSessionManager manager];
     NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    NSString *url =[NSString stringWithFormat:@"%@/customer/legal-advice/%@/cancelled",ConsultationHostUrl,self.adviceId];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode==201) {
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
-(void)requestCommentsCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{

     NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    NSString *url =[NSString stringWithFormat:@"%@/customer/legal-advice/%@/comment",ConsultationHostUrl,self.adviceId];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode==200) {
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
    NSString *url =[NSString stringWithFormat:@"%@/notifications/netease/%@/processed",ConsultationHostUrl,self.adviceId];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode==200||responses.statusCode==201) {
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

//-(void)requestPubicAvatarCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
//    NSString*token=[NSString stringWithFormat:@"Bearer %@",[LXFileManager readUserDataForKey:@"access_token"]];
//    NSString *url =[NSString stringWithFormat:@"%@/users/%@/avatar",EmallHostUrl,self.username];
//    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
//    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
//}


- (NSArray *)myAdviceArray{
    return _items;
}

@end
