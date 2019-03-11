//
//  RMTimer.m
//  RMTimer
//
//  Created by 王林 on 2017/5/26.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import "RMTimer.h"

@interface RMTimer ()



@end

@implementation RMTimer

static RMTimer *sharedInstance;
+ (instancetype)sharedTimer{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc]init];
	});
	return sharedInstance;
}

- (void)resumeTimerWithDuration:(NSInteger)duration
					   interval:(NSInteger)interval
					handleBlock:(void(^)(NSInteger currentTime))handleBlock
				   timeOutBlock:(void(^)())timeOutBlock
{
	//执行全局并行队列
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	//创建定时器
	self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
	//设置定时时间
	dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 0);
	//配置定时器
	dispatch_source_set_timer(self.timer, start, interval *NSEC_PER_SEC, 0);
	//回调
	__block NSInteger currentTime = duration;
	__weak typeof(self)weakSelf = self;
	dispatch_source_set_event_handler(self.timer, ^{
		currentTime = currentTime - interval;
		if (currentTime <= 0) {
			[weakSelf cancelTimer];
			dispatch_async(dispatch_get_main_queue(), ^{
				if (timeOutBlock) {
					timeOutBlock();
				}
			});
		}else{
			dispatch_async(dispatch_get_main_queue(), ^{
				if (handleBlock) {
					handleBlock(currentTime);
				}
			});
		}
		
	});
	
	//开启定时器
	dispatch_resume(self.timer);
}

- (void)cancelTimer{
	dispatch_source_cancel(self.timer);
	self.timer = nil;
}

- (void)dealloc{
	[self cancelTimer];
}

@end
