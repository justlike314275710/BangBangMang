//
//  TLCommentDetail.m
//  GKHelpOutApp
//
//  Created by kky on 2019/4/25.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "TLCommentDetail.h"
#import "NSString+Utils.h"

@implementation TLCommentDetail

- (TLMomentDetail *)detail {
    if (!_detail) {
        _detail = [[TLMomentDetail alloc] init];
        _detail.text = self.content;
        NSMutableArray *mdic = [NSMutableArray array];

        _detail.images = mdic;
    }
    return _detail;
}

- (void)setCreatedTime:(NSString *)createdTime
{
    _createdTime = createdTime;
    _showDate = [self momBabayMomentPublishTimeFromInterval:createdTime];
    _createdTime = [NSString timeChange:createdTime];
}

- (NSString *)momBabayMomentPublishTimeFromInterval:(NSString *)timeInterval
{
    //NSTimeInterval late = // [timeInterval longLongValue];
    NSString *lateTime = [NSString timeChange:timeInterval];
    NSTimeInterval late = [NSString timeSwitchTimestamp:lateTime andFormatter:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSString *timeString = @"";
    
    NSTimeInterval cha = now - late;  //秒
    if (cha < 60) {
        timeString = @"刚刚";
    }
    else if (cha / 3600 < 1 && cha > 60) {
        int mm = cha / 60;
        timeString = [NSString stringWithFormat:@"%d分钟前", mm];
    }
    else if (cha / 3600 >= 1 && cha/86400 < 1) {
        int hh = cha / 3600;
        timeString = [NSString stringWithFormat:@"%d小时前", hh];
    }
    else if (cha / 86400 >= 1 && cha/31536000 < 1) {
        int dd = cha / 86400;
        timeString = [NSString stringWithFormat:@"%d天前", dd];
    }
    else if (cha / 31536000 >= 1) {
        int yy = cha / 31536000;
        timeString = [NSString stringWithFormat:@"%d年前", yy];
    }
    
    return timeString;
}

@end
