//
//  RootNavigationControllerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RootNavigationController.h"
@interface RootNavigationControllerTests : XCTestCase
@property(nonatomic,strong)RootNavigationController *rootNavigationVC;

@end

@implementation RootNavigationControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.rootNavigationVC = [[RootNavigationController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.rootNavigationVC = nil;
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

-(void)testpopToAppointViewController{
    BOOL result = [self.rootNavigationVC popToAppointViewController:@"" animated:YES];
    XCTAssertFalse(result);
}

@end
