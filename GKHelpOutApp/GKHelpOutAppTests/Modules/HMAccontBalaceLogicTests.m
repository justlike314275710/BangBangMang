//
//  HMAccontBalaceLogicTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HMAccontBalaceLogic.h"

@interface HMAccontBalaceLogicTests : XCTestCase
@property(nonatomic,strong)HMAccontBalaceLogic *logic;

@end

@implementation HMAccontBalaceLogicTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.logic = [[HMAccontBalaceLogic alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.logic = nil;
}

///<查询支付宝
- (void)testgetBingLawyerAlipayInfo {
    [self.logic getBingLawyerAlipayInfo:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
///<获取绑定支付宝的sign
- (void)testgetBingLawyerAuthSignData{
    [self.logic getBingLawyerAuthSignData:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
///<绑定支付宝的
- (void)postBingLawyerAlipayData{
    [self.logic postBingLawyerAlipayData:@"id" completed:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
///<解绑支付宝
- (void)testpostUnBingLawyerAlipayData{
    [self.logic postUnBingLawyerAlipayData:^(id data) {
        
    } failed:^(NSError *error) {
        
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
