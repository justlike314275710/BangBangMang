//
//  PSAppointmentViewModel.m
//  PrisonService
//
//  Created by calvin on 2018/4/21.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSAppointmentViewModel.h"
//#import "PSMeetingsPageRequest.h"
//#import "PSSessionManager.h"
//#import "NSDate+Components.h"
//#import "NSString+Date.h"
//#import "PSMeetingAddRequest.h"

//#define meetingObjectsKey @"meetingObjectsKey"
//#define meetingTimesKey @"meetingTimesKey"
//#define meetingFinishedKey @"meetingFinishedKey"


static const NSString *meetingObjectsKey=@"meetingObjectsKey";
static const NSString *meetingTimesKey=@"meetingTimesKey";
static const NSString *meetingFinishedKey=@"meetingFinishedKey";

@interface PSAppointmentViewModel ()



@end

@implementation PSAppointmentViewModel
- (id)init {
    self = [super init];
    if (self) {
      
    }
    return self;
}






- (void)updateMeetingsOfYearMonth:(NSString *)yearMonth {
    
}

- (void)requestMeetingsOfYearMonth:(NSString *)yearMonth force:(BOOL)force completed:(RequestDataTaskCompleted)completedCallback {
    
}

- (void)addMeetingWithDate:(NSDate *)date completed:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback {
   
}

@end
