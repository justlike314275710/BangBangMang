//
//  LifeCircleLogicTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LifeCircleLogic.h"

@interface LifeCircleLogicTests : XCTestCase
@property(nonatomic,strong)LifeCircleLogic *lifeCircleLogic;

@end

@implementation LifeCircleLogicTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.lifeCircleLogic = [[LifeCircleLogic alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.lifeCircleLogic = nil;
}

- (void)testrefreshLifeCirclelistCompleted {
    XCTestExpectation *expectation = [self expectationWithDescription:@"刷新朋友圈列表"];
    [self.lifeCircleLogic refreshLifeCirclelistCompleted:^(id data) {
        XCTAssertNotNil(data);
        [expectation fulfill];
    } failed:^(NSError *error) {
        XCTAssertNotNil(error);
    }];
    // 设置等待时间2 超过性能不佳
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)testloadMyLifeCircleListCompleted {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"加载朋友圈列表"];
    [self.lifeCircleLogic loadMyLifeCircleListCompleted:^(id data) {
        XCTAssertNotNil(data);
        [expectation fulfill];
    } failed:^(NSError *error) {
        XCTAssertNotNil(error);
    }];
    // 设置等待时间2 超过性能不佳
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)testgetFriendDetailInfoCompleted {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"获取朋友圈详情"];
    self.lifeCircleLogic.friendusername = @"11";
    [self.lifeCircleLogic getFriendDetailInfoCompleted:^(id data) {
        XCTAssertNotNil(data);
        [expectation fulfill];
    } failed:^(NSError *error) {
        XCTAssertNotNil(error);
        [expectation fulfill];
    }];
    // 设置等待时间2 超过性能不佳
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
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
