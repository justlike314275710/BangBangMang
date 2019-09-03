//
//  PSMyAdviceTableViewCellTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/2.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSMyAdviceTableViewCell.h"

@interface PSMyAdviceTableViewCellTests : XCTestCase
@property(nonatomic,strong)PSMyAdviceTableViewCell *view;

@end

@implementation PSMyAdviceTableViewCellTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _view = [[PSMyAdviceTableViewCell alloc] initWithFrame:CGRectZero];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _view = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    PSMyAdviceTableViewCell *viewCell = [[PSMyAdviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hahaha"];
    
}

- (void)testRenderContents {
    [_view renderContents];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
