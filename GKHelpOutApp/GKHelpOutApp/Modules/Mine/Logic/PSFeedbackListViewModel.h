//
//  PSFeedbackListViewModel.h
//  PrisonService
//
//  Created by kky on 2018/12/26.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSViewModel.h"
#import "FeedbackTypeModel.h"
#import "PSFeedbackViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSFeedbackListViewModel : PSViewModel

@property (nonatomic, strong,readonly) NSArray *Recodes;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) BOOL hasNextPage;
@property (nonatomic, copy)   NSString *id;
@property (nonatomic, strong) FeedbackTypeModel *detailModel;
@property (nonatomic, assign) WritefeedType writefeedType;

//PSWritefeedBack
- (void)refreshFeedbackListCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
- (void)loadMoreFeedbackListCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
- (void)refreshFeedbackDetaik:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

//PSPrisonfeedBack





@end

NS_ASSUME_NONNULL_END
