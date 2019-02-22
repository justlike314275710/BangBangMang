//
//  STLoadingView.m
//  Components
//
//  Created by calvin on 14-5-5.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "PSLoadingView.h"
#import "DGActivityIndicatorView.h"
#import "PSMacro.h"

@interface PSLoadingView ()

@property (nonatomic, strong) DGActivityIndicatorView *indicatorView;

@end

@implementation PSLoadingView

+ (PSLoadingView *)sharedInstance {
    static PSLoadingView *loadingView = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken,^{
        if (!loadingView) {
            loadingView = [[self alloc] init];
        }
    });
    return loadingView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.indicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallPulse tintColor:UIColorFromHexadecimalRGB(0x264c90) size:60];
        [self addSubview:self.indicatorView];
    }
    return self;
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.indicatorView.center = self.center;
}

- (void)show {
    if ([NSThread mainThread]) {
         [self showOnView:[[UIApplication sharedApplication] keyWindow]];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showOnView:[[UIApplication sharedApplication] keyWindow]];
        });
    }
}

- (void)showOnView:(UIView *)view {
    self.frame = view.bounds;
    [self.indicatorView startAnimating];
    self.indicatorView.center = self.center;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

- (void)dismiss {
    if ([NSThread mainThread]) {
        [self.indicatorView stopAnimating];
        [self removeFromSuperview];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            [self removeFromSuperview];
        });
    }
}

/* 
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end

