//
//  UploadManager.h
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/2/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadManager : NSObject
@property (nonatomic , assign) NSInteger code;
@property (nonatomic , strong) UIImage* consultaionImage;
+ (UploadManager *)uploadManager;

- (void)uploadConsultationImagesCompleted:(CheckDataCallback)callback;
@end
