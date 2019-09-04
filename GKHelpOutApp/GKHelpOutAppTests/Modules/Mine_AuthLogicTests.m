//
//  Mine_AuthLogicTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/3.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Mine_AuthLogic.h"
@interface Mine_AuthLogicTests : XCTestCase
@property(nonatomic,strong)Mine_AuthLogic *logic;

@end

@implementation Mine_AuthLogicTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.logic = [[Mine_AuthLogic alloc] init];
}

- (void)testcheckDataWithLawyerBasicCallback{
    self.logic.name = @"";
    [self.logic checkDataWithLawyerBasicCallback:^(BOOL successful, NSString *tips) {
        
    }];
}

- (void)testcheckDataWithLawyerBasicCallback1{
    self.logic.name = @"1";
    self.logic.gender = @"";
    [self.logic checkDataWithLawyerBasicCallback:^(BOOL successful, NSString *tips) {
        
    }];
}

- (void)testcheckDataWithLawyerBasicCallback2{
    self.logic.name = @"1";
    self.logic.gender = @"nan";
    self.logic.lawDescription = @"";
    [self.logic checkDataWithLawyerBasicCallback:^(BOOL successful, NSString *tips) {
        
    }];
}

- (void)testcheckDataWithLawyerBasicCallback3{
    self.logic.name = @"1";
    self.logic.gender = @"nan";
    self.logic.lawDescription = @"haha";
    self.logic.lawOffice = @"";
    [self.logic checkDataWithLawyerBasicCallback:^(BOOL successful, NSString *tips) {
        
    }];
}

- (void)testcheckDataWithLawyerBasicCallback4{
    self.logic.name = @"1";
    self.logic.gender = @"nan";
    self.logic.lawDescription = @"haha";
    self.logic.lawOffice = @"ssss";
    self.logic.lawOfficeAddress = @{};
    [self.logic checkDataWithLawyerBasicCallback:^(BOOL successful, NSString *tips) {
        
    }];
}

- (void)testcheckDataWithLawyerBasicCallback5{
    self.logic.name = @"1";
    self.logic.gender = @"nan";
    self.logic.lawDescription = @"haha";
    self.logic.lawOffice = @"ssss";
    self.logic.lawOfficeAddress = @{};
}

- (void)testpostCertificationData{
    self.logic.name = @"11";
    self.logic.gender = @"nanan";
    self.logic.lawDescription = @"nanan";
    self.logic.LawyerCategories = [@[] mutableCopy];
    self.logic.level = @"nanan";
    self.logic.lawOffice = @"nanan";
    self.logic.lawOfficeAddress = @{};
    self.logic.certificatePictures = @[];
    self.logic.assessmentPictures = @[];
    self.logic.identificationPictures = @[];
    self.logic.assessmentPictures = @[];
//
//    [self.logic postCertificationData:^(id data) {
//        
//    } failed:^(NSError *error) {
//        
//    }];
}
- (void)testGETCertificationData{
    [self.logic GETCertificationData:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
- (void)testgetLawyerProfilesData{
    
    [self.logic getLawyerProfilesData:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.logic = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
