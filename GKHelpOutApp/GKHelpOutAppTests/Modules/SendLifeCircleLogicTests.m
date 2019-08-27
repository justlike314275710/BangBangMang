//
//  SendLifeCircleLogicTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SendLifeCircleLogic.h"

@interface SendLifeCircleLogicTests : XCTestCase
@property(nonatomic,strong)SendLifeCircleLogic *sendLifeCircleLogic;

@end

@implementation SendLifeCircleLogicTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.sendLifeCircleLogic = [[SendLifeCircleLogic alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.sendLifeCircleLogic = nil;
}

- (void)testpostReleaseLifeCircleData {
    
    XCTestExpectation *exceptions =  [self expectationWithDescription:@"测试发布朋友圈"];
    self.sendLifeCircleLogic.content = @"1";
    self.sendLifeCircleLogic.circleoffriendsPicture = @[];
    [self.sendLifeCircleLogic postReleaseLifeCircleData:^(id data) {
        
        XCTAssertNotNil(data);
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
