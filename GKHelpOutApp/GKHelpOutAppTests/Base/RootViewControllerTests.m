//
//  RootViewControllerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RootViewController.h"

@interface RootViewControllerTests : XCTestCase
@property(nonatomic,strong)RootViewController *rootVC;

@end

@implementation RootViewControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.rootVC = [RootViewController new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.rootVC = nil;
}

- (void)testLifeCycle{
    [self.rootVC viewWillDisappear:YES];
    [self.rootVC viewDidLoad];
    [self.rootVC viewWillAppear:YES];
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
