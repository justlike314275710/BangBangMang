//
//  FriendsViewControllerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/2.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FriendsViewController.h"

@interface FriendsViewControllerTests : XCTestCase
@property(nonatomic,strong)FriendsViewController *fridendVC;

@end

@implementation FriendsViewControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.fridendVC = [[FriendsViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.fridendVC = nil;
}

- (void)testLifeCycle {
    [self.fridendVC viewDidLoad];
    [self.fridendVC viewWillAppear:YES];
    [self.fridendVC viewWillDisappear:YES];
    [self.fridendVC refreshLifeTabbar];
    [self.fridendVC loadMenus];
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
