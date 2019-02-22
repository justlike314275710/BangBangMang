//
//  UIImage+Stretch.m
//  Common
//
//  Created by calvin on 14-8-16.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "UIImage+Stretch.h"

@implementation UIImage (Stretch)

- (UIImage *)stretchImage {
    CGSize imageSize = self.size;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(imageSize.height / 2 - 1.0, imageSize.width / 2 - 1.0, imageSize.height / 2 + 1.0, imageSize.width / 2 + 1.0) resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)stretchAtPoint:(CGPoint)point {
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(point.y - 1.0, point.x - 1.0, self.size.height- (point.y + 1.0), self.size.width - (point.x + 1.0)) resizingMode:UIImageResizingModeStretch];
}

@end
