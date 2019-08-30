//
//  PSTipsViewTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/28.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSTipsView.h"

@interface PSTipsViewTests : XCTestCase
@property (nonatomic,strong)PSTipsView *tipView;

@end

@implementation PSTipsViewTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tipView = [[PSTipsView alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.tipView = nil;
}

- (void)testshowTips {
    [PSTipsView showTips:@"测试"];
}


- (void)testshowTips1{
    [PSTipsView showTips:@"延迟测试" dismissAfterDelay:1];
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
