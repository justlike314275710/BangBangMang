//
//  UIImage+Stretch.h
//  Common
//
//  Created by calvin on 14-8-16.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Stretch)

- (UIImage *)stretchImage;
/**
 *  拉伸图片
 *
 *  @param point 以point所在的点拉伸
 *
 *  @return 返回拉伸后的图片
 */
- (UIImage *)stretchAtPoint:(CGPoint)point;







@end
