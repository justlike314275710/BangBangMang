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

+ (UploadManager *)uploadManager;

//- (void)uploadConsultationImagesCompleted:(CheckDataCallback)callback;
-(void)uploadConsultationImages:(UIImage*)images completed:(CheckDataCallback)callback isShowTip:(BOOL)isShowTip;
@end
