//
//  UploadManagerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/23.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UploadManager.h"

@interface UploadManagerTests : XCTestCase
@property(nonatomic,strong)UploadManager *uploadmagenger;

@end

@implementation UploadManagerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.uploadmagenger = [[UploadManager alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.uploadmagenger = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testUploadConsultationImages {
    
    XCTestExpectation *exceptions =  [self expectationWithDescription:@"测试上传图片"];
    [self.uploadmagenger uploadConsultationImages:IMAGE_NAMED(@"朋友圈图片") completed:^(BOOL successful, NSString *tips) {
        XCTAssertTrue(successful);
        [exceptions fulfill];
    } isShowTip:YES];
    
    // 设置等待时间10 超过性能不佳
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}
- (void)testUploadConsultationImages2 {
    XCTestExpectation *exceptions =  [self expectationWithDescription:@"测试上传图片"];
    [self.uploadmagenger uploadConsultationImages:IMAGE_NAMED(@"朋友圈图片") completed:^(BOOL successful, NSString *tips) {
        XCTAssertTrue(successful);
        [exceptions fulfill];
    } isShowTip:NO];
    
    // 设置等待时间10 超过性能不佳
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        [self.uploadmagenger uploadConsultationImages:IMAGE_NAMED(@"朋友圈图片") completed:^(BOOL successful, NSString *tips) {
            XCTAssertTrue(successful);
        } isShowTip:NO];
    }];
}

@end
