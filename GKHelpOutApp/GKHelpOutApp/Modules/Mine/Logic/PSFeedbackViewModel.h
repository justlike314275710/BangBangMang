//
//  PSFeedbackViewModel.h
//  PrisonService
//
//  Created by calvin on 2018/4/27.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSViewModel.h"
//枚举---
typedef NS_ENUM(NSInteger,WritefeedType) {
    PSWritefeedBack,   //app投诉反馈
    PSPrisonfeedBack,  //监狱投诉建议
};

@interface PSFeedbackViewModel : PSViewModel

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *imageUrls;
@property (nonatomic, strong) NSArray *reasons;
@property (nonatomic, assign)WritefeedType writefeedType;
@property (nonatomic, assign)NSArray *urls; //要删除图片数组

- (void)sendFeedbackCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

- (void)sendFeedbackTypesCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

-(void)requestdeleteFinish:(void(^)(id responseObject))finish
                   enError:(void(^)(NSError *error))enError;



@end
