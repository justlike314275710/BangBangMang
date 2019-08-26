//
//  AppDelegateTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/22.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "AppDelegate+AppService.h"

@interface AppDelegateTests : XCTestCase
@property (nonatomic,strong)AppDelegate *appDelegate;

@end

@implementation AppDelegateTests

- (void)setUp {
    self.appDelegate = [AppDelegate shareAppDelegate];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    self.appDelegate = nil;
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

//初始化 window
-(void)testinitWindow{
    [self.appDelegate initWindow];
    XCTAssertNotNil(self.appDelegate.window);
}

//初始化用户系统
-(void)testinitUserManager {
    [self.appDelegate initUserManager];
}

//监听网络状态
- (void)testMonitorNetworkStatus {
    [self.appDelegate monitorNetworkStatus];
}
//注册第三方库
- (void)testRegisterThirdParty {
    [self.appDelegate registerThirdParty];
}

/**
 *  测试是否为单例，要在并发条件下测试
 */
- (void)testShareAppDelegate {
    
    NSMutableArray *managers = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AppDelegate *appDelegate = [[AppDelegate alloc] init];
        [managers addObject:appDelegate];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AppDelegate *appDelegate = [[AppDelegate alloc] init];
        [managers addObject:appDelegate];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AppDelegate *appDelegate = [[AppDelegate alloc] init];
        [managers addObject:appDelegate];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AppDelegate *appDelegate = [[AppDelegate alloc] init];
        [managers addObject:appDelegate];
    });
    
    AppDelegate *appDelegate = [AppDelegate shareAppDelegate];

    [managers enumerateObjectsUsingBlock:^(AppDelegate *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertEqual(appDelegate, obj, @"ZYAudioManager is not single");
    }];
}

/**
 当前顶层控制器
 */
-(void)testGetCurrentVC {
    UIViewController *vc =  [self.appDelegate getCurrentVC];
    XCTAssertNotNil(vc);
}

-(void)testGetCurrentUIVC {
    UIViewController *vc = [self.appDelegate getCurrentUIVC];
    XCTAssertNotNil(vc);
}


@end
