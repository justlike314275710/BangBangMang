//
//  lawyerInfo.h
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lawyerInfo : NSObject
@property (nonatomic , strong) NSString *gender;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , assign) int workExperience;//工作经验
@property (nonatomic , strong) NSString *lawDescription;//律师简介
@property (nonatomic , strong) NSArray *categories;
@property (nonatomic , strong) NSString*level;
@property (nonatomic , strong) NSString*lawOffice;
@property (nonatomic , strong) NSArray *certificatePictures;
@property (nonatomic , strong) NSArray *assessmentPictures;
@property (nonatomic , strong) NSArray *identificationPictures;
@property (nonatomic , strong) NSDictionary *lawOfficeAddress;
@property (nonatomic , strong) NSArray *fontCardPictures;//身份证正面照
@property (nonatomic , strong) NSArray *backCardPictures;//身份证反面照
@end
