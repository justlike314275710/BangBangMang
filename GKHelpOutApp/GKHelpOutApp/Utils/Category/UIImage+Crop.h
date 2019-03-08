//
//  UIImage+Crop.h
//  Common
//
//  Created by calvin on 14-10-6.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Crop)

- (UIImage *)cropImageInRect:(CGRect)rect;

- (UIImage*)cropCaptureStillImageWithRect:(CGRect)cropRect;
//裁剪图片 不失真
+ (UIImage *)getImageFromImage:(UIImage*) superImage subImageRect:(CGRect)subImageRect;

+ (UIImage *)fixOrientation:(UIImage *)aImage;

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
@end
