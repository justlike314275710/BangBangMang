//
//  LifeDetailCircleLogicTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LifeDetailCircleLogic.h"
@interface LifeDetailCircleLogicTests : XCTestCase
@property(nonatomic,strong)LifeDetailCircleLogic *lifeDetailCircleLogic;

@end

@implementation LifeDetailCircleLogicTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.lifeDetailCircleLogic = [[LifeDetailCircleLogic alloc] init];
    self.lifeDetailCircleLogic.circleoffriendsId = @"";
    self.lifeDetailCircleLogic.content = @"评论";
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.lifeDetailCircleLogic = nil;
}

-(void)testrequestLifeCircleDetailCompleted {
    XCTestExpectation *expectation = [self expectationWithDescription:@"获取某条生活圈详情"];
    [self.lifeDetailCircleLogic requestLifeCircleDetailCompleted:^(id data) {
        XCTAssertNotNil(data);
        [expectation fulfill];
    } failed:^(NSError *error) {
        XCTAssertNotNil(error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

-(void)testrequestLifeCircleDetailCommentCompleted {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"评论某条朋友圈"];
    [self.lifeDetailCircleLogic requestLifeCircleDetailPraiseCompleted:^(id data) {
        XCTAssertNotNil(data);
        [expectation fulfill];
    } failed:^(NSError *error) {
        XCTAssertNotNil(error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)testrequestLifeCircleDetailPraiseCompleted {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"点赞朋友圈"];
    [self.lifeDetailCircleLogic requestLifeCircleDetailCommentCompleted:^(id data) {
        XCTAssertNotNil(data);
        [expectation fulfill];
    } failed:^(NSError *error) {
        XCTAssertNotNil(error);
        [expectation fulfill];
    }];
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
