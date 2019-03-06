//
//  CustomButton.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/6.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayersWithFrame:frame];
    }
    return self;
}

- (void)setupLayersWithFrame:(CGRect)frame{
    CAShapeLayer * roundedrect = [CAShapeLayer layer];
    roundedrect.frame           = CGRectMake(0, 0, frame.size.width, frame.size.height);
    roundedrect.fillColor       = [UIColor whiteColor].CGColor;
    roundedrect.strokeColor     = [UIColor colorWithRed:0.329 green: 0.329 blue:0.329 alpha:1].CGColor;
    roundedrect.lineDashPattern = @[@5.5, @4.5];
    roundedrect.path            = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, frame.size.width , frame.size.height) cornerRadius:20].CGPath;
    [self.layer addSublayer:roundedrect];
}
@end
