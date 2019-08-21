//
//  LoginLogicTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/21.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginLogic.h"

@interface LoginLogicTests : XCTestCase

@property(nonatomic,strong)LoginLogic *logic;

@end

@implementation LoginLogicTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.logic = [[LoginLogic alloc] init];
    self.logic.phoneNumber = @"15526277756";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.logic = nil;
}

- (void)testcheckDataWithPhoneCallback {
    [self.logic checkDataWithPhoneCallback:^(BOOL successful, NSString *tips) {
        
    }];
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
