//
//  PSAppointmentViewModel.h
//  PrisonService
//
//  Created by calvin on 2018/4/21.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSAppointmentBaseViewModel.h"
//#import "PSMeeting.h"

@interface PSAppointmentViewModel : PSAppointmentBaseViewModel

@property (nonatomic, strong) NSString *familyId;
@property (nonatomic, strong) NSString *applicationDate;
@property (nonatomic, strong) NSString *prisonerId;
@property (nonatomic, strong) NSString *charge;
@property (nonatomic, strong) NSString *jailId;
@property (nonatomic , strong) NSArray *meetingMembers;



//- (PSMeeting *)meetingOfDate:(NSDate *)date;
//- (PSMeeting *)latestFinishedMeetingOfDate:(NSDate *)date;
//- (void)updateMeetingsOfYearMonth:(NSString *)yearMonth;
//- (NSInteger)passedMeetingTimesOfDate:(NSDate *)date;
- (void)requestMeetingsOfYearMonth:(NSString *)yearMonth force:(BOOL)force completed:(RequestDataTaskCompleted)completedCallback;
- (void)addMeetingWithDate:(NSDate *)date completed:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;

@end
