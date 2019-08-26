//
//  LoginViewControllerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/21.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginViewController.h"

@interface LoginViewControllerTests : XCTestCase

@property (nonatomic,strong)LoginViewController *loginVC;

@end

@implementation LoginViewControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.loginVC = [[LoginViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.loginVC = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)textgetCode {
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
