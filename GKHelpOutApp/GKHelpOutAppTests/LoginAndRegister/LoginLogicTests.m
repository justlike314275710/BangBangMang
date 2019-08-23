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
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.logic = nil;
}
//验证手机填写
- (void)testcheckDataWithPhoneCallback {
    
    self.logic.phoneNumber = @"15526477756";
    [self.logic checkDataWithPhoneCallback:^(BOOL successful, NSString *tips) {
        XCTAssertTrue(successful);
    }];
}

- (void)testcheckDataWithPhoneCallbackWithNoPhone {
    self.logic.phoneNumber = @"";
    [self.logic checkDataWithPhoneCallback:^(BOOL successful, NSString *tips) {
        XCTAssertFalse(successful);
    }];
}
//MARK:验证手机及验证码是否填写
- (void)testcheckDataWithCallback {
    self.logic.phoneNumber = @"15526477756";
    self.logic.messageCode = @"1234";
    [self.logic checkDataWithCallback:^(BOOL successful, NSString *tips) {
        XCTAssertTrue(successful);
    }];
}

- (void)testcheckDataWithCallback1 {
    
    self.logic.phoneNumber = @"";
    self.logic.messageCode = @"1234";
    [self.logic checkDataWithCallback:^(BOOL successful, NSString *tips) {
        XCTAssertFalse(successful);
    }];
}

- (void)testcheckDataWithCallback2 {
    self.logic.phoneNumber = @"15526477756";
    self.logic.messageCode = @"";
    [self.logic checkDataWithCallback:^(BOOL successful, NSString *tips) {
        XCTAssertFalse(successful);
    }];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

//异步测试
- (void)testGetVerificationCodeData {
    self.logic.phoneNumber = @"15526477756";
    XCTestExpectation *exceptions =  [self expectationWithDescription:@"等待时间太长"];
    [self.logic getVerificationCodeData:^(id data) {
        
        XCTAssertNil(data);
        //如果断言没问题，就调用fulfill宣布测试满足
        [exceptions fulfill];
        
    } failed:^(NSError *error) {
        XCTAssertNotNil(error);
    }];
    
    // 设置等待时间2 超过性能不佳
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)testGetVerificationCodeData1 {
    
    self.logic.phoneNumber = @"123456";
    XCTestExpectation *exceptions =  [self expectationWithDescription:@"等待时间太长"];
    [self.logic getVerificationCodeData:^(id data) {
        
        XCTAssertNil(data);
        //如果断言没问题，就调用fulfill宣布测试满足
//        [exceptions fulfill];
        
    } failed:^(NSError *error) {
        //如果断言没问题，就调用fulfill宣布测试满足
        [exceptions fulfill];
        XCTAssertNotNil(error);
    }];
    
    // 设置等待时间10 超过性能不佳
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

//性能测试
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
