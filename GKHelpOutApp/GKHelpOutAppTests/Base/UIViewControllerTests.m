//
//  UIViewControllerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UIViewControllerTests : XCTestCase
@property(nonatomic,strong)UIViewController *vc;

@end

@implementation UIViewControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _vc = [[UIViewController alloc] init];
    
}

- (void)testviewDidLoad {
    [_vc viewDidLoad];
}
- (void)testdidReceiveMemoryWarning {
    [_vc didReceiveMemoryWarning];
}
- (void)testviewWillAppear {
    [_vc viewWillAppear:YES];
}

- (void)testviewWillAppea1 {
    [_vc viewWillAppear:NO];
}

- (void)testviewDidAppear {
    [_vc viewDidAppear:YES];
}

- (void)testviewDidAppear2 {
    [_vc viewDidAppear:NO];
}

- (void)testviewWillDisappear {
    [_vc viewWillDisappear:YES];
}

- (void)testviewWillDisappear1 {
    [_vc viewWillDisappear:NO];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
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
