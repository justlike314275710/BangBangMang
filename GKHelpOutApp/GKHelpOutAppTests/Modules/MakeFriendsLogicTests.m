//
//  MakeFriendsLogicTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/3.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MakeFriendsLogic.h"

@interface MakeFriendsLogicTests : XCTestCase
@property(nonatomic,strong)MakeFriendsLogic *logic;

@end

@implementation MakeFriendsLogicTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.logic = [[MakeFriendsLogic alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.logic = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testLoadData {
    [self.logic loadData];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
