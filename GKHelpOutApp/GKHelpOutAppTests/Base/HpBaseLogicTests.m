//
//  HpBaseLogicTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/23.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HpBaseLogic.h"

@interface HpBaseLogicTests : XCTestCase
@property(nonatomic,strong) HpBaseLogic *hpBaseLogic;


@end

@implementation HpBaseLogicTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.hpBaseLogic = [[HpBaseLogic alloc] init];
}

- (void)testcheckDataWithCallback {
    [self.hpBaseLogic checkDataWithCallback:^(BOOL successful, NSString *tips) {
        
    }];
}

- (void)testfetchDataWithParams {
    [self.hpBaseLogic fetchDataWithParams:nil completed:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.hpBaseLogic = nil;
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
