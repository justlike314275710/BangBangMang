//
//  PersonListViewControllerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/3.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PersonListViewController.h"
#import "PersonListViewController+tests.h"

@interface PersonListViewControllerTests : XCTestCase
@property(nonatomic,strong)PersonListViewController *vc;

@end

@implementation PersonListViewControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vc = [[PersonListViewController alloc] init];
    
}

-(void)testrefreshLifeTabbar {
    [self.vc refreshLifeTabbar];
}
-(void)testsetupUI {
    [self.vc setupUI];
}
-(void)testheaderRereshing {
    [self.vc headerRereshing];
}
-(void)testfooterRereshing {
    [self.vc footerRereshing];
}
-(void)testrequestDataCompleted {
    [self.vc requestDataCompleted];
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.vc = nil;
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
