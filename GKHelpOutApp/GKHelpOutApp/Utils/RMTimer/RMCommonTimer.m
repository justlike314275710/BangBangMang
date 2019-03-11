//
//  RMCommonTimer.m
//  RMTimer
//
//  Created by 王林 on 2017/5/27.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import "RMCommonTimer.h"

@interface RMCommonTimer()

@property (assign, nonatomic)NSInteger currentTime;
@property (assign, nonatomic)NSInteger timeInterval;

@end

@implementation RMCommonTimer

static RMCommonTimer *sharedInstance;
+ (instancetype)sharedInstance{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[RMCommonTimer alloc]init];
	});
	return sharedInstance;
}

- (void)resumeTimerWithDuration:(NSInteger)duration
					   interval:(NSInteger)interval
{
	self.currentTime = duration;
	self.timeInterval = interval;
	self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
	
}

- (void)timerFireMethod{
	self.currentTime = self.currentTime - self.timeInterval;
	if (self.currentTime <= 0) {
		[self cancelTimer];
		dispatch_async(dispatch_get_main_queue(), ^{
			if (self.timeoutBlock) {
				self.timeoutBlock();
			}
		});
	}else{
		dispatch_async(dispatch_get_main_queue(), ^{
			if (self.handleBlock) {
				self.handleBlock(self.currentTime);
			}
		});
	}
}

- (void)cancelTimer{
	[self.timer invalidate];
	self.timer = nil;
}

- (void)dealloc{
	[self cancelTimer];
}


@end
