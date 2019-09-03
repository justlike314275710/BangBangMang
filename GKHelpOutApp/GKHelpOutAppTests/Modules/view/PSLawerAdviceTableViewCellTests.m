//
//  PSLawerAdviceTableViewCellTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/2.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSLawerAdviceTableViewCell.h"

@interface PSLawerAdviceTableViewCellTests : XCTestCase
@property(nonatomic,strong)PSLawerAdviceTableViewCell *view;

@end

@implementation PSLawerAdviceTableViewCellTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _view = [[PSLawerAdviceTableViewCell alloc] initWithFrame:CGRectZero];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _view = nil;
}

- (void)testLifeCycle{
    PSLawerAdviceTableViewCell *cellView = [[PSLawerAdviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    [cellView renderContents];
}


- (void)fillWithModel{
    [_view fillWithModel:[PSConsultation new]];
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
