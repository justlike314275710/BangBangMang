//
//  PSFeedbackViewModel.m
//  PrisonService
//
//  Created by calvin on 2018/4/27.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSFeedbackViewModel.h"
#import "FeedbackTypeModel.h"
#import "NSString+emoji.h"


@interface PSFeedbackViewModel ()

//@property (nonatomic, strong) PSFeedbackRequest *feedbackRequest;
//@property (nonatomic, strong) PSFeedBackTypesRequest *feedbackTypesRequest;
//@property (nonatomic, strong) PSMailBoxesTypesRequest *mailBoxesTypesRequest;
//@property (nonatomic, strong) PSWriteSuggestionRequest *writeSuggestionRequest;


@end

@implementation PSFeedbackViewModel

 - (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)checkDataWithCallback:(CheckDataCallback)callback {
    if (self.detail.length <10) {
        if (callback) {
            NSString *less_msg = @"请输入不少于10个字的描述";
            callback(NO,less_msg);
        }
        return;
    }
    if ([NSString hasEmoji:self.detail]||[NSString stringContainsEmoji:self.detail]) {
        if (callback) {
            NSString *msg = @"输入的反馈详情不能包含表情,请重新输入";
            callback(NO,msg);
        }
        return;
    }
//    if (self.attachments.count <=0) {
//        if (callback) {
//            NSString *less_msg = @"请至少上传一张图片";
//            callback(NO,less_msg);
//        }
//        return;
//    }

    if (callback) {
        callback(YES,nil);
    }

}

- (void)sendFeedbackCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    switch (self.writefeedType) {
        case PSWritefeedBack:
        {
            [self sendAppFeedbackCompleted:completedCallback failed:failedCallback];
        }
            break;
        case PSPrisonfeedBack:
        {
            [self sendSuggestionCompleted:completedCallback failed:failedCallback];
        }
            break;
            
        default:
            break;
    }
}

- (void)sendAppFeedbackCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    NSString *platform = @"ASSISTANT_APP";
    NSDictionary *params = @{@"platform":platform,
                             @"problem":self.problem,
                             @"detail":self.detail,
                             @"attachments":self.attachments};
    
    NSString *url = NSStringFormat(@"%@%@",EmallHostUrl,URL_feedbacks_add);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString*token=[NSString stringWithFormat:@"Bearer %@",help_userManager.oathInfo.access_token];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
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


- (void)sendSuggestionCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    /*
    NSInteger index = [PSSessionManager sharedInstance].selectedPrisonerIndex;
    NSArray *details = [PSSessionManager sharedInstance].passedPrisonerDetails;
    PSPrisonerDetail *prisonerDetail = (index >= 0 && index < details.count) ? details[index] : nil;
    self.writeSuggestionRequest = [PSWriteSuggestionRequest new];
    self.writeSuggestionRequest.title = @"";
    self.writeSuggestionRequest.contents = self.content;
    self.writeSuggestionRequest.imageUrls = self.imageUrls.length>0?self.imageUrls:@"";
    self.writeSuggestionRequest.jailId = prisonerDetail.jailId?prisonerDetail.jailId:@"";
    self.writeSuggestionRequest.familyId = [PSSessionManager sharedInstance].session.families.id;
    self.writeSuggestionRequest.type = self.type;
    [self.writeSuggestionRequest send:^(PSRequest *request, PSResponse *response) {
        if (completedCallback) {
            completedCallback(response);
        }
    } errorCallback:^(PSRequest *request, NSError *error) {
        if (failedCallback) {
            failedCallback(error);
        }
    }];
     */
}



- (void)sendFeedbackTypesCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    /*
    switch (self.writefeedType) {
        case PSWritefeedBack:
        {
            self.feedbackTypesRequest = [PSFeedBackTypesRequest new];
            [self.feedbackTypesRequest send:^(PSRequest *request, PSResponse *response) {
                if (completedCallback) {
                    PSFeedBackTypesResponse *typesResponse = (PSFeedBackTypesResponse *)response;
                    if (typesResponse.types.count > 0) {
                        self.reasons = [typesResponse.types copy];
                    }
                    completedCallback(response);
                }
            } errorCallback:^(PSRequest *request, NSError *error) {
                if (failedCallback) {
                    failedCallback(error);
                }
            }];
        }
            break;
        case PSPrisonfeedBack:
        {
            self.mailBoxesTypesRequest = [PSMailBoxesTypesRequest new];
            [self.mailBoxesTypesRequest send:^(PSRequest *request, PSResponse *response) {
                if (completedCallback) {
                    PSFeedBackTypesResponse *typesResponse = (PSFeedBackTypesResponse *)response;
                    if (typesResponse.types.count > 0) {
                        self.reasons = [typesResponse.types copy];
                    }
                    completedCallback(response);
                }
            } errorCallback:^(PSRequest *request, NSError *error) {
                if (failedCallback) {
                    failedCallback(error);
                }
            }];
        }
            break;
            
        default:
            break;
    }
     */

}

-(NSArray *)reasons {
    return @[@"功能异常：功能故障或不可使用",
             @"产品建议：使用体验不佳，我有建议",
             @"安全问题：隐私信息不安全等",
             @"其他问题"];
}

//删除图片
-(void)requestdeleteFinish:(void(^)(id responseObject))finish
                   enError:(void(^)(NSError *error))enError {
    //删除图片
    NSArray *ary = [NSArray arrayWithArray:self.urls];
    NSDictionary *deleDic = @{@"urls":ary};
    /*
    [PSDeleteRequest requestPUTWithURLStr:ImageDeleteUrl paramDic:deleDic finish:^(id  _Nonnull responseObject) {
        finish(responseObject);
    } enError:^(NSError * _Nonnull error) {
        enError(error);
    }];
     */
}


@end
