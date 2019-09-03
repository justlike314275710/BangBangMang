//
//  PSConsultationViewModelTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/3.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSConsultationViewModel.h"

@interface PSConsultationViewModelTests : XCTestCase
@property(nonatomic,strong)PSConsultationViewModel *viewModel;

@end

@implementation PSConsultationViewModelTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.viewModel = [[PSConsultationViewModel alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.viewModel = nil;
}

- (void)testcheckLawyerDataWithCallback {
    self.viewModel.describe = @"";
    [self.viewModel checkLawyerDataWithCallback:^(BOOL successful, NSString *tips) {
        XCTAssertFalse(successful);
    }];
}

- (void)testcheckLawyerDataWithCallback1 {
    self.viewModel.describe = @"描述问题";
    [self.viewModel checkLawyerDataWithCallback:^(BOOL successful, NSString *tips) {
        XCTAssertTrue(successful);
    }];
}

- (void)checkEvaluateDataWithCallback {
    self.viewModel.rate = @"";
    self.viewModel.isResolved = @"";
    [self.viewModel checkEvaluateDataWithCallback:^(BOOL successful, NSString *tips) {
        XCTAssertFalse(successful);
    }];
}

- (void)testcheckEvaluateDataWithCallback1 {
    self.viewModel.rate = @"评分";
    self.viewModel.isResolved = @"";
    [self.viewModel checkEvaluateDataWithCallback:^(BOOL successful, NSString *tips) {
        XCTAssertFalse(successful);
    }];
}

- (void)testcheckEvaluateDataWithCallback2 {
    self.viewModel.rate = @"";
    self.viewModel.isResolved = @"解决问题";
    [self.viewModel checkEvaluateDataWithCallback:^(BOOL successful, NSString *tips) {
        XCTAssertFalse(successful);
    }];
}

- (void)testcheckEvaluateDataWithCallback3 {
    self.viewModel.rate = @"已评分";
    self.viewModel.isResolved = @"解决问题";
    [self.viewModel checkEvaluateDataWithCallback:^(BOOL successful, NSString *tips) {
        XCTAssertFalse(successful);
    }];
}

//图片上传
- (void)testuploadConsultationImagesCompleted {
    
//    XCTestExpectation *exceptions =  [self expectationWithDescription:@"测试上传图片"];
    self.viewModel.consultaionImage = IMAGE_NAMED(@"朋友圈图片");
    [self.viewModel uploadConsultationImagesCompleted:^(BOOL successful, NSString *tips) {
        XCTAssertTrue(successful);
//        [exceptions fulfill];
    }];
    // 设置等待时间2 超过性能不佳
//    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
//        NSLog(@"%@", error);
//    }];
}

     
- (void)testuploadConsultationImagesCompleted1 {
//    XCTestExpectation *exceptions =  [self expectationWithDescription:@"测试上传图片1"];
    self.viewModel.consultaionImage = IMAGE_NAMED(@"");
    [self.viewModel uploadConsultationImagesCompleted:^(BOOL successful, NSString *tips) {
        XCTAssertFalse(successful);
//        [exceptions fulfill];
    }];
//    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
//        NSLog(@"%@",error);
//    }];
}

- (void)testrequestAddEvaluateCompleted {
    
    [self.viewModel requestAddEvaluateCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)testrequestAddConsultationCompleted {
    [self.viewModel requestAddConsultationCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)testrequestAddLawyerConsultationCompleted {
    
    [self.viewModel requestAddLawyerConsultationCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)testdeleteConsultationCompleted {
    
    [self.viewModel deleteConsultationCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)testcancelConsultationCompleted {
    
    [self.viewModel cancelConsultationCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
        
    }];
}

- (void)testrefreshMyAdviceCompleted {
    [self.viewModel refreshMyAdviceCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)testloadMyAdviceCompleted {
    
    [self.viewModel loadMyAdviceCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)testrefreshMyAdviceDetailsCompleted {
    [self.viewModel refreshMyAdviceDetailsCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)testgetChatUsernameCompleted {
    
    [self.viewModel getChatUsernameCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)testrequestCommentsCompleted {
    
    [self.viewModel requestCommentsCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)testcheckDataWithCallback {
    self.viewModel.reward = @"0";
    self.viewModel.agreeProtocol = NO;
    [self.viewModel checkDataWithCallback:^(BOOL successful, NSString *tips) {
        XCTAssertFalse(successful);
    }];
}

- (void)testcheckDataWithCallback1 {
    self.viewModel.reward = @"1";
    self.viewModel.agreeProtocol = NO;
    [self.viewModel checkDataWithCallback:^(BOOL successful, NSString *tips) {
        XCTAssertFalse(successful);
    }];
}

- (void)testcheckDataWithCallback2 {
    self.viewModel.reward = @"1";
    self.viewModel.agreeProtocol = YES;
    [self.viewModel checkDataWithCallback:^(BOOL successful, NSString *tips) {
        XCTAssertTrue(successful);
    }];
}

- (void)testGETProcessedCompleted {
    [self.viewModel GETProcessedCompleted:@"id" :^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
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
