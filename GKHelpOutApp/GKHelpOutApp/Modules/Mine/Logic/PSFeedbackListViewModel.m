//
//  PSFeedbackListViewModel.m
//  PrisonService
//
//  Created by kky on 2018/12/26.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSFeedbackListViewModel.h"
//#import "PSSessionManager.h"
//#import "PSFeedbackListResponse.h"
//#import "PSFeedbackDetailResponse.h"
//#import "PSFeedbackDetailRequest.h"
//#import "PSMailBoxesRequest.h"
//#import "PSMailBoxesDetailRequest.h"
@interface PSFeedbackListViewModel()
//@property (nonatomic , strong) PSFeedbackListRequest *remittanceRequest;
//@property (nonatomic , strong) PSFeedbackDetailRequest *feedbackDetailRequest;
//@property (nonatomic , strong) PSMailBoxesRequest *mailBoxesRequest;
//@property (nonatomic , strong) PSMailBoxesDetailRequest *mailBoxexDetailRequest;
@property (nonatomic , strong) NSMutableArray *items;

@end

@implementation PSFeedbackListViewModel
@synthesize dataStatus = _dataStatus;

-(id)init {
    self = [super init];
    if (self) {
        self.page = 1;
        self.pageSize = 10;
    }
    return self;
}

-(NSArray*)Recodes{
    return _items;
}
- (void)refreshFeedbackListCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    self.page = 1;
    self.items = nil;
    self.hasNextPage = NO;
    self.dataStatus = PSDataInitial;
    /*
    switch (self.writefeedType) {
        case PSWritefeedBack:  //app
        {
            [self requestFeedbackListCompleted:completedCallback failed:failedCallback];
        }
            break;
        case PSPrisonfeedBack: //监狱
        {
            [self requestSuggestionsCompleted:completedCallback failed:failedCallback];
        }
            break;
            
        default:
            break;
    }
     */
}

- (void)loadMoreFeedbackListCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    self.page ++;
    switch (self.writefeedType) {
        case PSWritefeedBack:  //app
        {
            [self requestFeedbackListCompleted:completedCallback failed:failedCallback];
        }
            break;
        case PSPrisonfeedBack: //监狱
        {
            [self requestSuggestionsCompleted:completedCallback failed:failedCallback];
        }
            break;
            
        default:
            break;
    }
}

- (void)requestFeedbackListCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    /*
    
    PSPrisonerDetail *prisonerDetail = nil;
    NSInteger index = [PSSessionManager sharedInstance].selectedPrisonerIndex;
    NSArray *details = [PSSessionManager sharedInstance].passedPrisonerDetails;
    if (index >= 0 && index < details.count) {
        prisonerDetail = details[index];
    }
    self.remittanceRequest = [PSFeedbackListRequest new];
    self.remittanceRequest.page = self.page;
    self.remittanceRequest.rows = self.pageSize;
    self.remittanceRequest.familyId = [PSSessionManager sharedInstance].session.families.id;
    
    @weakify(self)
    [self.remittanceRequest send:^(PSRequest *request, PSResponse *response) {
        @strongify(self)
        if (response.code == 200) {
            PSFeedbackListResponse *feedbackListResponse = (PSFeedbackListResponse *)response;
            if (self.page == 1) {
                self.items = [NSMutableArray new];
            }
            if (feedbackListResponse.feedbacks.count == 0) {
                self.dataStatus = PSDataEmpty;
            }else{
                self.dataStatus = PSDataNormal;
            }
            self.hasNextPage =feedbackListResponse.feedbacks.count >= self.pageSize;
            [self.items addObjectsFromArray:feedbackListResponse.feedbacks];


        }else{
            if (self.page > 1) {
                self.page --;
                self.hasNextPage = YES;
            }else{
                self.dataStatus = PSDataError;
            }
        }
        if (completedCallback) {
            completedCallback(response);
        }
    } errorCallback:^(PSRequest *request, NSError *error) {
        @strongify(self)
        if (self.page > 1) {
            self.page --;
            self.hasNextPage = YES;
        }else{
            self.dataStatus = PSDataError;
        }
        if (failedCallback) {
            failedCallback(error);
        }
    }];
     
     */
}

#pragma mark - 监狱
- (void)refreshSuggestionsCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    self.page = 1;
    self.items = nil;
    self.hasNextPage = NO;
    self.dataStatus = PSDataInitial;
    [self requestSuggestionsCompleted:completedCallback failed:failedCallback];
}

- (void)loadMoreSuggestionsCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    self.page ++;
    [self requestSuggestionsCompleted:completedCallback failed:failedCallback];
}

- (void)requestSuggestionsCompleted:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    /*
    PSPrisonerDetail *prisonerDetail = nil;
    NSInteger index = [PSSessionManager sharedInstance].selectedPrisonerIndex;
    NSArray *details = [PSSessionManager sharedInstance].passedPrisonerDetails;
    if (index >= 0 && index < details.count) {
        prisonerDetail = details[index];
    }
    self.mailBoxesRequest = [PSMailBoxesRequest new];
    self.mailBoxesRequest.page = self.page;
    self.mailBoxesRequest.rows = self.pageSize;
    self.mailBoxesRequest.jailId = prisonerDetail.jailId;
    self.mailBoxesRequest.familyId = [PSSessionManager sharedInstance].session.families.id;
    @weakify(self)
    [self.mailBoxesRequest send:^(PSRequest *request, PSResponse *response) {
        @strongify(self)
        if (response.code == 200) {
            PSMailBoxesResponse *suggestionsResponse = (PSMailBoxesResponse *)response;
            if (self.page == 1) {
                self.items = [NSMutableArray new];
            }
            if (suggestionsResponse.mailBoxes.count == 0) {
                self.dataStatus = PSDataEmpty;
            }else{
                self.dataStatus = PSDataNormal;
            }
            self.hasNextPage = suggestionsResponse.mailBoxes.count >= self.pageSize;
            [self.items addObjectsFromArray:suggestionsResponse.mailBoxes];
        }else{
            if (self.page > 1) {
                self.page --;
                self.hasNextPage = YES;
            }else{
                self.dataStatus = PSDataError;
            }
        }
        if (completedCallback) {
            completedCallback(response);
        }
    } errorCallback:^(PSRequest *request, NSError *error) {
        @strongify(self)
        if (self.page > 1) {
            self.page --;
            self.hasNextPage = YES;
        }else{
            self.dataStatus = PSDataError;
        }
        if (failedCallback) {
            failedCallback(error);
        }
    }];
     */
}

- (void)refreshFeedbackDetaik:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
    
    switch (self.writefeedType) {
        case PSWritefeedBack:
        {
            [self refreshAppfeedbackDetaik:completedCallback failed:failedCallback];
        }
            break;
        case PSPrisonfeedBack:
        {
            [self refreshPrisonfeedbackDetaik:completedCallback failed:failedCallback];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)refreshAppfeedbackDetaik:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback
{
    /*
    self.feedbackDetailRequest = [PSFeedbackDetailRequest new];
    self.feedbackDetailRequest.id = self.id;
    @weakify(self)
    [self.feedbackDetailRequest send:^(PSRequest *request, PSResponse *response) {
        @strongify(self)
        if (response.code == 200) {
            PSFeedbackDetailResponse *feedbackDetailResponse = (PSFeedbackDetailResponse *)response;
            self.detailModel = feedbackDetailResponse.detail;
            
        }else{
            
        }
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
- (void)refreshPrisonfeedbackDetaik:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback
{
    /*
    self.mailBoxexDetailRequest = [PSMailBoxesDetailRequest new];
    self.mailBoxexDetailRequest.id = self.id;
    @weakify(self)
    [self.mailBoxexDetailRequest send:^(PSRequest *request, PSResponse *response) {
        @strongify(self)
        if (response.code == 200) {
            PSFeedbackDetailResponse *feedbackDetailResponse = (PSFeedbackDetailResponse *)response;
            self.detailModel = feedbackDetailResponse.detail;
            
        }else{
            
        }
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


@end
