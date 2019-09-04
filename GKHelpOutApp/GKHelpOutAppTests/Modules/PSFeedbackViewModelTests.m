//
//  PSFeedbackViewModelTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/3.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSFeedbackViewModel.h"
@interface PSFeedbackViewModelTests : XCTestCase
@property(nonatomic,strong)PSFeedbackViewModel *viewModel;


@end

@implementation PSFeedbackViewModelTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.viewModel = [[PSFeedbackViewModel alloc] init];
    self.viewModel.problem = @"1";
    self.viewModel.detail = @"";
    self.viewModel.attachments = @[];
    
   
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.viewModel = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testsendFeedbackCompleted{
    [self.viewModel sendFeedbackCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

-(void)testcheckDataWithCallback{
    
    [self.viewModel checkDataWithCallback:^(BOOL successful, NSString *tips) {
        
    }];
}

- (void)testsendFeedbackTypesCompleted{
    [self.viewModel sendFeedbackTypesCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

-(void)testrequestdeleteFinish{
    [self.viewModel requestdeleteFinish:^(id responseObject) {
        
    } enError:^(NSError *error) {
        
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
