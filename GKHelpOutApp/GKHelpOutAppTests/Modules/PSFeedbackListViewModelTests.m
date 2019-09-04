//
//  PSFeedbackListViewModelTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/3.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSFeedbackListViewModel.h"

@interface PSFeedbackListViewModelTests : XCTestCase
@property(nonatomic,strong)PSFeedbackListViewModel*viewModel;

@end

@implementation PSFeedbackListViewModelTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.viewModel = [[PSFeedbackListViewModel alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.viewModel = nil;
}

- (void)testrefreshFeedbackListCompleted{
    [self.viewModel refreshFeedbackListCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
- (void)testloadMoreFeedbackListCompleted{
    [self.viewModel loadMoreFeedbackListCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
- (void)testrefreshFeedbackDetaik{
    [self.viewModel refreshFeedbackDetaik:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
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
