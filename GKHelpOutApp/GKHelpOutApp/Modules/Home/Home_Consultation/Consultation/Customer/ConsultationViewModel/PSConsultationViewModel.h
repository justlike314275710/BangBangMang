//
//  PSConsultationViewModel.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/10/29.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSViewModel.h"

@interface PSConsultationViewModel : PSViewModel
@property (nonatomic , strong) NSData *consultaionData;
@property (nonatomic , strong) UIImage* consultaionImage;
@property (nonatomic , assign) NSInteger statusCode;
@property (nonatomic , assign) NSInteger code;
@property (nonatomic , strong) NSString *consultaionId;//图片上传返回id
@property (nonatomic , strong) NSString *adviceId;//我的咨询id
@property (nonatomic , strong) NSString *OrderID;//订单id

@property (nonatomic , strong) NSArray  *categories;
@property (nonatomic , strong) NSString *lawyerId;
@property (nonatomic , strong) NSString *describe;
@property (nonatomic , strong) NSArray  *attachments;
@property (nonatomic , strong) NSString *reward;
@property (nonatomic, strong) NSString *customerAvatarURL;

@property (nonatomic , strong) NSString *userName;//用户名用于获取云信id
@property (nonatomic , strong) NSString *chatMessageAccount;
@property (nonatomic , strong) NSArray *myAdviceArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) BOOL hasNextPage;

@property (nonatomic, assign) BOOL agreeProtocol;

@property (nonatomic , strong) NSString*category;//咨询类型

@property (nonatomic , strong) NSString *cid;//话题id
@property (nonatomic , strong) NSString *rate;
@property (nonatomic , strong) NSString *content;
@property (nonatomic , strong) NSString *isResolved;

- (void)checkLawyerDataWithCallback:(CheckDataCallback)callback ;
- (void)checkDataWithCallback:(CheckDataCallback)callback ;
- (void)checkEvaluateDataWithCallback:(CheckDataCallback)callback ;
- (void)uploadConsultationImagesCompleted:(CheckDataCallback)callback;//图片上传

-(void)requestAddEvaluateCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;//增加评论
-(void)requestAddConsultationCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;//新增我的咨询
-(void)requestAddLawyerConsultationCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;//新增指定律师我的咨询
-(void)deleteConsultationCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;//删除我的咨询
-(void)cancelConsultationCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;//取消我的咨询

- (void)refreshMyAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
- (void)loadMyAdviceCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
- (void)refreshMyAdviceDetailsCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

- (void)getChatUsernameCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;//获取云信聊天username
-(void)requestCommentsCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;//评论

//-(void)requestPubicAvatarCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;//获取公共平台头像

@end
