//
//  AppManagerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/28.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppManager.h"

@interface AppManagerTests : XCTestCase
@property (nonatomic,strong)AppManager *appManager;

@end

@implementation AppManagerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testAppStart {
    [AppManager appStart];
}

- (void)testShowFPS {
    [AppManager showFPS];
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
