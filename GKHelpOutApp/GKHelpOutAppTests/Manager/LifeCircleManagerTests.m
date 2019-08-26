//
//  LifeCircleManagerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/23.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LifeCircleManager.h"


@interface LifeCircleManagerTests : XCTestCase
@property (nonatomic,strong)LifeCircleManager *lifeCircleManger;

@end

@implementation LifeCircleManagerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.lifeCircleManger = [[LifeCircleManager alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.lifeCircleManger = nil;
}

- (void)testRequestLifeCircleNewDatacompleted {
    XCTestExpectation *exceptions =  [self expectationWithDescription:@"最新朋友圈消息接口"];
    [self.lifeCircleManger requestLifeCircleNewDatacompleted:^(BOOL successful, NSString *tips) {
        
        XCTAssertNotNil(tips);
        [exceptions fulfill];
    }];
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
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
