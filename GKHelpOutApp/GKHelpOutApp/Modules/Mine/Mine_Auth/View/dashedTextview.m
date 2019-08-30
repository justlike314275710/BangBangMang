//
//  dashedTextview.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/5.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "dashedTextview.h"

@implementation dashedTextview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect
{
    CGContextRef content = UIGraphicsGetCurrentContext();
    CGPoint Point[4];
    Point[0] = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    Point[1] = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    Point[2] = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    Point[3] = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLines(content, Point, 4);
    CGContextClosePath(content);
    [[UIColor colorWithRed:0.329 green: 0.329 blue:0.329 alpha:0.5] setStroke];
    CGContextSetLineWidth(content, 1);//1宽度
    CGFloat dashArray[] = {2,2};//表示先绘制2个点，再跳过2个点
    CGContextSetLineDash(content, 0, dashArray, 1);
    CGContextStrokePath(content);
}

@end
