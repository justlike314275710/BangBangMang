//
//  PSPayInfotests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/30.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSPayHandler.h"
#import "PSWechatHandler.h"
#import "PSAliHandler.h"


@interface PSPayInfotests : XCTestCase
@property(nonatomic,strong)PSWechatHandler *wechatHander;
@property(nonatomic,strong)PSAliHandler *aliHandler;

@end

@implementation PSPayInfotests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.wechatHander = [[PSWechatHandler alloc] init];
    self.aliHandler = [[PSAliHandler alloc] init];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.wechatHander = nil;
    self.aliHandler = nil;
}

- (void)testgoPayWithPayInfo{
    PSPayInfo *payInfo = [[PSPayInfo alloc] init];
    payInfo.payment = @"WEIXIN";
    [self.wechatHander goPayWithPayInfo:payInfo];
}

- (void)testgoRemittanceWithPayInfo {
    PSPayInfo *payInfo = [[PSPayInfo alloc] init];
    payInfo.payment = @"WEIXIN";
    [self.wechatHander goRemittanceWithPayInfo:payInfo];
}

- (void)testgoOrderWithPayInfo{
    PSPayInfo *payInfo = [[PSPayInfo alloc] init];
    payInfo.payment = @"WEIXIN";
    [self.wechatHander goOrderWithPayInfo:payInfo];
}

- (void)testgoPayWithPayInfo1{
    PSPayInfo *payInfo = [[PSPayInfo alloc] init];
     payInfo.payment = @"ALIPAY";
    [self.aliHandler goPayWithPayInfo:payInfo];
}

- (void)testgoRemittanceWithPayInfo1 {
    PSPayInfo *payInfo = [[PSPayInfo alloc] init];
    payInfo.payment = @"ALIPAY";
    [self.aliHandler goRemittanceWithPayInfo:payInfo];
}

- (void)testgoOrderWithPayInfo1{
    PSPayInfo *payInfo = [[PSPayInfo alloc] init];
    payInfo.payment = @"ALIPAY";
    [self.aliHandler goOrderWithPayInfo:payInfo];
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
