//
//  PSEvaluateViewmodelTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/3.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSEvaluateViewmodel.h"

@interface PSEvaluateViewmodelTests : XCTestCase
@property(nonatomic,strong)PSEvaluateViewmodel *viewModel;

@end

@implementation PSEvaluateViewmodelTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.viewModel = [[PSEvaluateViewmodel alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.viewModel = nil;
}

- (void)testcheckDataWithCallback {
    self.viewModel.rate = @"";
    self.viewModel.isResolved = @"";
    [self.viewModel checkDataWithCallback:^(BOOL successful, NSString *tips) {
    
    }];
}

- (void)testcheckDataWithCallback1 {
    self.viewModel.rate = @"0";
    self.viewModel.isResolved = @"1";
    [self.viewModel checkDataWithCallback:^(BOOL successful, NSString *tips) {
        
    }];
}

- (void)testcheckDataWithCallback2 {
    self.viewModel.rate = @"0";
    self.viewModel.isResolved = @"1";
    [self.viewModel checkDataWithCallback:^(BOOL successful, NSString *tips) {
        
    }];
}

-(void)testrequestAddEvaluateCompleted{
    
    [self.viewModel requestAddEvaluateCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)testrefreshEvaluateCompleted {
    [self.viewModel refreshEvaluateCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
- (void)testloadMoreEvaluateCompleted {
    [self.viewModel loadMoreEvaluateCompleted:^(id data) {
        
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
