//
//  PSLawerViewModelTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/3.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSLawerViewModel.h"

@interface PSLawerViewModelTests : XCTestCase
@property(nonatomic,strong)PSLawerViewModel *viewModel;

@end

@implementation PSLawerViewModelTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.viewModel = [[PSLawerViewModel alloc] init];
    self.viewModel.page = 1;
    self.viewModel.pageSize = 5;
    self.viewModel.category = @"1";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.viewModel = nil;
}

- (void)testLifeCycle {
    PSLawerViewModel *viewModel = [[PSLawerViewModel alloc] init];
}

- (void)testrequestMyAdviceCompleted {
    
    [self.viewModel requestMyAdviceCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)testrefreshLawyerCompleted{
    [self.viewModel refreshLawyerCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
- (void)testloadMoreLawyerCompleted{
    [self.viewModel loadMoreLawyerCompleted:^(id data) {
        
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
