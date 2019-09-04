//
//  lawyerGrab_LogicTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/9/3.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "lawyerGrab_Logic.h"

@interface lawyerGrab_LogicTests : XCTestCase
@property(nonatomic,strong)lawyerGrab_Logic *logic;
@end

@implementation lawyerGrab_LogicTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.logic = [[lawyerGrab_Logic alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.logic = nil;
}

- (void)testrefreshAdviceProcessingCompleted {
    [self.logic refreshAdviceProcessingCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}



- (void)testrefreshLawyerAdviceCompleted {
    [self.logic refreshLawyerAdviceCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)testloadLawyerAdviceCompleted {
    [self.logic loadLawyerAdviceCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
- (void)testPOSTLawyergrabCompleted {
    [self.logic POSTLawyergrabCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}



- (void)testrefreshMygrabCompleted {
    [self.logic refreshMygrabCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
- (void)testloadMygrabCompleted {
    [self.logic loadMygrabCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
-(void)testGETMygrabCompleted {
    _logic.rate = @"";
    [self.logic GETMygrabCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

-(void)testGETMygrabCompleted1 {
    self.logic.isResolved=@"";
    [self.logic GETMygrabCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

-(void)testGETMygrabCompleted2 {
    self.logic.rate = @"";
    self.logic.isResolved=@"1";
    [self.logic GETMygrabCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}
    

- (void)testcheckEvaluateDataWithCallback {
    [self.logic checkEvaluateDataWithCallback:^(BOOL successful, NSString *tips) {
        
    }];
}

- (void)testGETLawyerDetailsCompleted {
    [self.logic GETLawyerDetailsCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

-(void)testGETLawyerDetailsCompleted1 {
    [self.logic GETLawyerDetailsCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

-(void)testrequestCommentsCompleted{
    [self.logic requestCommentsCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}

-(void)testGETProcessedCompleted {
    [self.logic GETProcessedCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}


-(void)testdeleteConsultationCompleted{
    [self.logic deleteConsultationCompleted:^(id data) {
        
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
