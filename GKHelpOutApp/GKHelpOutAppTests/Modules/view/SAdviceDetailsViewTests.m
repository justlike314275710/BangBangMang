//
//  SAdviceDetailsViewTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/2.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSAdviceDetailsView.h"

@interface SAdviceDetailsViewTests : XCTestCase
@property(nonatomic,strong)PSAdviceDetailsView *psadvieceV;


@end

@implementation SAdviceDetailsViewTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.psadvieceV = [[PSAdviceDetailsView alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.psadvieceV = nil;
}
- (void)testRenderContents {
    [self.psadvieceV renderContents];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    PSAdviceDetailsView *v = [[PSAdviceDetailsView alloc] initWithFrame:CGRectZero];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
