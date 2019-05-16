//
//  STImagePickerController.h
//  Components
//
//  Created by calvin on 16/6/9.
//  Copyright © 2016年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Tool.h"

typedef void (^CropHeaderImageCallback) (UIImage *cropImage);

@interface PSImagePickerController : UIImagePickerController

/**
 *  截取框的大小，默认取屏幕宽和高的最小值为边的正方形
 */
@property (nonatomic, assign) CGSize cropSize;

- (id)initWithCropHeaderImageCallback:(CropHeaderImageCallback)callback;

@end
