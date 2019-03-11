//
//  RMTimer.h
//  RMTimer
//
//  Created by 王林 on 2017/5/26.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMTimer : NSObject

+ (instancetype)sharedTimer;

@property (nonatomic, strong) dispatch_source_t timer;

/**
 定时器

 @param duration 持续时间
 @param interval 间隔时间
 @param handleBlock 倒计时的Block处理
 @param timeOutBlock 倒计时结束block处理
 */
- (void)resumeTimerWithDuration:(NSInteger)duration
					   interval:(NSInteger)interval
					handleBlock:(void(^)(NSInteger currentTime))handleBlock
				   timeOutBlock:(void(^)())timeOutBlock;


/**
 释放计时器
 */
- (void)cancelTimer;


@end
