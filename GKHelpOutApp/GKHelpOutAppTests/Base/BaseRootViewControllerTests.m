//
//  BaseRootViewControllerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BaseRootViewController.h"

@interface BaseRootViewControllerTests : XCTestCase
@property(nonatomic,strong)BaseRootViewController *rootVC;

@end

@implementation BaseRootViewControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

}

-(void)testshowNoDataImage {
    [self.rootVC showNoDataImage];
}

-(void)testremoveNoDataImage {
    [self.rootVC removeNoDataImage];
}

- (void)testshowLoadingAnimation {
    [self.rootVC showLoadingAnimation];
}

- (void)teststopLoadingAnimation {
    [self.rootVC stopLoadingAnimation];
}

- (void)testaddNavigationItemWithTitles{
    [self.rootVC addNavigationItemWithTitles:nil isLeft:YES target:nil action:nil tags:nil];
}
- (void)testaddNavigationItemWithTitles1 {
    [self.rootVC addNavigationItemWithImageNames:nil isLeft:YES target:nil action:nil tags:nil];
}

- (void)testbackBtnClicked {
    [self.rootVC backBtnClicked];
}

- (void)testcancelRequest {
    [self.rootVC cancelRequest];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.rootVC = [[BaseRootViewController alloc] init];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    self.rootVC = nil;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
