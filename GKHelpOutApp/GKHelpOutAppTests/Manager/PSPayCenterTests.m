//
//  PSPayCenterTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/30.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSPayCenter.h"


@interface PSPayCenterTests : XCTestCase

@property(nonatomic,strong)PSPayCenter *payCenter;

@end

@implementation PSPayCenterTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.payCenter = [PSPayCenter  payCenter];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.payCenter = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testGoPayWithPayInfo{
    PSPayInfo *info = [PSPayInfo new];
    info.payment = @"WEIXIN";
    [self.payCenter goPayWithPayInfo:info type:PayTypeBuy callback:^(BOOL result, NSError *error) {
        
    }];
}

- (void)testGoPayWithPayInfo1{
    PSPayInfo *info = [PSPayInfo new];
    info.payment = @"WEIXIN";
    [self.payCenter goPayWithPayInfo:info type:PayTypeRem callback:^(BOOL result, NSError *error) {
        
    }];
}

- (void)testGoPayWithPayInfo2{
    
    PSPayInfo *info = [PSPayInfo new];
    info.payment = @"WEIXIN";
    [self.payCenter goPayWithPayInfo:info type:PayTypeOrd callback:^(BOOL result, NSError *error) {
        
    }];
}

- (void)testGoPayWithPayInfo3{
    
    PSPayInfo *info = [PSPayInfo new];
    info.payment = @"ALIPAY";
    [self.payCenter goPayWithPayInfo:info type:PayTypeOrd callback:^(BOOL result, NSError *error) {
        
    }];
}

- (void)testGoPayWithPayInfo4{
    
    PSPayInfo *info = [PSPayInfo new];
    info.payment = @"ALIPAY";
    [self.payCenter goPayWithPayInfo:info type:PayTypeOrd callback:^(BOOL result, NSError *error) {
        
    }];
}

- (void)testGoPayWithPayInfo5{
    
    PSPayInfo *info = [PSPayInfo new];
    info.payment = @"ALIPAY";
    [self.payCenter goPayWithPayInfo:info type:PayTypeOrd callback:^(BOOL result, NSError *error) {
        
    }];
}

- (void)testGoPayWithPayInfo6{
    
    PSPayInfo *info = [PSPayInfo new];
    info.payment = @"ALIPAYs";
    [self.payCenter goPayWithPayInfo:info type:PayTypeOrd callback:^(BOOL result, NSError *error) {
        
    }];
}

- (void)testhandleWeChatURL{
    [self.payCenter handleWeChatURL:nil];
}
- (void)testhandleAliURL{
    [self.payCenter handleAliURL:nil];
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
