//
//  PSBusinessViewControllerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/26.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSBusinessViewController.h"

@interface PSBusinessViewControllerTests : XCTestCase
@property(nonatomic,strong)PSBusinessViewController *pSBusinessViewController;

@end

@implementation PSBusinessViewControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.pSBusinessViewController = [[PSBusinessViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.pSBusinessViewController = nil;
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

- (void)testinitWithViewModel {
    self.pSBusinessViewController = [self.pSBusinessViewController initWithViewModel:nil];
    XCTAssertNotNil(self.pSBusinessViewController);
}

@end
