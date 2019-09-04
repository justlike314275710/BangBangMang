//
//  HMBIllLogicTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HMBillLogic.h"

@interface HMBIllLogicTests : XCTestCase
@property(nonatomic,strong)HMBillLogic *logic;

@end

@implementation HMBIllLogicTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.logic = [[HMBillLogic alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.logic = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testrefreshMyAdviceCompleted{
    [self.logic refreshMyAdviceCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
- (void)testloadMyAdviceCompleted {
    [self.logic loadMyAdviceCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
