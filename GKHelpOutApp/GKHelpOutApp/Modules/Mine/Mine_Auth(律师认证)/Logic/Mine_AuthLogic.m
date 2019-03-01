//
//  Mine_AuthLogic.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/2/28.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "Mine_AuthLogic.h"

@implementation Mine_AuthLogic
- (void)checkDataWithLawyerBasicCallback:(CheckDataCallback)callback{
    if (self.name.length == 0) {
        if (callback) {
            callback(NO,@"请输入真实姓名");
        }
        return;
    }
    
    if (self.gender.length == 0) {
        if (callback) {
            callback(NO,@"请选择性别");
        }
        return;
    }
    if (self.lawDescription.length == 0) {
        if (callback) {
            callback(NO,@"请输入个人简介");
        }
        return;
    }
    if (self.lawOffice.length == 0) {
        if (callback) {
            callback(NO,@"请输入职业机构");
        }
        return;
    }
    if ([self.lawOfficeAddress isKindOfClass:[NSNull class]]) {
        if (callback) {
            callback(NO,@"请输入职业机构");
        }
        return;
    }
    if (self.categories.count==0) {
        if (callback) {
            callback(NO,@"请选择专业领域");
        }
        return;
    }
    if (self.level.length==0) {
        if (callback) {
            callback(NO,@"请选择律师等级");
        }
        return;
    }
    if (self.workExperience==0) {
        if (callback) {
            callback(NO,@"请选择律师年限");
        }
        return;
    }
    if (self.certificatePictures.count==0) {
        if (callback) {
            callback(NO,@"请上传律师职业证书照片");
        }
        return;
    }
    if (self.assessmentPictures.count==0) {
        if (callback) {
            callback(NO,@"请上传律师年度考核备案照片");
        }
        return;
    }
    if (self.identificationPictures.count==0||self.identificationPictures.count==1) {
        if (callback) {
            callback(NO,@"请上传身份证正反面照片");
        }
        return;
    }
    if (callback) {
        callback(YES,nil);
    }
}

- (void)getCertificationData:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback{
    [self initParmeters];
}

-(void)initParmeters{
    [self initGender];
    [self initLevel];
    [self initCateory];
}


-(void)initGender{
    if ([self.gender isEqualToString:@"男"]) {
        self.gender=@"MALE";
    }
    else{
        self.gender=@"FEMALE";
    }
}

-(void)initLevel{
    if ([self.level isEqualToString:@"一级律师(高级律师)"]) {
        self.level=@"FIRST";
    }
    else if ([self.level isEqualToString:@"二级律师(副高级律师)"]){
         self.level=@"SECOND";
    }
    else if ([self.level isEqualToString:@"三级律师(中级律师)"]){
         self.level=@"THIRD";
    }
    else if ([self.level isEqualToString:@"四级律师(初级律师)"]){
         self.level=@"FOURTH";
    }
    else{
        
    }
}

-(void)initCateory{
    self.LawyerCategories=[[NSMutableArray alloc]init];
    for (int i=0; i<self.categories.count; i++) {
        if ([self.categories[i] isEqualToString:@"财产纠纷"]) {
            [self.LawyerCategories addObject:@"PROPERTY_DISPUTES"];
        }
        else if ([self.categories[i] isEqualToString:@"婚姻家庭"]){
            [self.LawyerCategories addObject:@"MARRIAGE_FAMILY"];
       
        }
        else if ([self.categories[i] isEqualToString:@"交通事故"]){
            [self.LawyerCategories addObject:@"TRAFFIC_ACCIDENT"];
        }
        else if ([self.categories[i] isEqualToString:@"工伤赔偿"]){
            [self.LawyerCategories addObject:@"WORK_COMPENSATION"];
        }
        else if ([self.categories[i] isEqualToString:@"合同纠纷"]){
            [self.LawyerCategories addObject:@"CONTRACT_DISPUTE"];
        }
        else if ([self.categories[i] isEqualToString:@"刑事辩护"]){
            [self.LawyerCategories addObject:@"CRIMINAL_DEFENSE"];
           
        }
        else if ([self.categories[i] isEqualToString:@"房产纠纷"]){
            [self.LawyerCategories addObject:@"HOUSING_DISPUTES"];
        }
        else if ([self.categories[i] isEqualToString:@"劳动就业"]){
            [self.LawyerCategories addObject:@"LABOR_EMPLOYMENT"];
        }
        else{
            
        }
    }
}

@end
