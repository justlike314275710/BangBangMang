//
//  HMMessageLogicTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/3.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HMMessageLogic.h"

@interface HMMessageLogicTests : XCTestCase
@property(nonatomic,strong)HMMessageLogic *logic;

@end

@implementation HMMessageLogicTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.logic = [[HMMessageLogic alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.logic = nil;
}

- (void)testLife{
    HMMessageLogic *logic = [[HMMessageLogic alloc] init];
}

- (void)testrefreshMesagaeListCompleted{
    [self.logic refreshMesagaeListCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
- (void)loadMyMessageListCompleted{
    [self.logic loadMyMessageListCompleted:^(id data) {
        
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
