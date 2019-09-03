//
//  PSConsultationOtherTableViewCellTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/2.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSConsultationOtherTableViewCell.h"

@interface PSConsultationOtherTableViewCellTests : XCTestCase
@property(nonatomic,strong)PSConsultationOtherTableViewCell *view;

@end

@implementation PSConsultationOtherTableViewCellTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _view = [[PSConsultationOtherTableViewCell alloc] initWithFrame:CGRectZero];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _view = nil;
}

- (void)testLifeCycle{
    PSConsultationOtherTableViewCell *cellView = [[PSConsultationOtherTableViewCell alloc] initWithFrame:CGRectZero];
}

- (void)testhandlerButtonAction{
    [_view handlerButtonAction:nil];
}

- (void)imageWithColor {
    UIImage *image = [_view imageWithColor:[UIColor whiteColor]];
    XCTAssertNotNil(image);
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
