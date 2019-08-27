//
//  PSViewControllerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/26.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSViewController.h"

@interface PSViewControllerTests : XCTestCase
@property (nonatomic,strong)PSViewController *psviewController;

@end

@implementation PSViewControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.psviewController = [[PSViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.psviewController = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testCreateRightBarButtonItemWithTarget {
    [self.psviewController createRightBarButtonItemWithTarget:nil action:nil normalImage:nil highlightedImage:nil];
}
- (void)testcreateRightBarButtonItemWithTarget {
    [self.psviewController createRightBarButtonItemWithTarget:nil action:nil title:nil];
}


- (void)testShowInternetError {
    [self.psviewController showInternetError];
}

- (void)testnavgationBarImage {
//    UIImage *image =   [self.psviewController navgationBarImage];
}

- (void)testrightItemTitleColor {
    UIColor *color = [self.psviewController rightItemTitleColor];
    XCTAssertNotNil(color);
}

- (void)testleftItemImage {
//    UIImage *image = [self.psviewController leftItemImage];
}

- (void)testtitleColor {
    UIColor *color = [self.psviewController titleColor];
    XCTAssertNotNil(color);
}

- (void)testhiddenNavigationBar {
    BOOL result = [self.psviewController hiddenNavigationBar];
    XCTAssertFalse(result);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
