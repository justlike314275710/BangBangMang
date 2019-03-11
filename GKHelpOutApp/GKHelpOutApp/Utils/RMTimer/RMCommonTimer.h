//
//  RMCommonTimer.h
//  RMTimer
//
//  Created by 王林 on 2017/5/27.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^RMHandleBlock)(NSInteger currentTime);
typedef void(^RMTimeOutBlock)();


@interface RMCommonTimer : NSObject

+ (instancetype)sharedInstance;

@property (strong, nonatomic)NSTimer *timer;

/**
 倒计时的Block处理
 */
@property (copy, nonatomic)RMHandleBlock handleBlock;

/**
 倒计时结束block处理
 */
@property (copy, nonatomic)RMTimeOutBlock timeoutBlock;

/**
 定时器
 
 @param duration 持续时间
 @param interval 间隔时间
 */
- (void)resumeTimerWithDuration:(NSInteger)duration
					   interval:(NSInteger)interval;



@end
