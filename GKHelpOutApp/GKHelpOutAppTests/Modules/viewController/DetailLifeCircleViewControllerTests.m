//
//  DetailLifeCircleViewControllerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/30.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DetailLifeCircleViewController.h"
#import "DetailLifeCircleViewController+Tests.h"
#import "LifeDetailCircleLogic.h"

@interface DetailLifeCircleViewControllerTests : XCTestCase
@property (nonatomic,strong)DetailLifeCircleViewController *detailLifeVC;
@property (nonatomic,strong)id mockVC;

@end

@implementation DetailLifeCircleViewControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _detailLifeVC = [[DetailLifeCircleViewController alloc] init];
    _mockVC = OCMPartialMock(_detailLifeVC);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _detailLifeVC = nil;
}
//
- (void)testViewWillAppear {
    [_detailLifeVC viewWillAppear:YES];
}

//调用测试方法是否执行
- (void)testViewDidLoadReload {
    [_mockVC viewDidLoad];
    OCMExpect([[_mockVC reject] stepUI]);
    OCMExpect([[_mockVC reject] stepData:[OCMArg any]]);
}

- (void)teststepUI {
    [self.detailLifeVC stepUI];
}

- (void)testRequestLifeCircleDetailCompletedSucess {
    //mock请求类
    LifeDetailCircleLogic *logic = [[LifeDetailCircleLogic alloc] init];
    DetailLifeCircleViewController *vc = [[DetailLifeCircleViewController alloc] init];

    id mockLogic = OCMPartialMock(logic);
    id mockReqVC = OCMPartialMock(vc);
    [mockReqVC setValue:mockLogic forKey:@"logic"];
    //mock block 数据
    [OCMStub([mockLogic requestLifeCircleDetailCompleted:[OCMArg any] failed:[OCMArg any]])andDo:^(NSInvocation *invocation) {
        void (^RequestDataCompleted)(id data);
//        void (^RequestDataFailed)(NSError *error);
        //第0个和第1个参数是self,SEL,第2才是block
        [invocation getArgument:&RequestDataCompleted atIndex:2];
        //设置返回数据
        RequestDataCompleted(@{@"data":@"请求数据成功"});
    }];

    //调用要验证的方法,有id
    [mockReqVC stepData:YES];
    //验证是否调用相应的方法
    OCMVerify([mockReqVC reloadUI]);
    
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
