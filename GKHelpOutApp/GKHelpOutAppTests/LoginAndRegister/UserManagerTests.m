//
//  UserManagerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/22.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserManager.h"

@interface UserManagerTests : XCTestCase
@property (nonatomic,strong)UserManager *userManager;

@end

@implementation UserManagerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.userManager = [UserManager sharedUserManager];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.userManager = nil;
}
//验收手机号码是否被注册
- (void)testRequestEcomRegister {
    
    NSDictionary*parmeters=@{
                             @"phoneNumber":@"15525477756",
                             @"verificationCode":@"1234",
                             @"name":@"15525477756",//姓名是手机号码
                             @"group":@"CUSTOMER"
                             };
    BOOL result =  [self.userManager requestEcomRegister:parmeters];
    XCTAssertFalse(result);
}

- (void)testJudgeIdentityCallback {
    [self.userManager JudgeIdentityCallback:^(BOOL success, NSString *des) {
        XCTAssertTrue(success);
    }];
}

- (void)testloginToServer {
    NSString *refresh_token = self.userManager.oathInfo.refresh_token?self.userManager.oathInfo.refresh_token:@"";
    NSDictionary*parmeters=@{
                             @"refresh_token":refresh_token,
                             @"grant_type":@"refresh_token"
                             };
    [self.userManager loginToServer:parmeters refresh:YES  completion:^(BOOL success, NSString *des) {
        XCTAssertTrue(success);
    }];
}

- (void)testNologinToServer {
    
    NSDictionary*parmeters=@{
                             @"phoneNumber":@"15525477756",
                             @"verificationCode":@"1234",
                             @"name":@"15525477756",//姓名是手机号码
                             @"group":@"CUSTOMER"
                             };
    [self.userManager loginToServer:parmeters refresh:NO completion:^(BOOL success, NSString *des) {
        XCTAssertTrue(success);
    }];
}
//自动登录
- (void)testAutoLoginToServer {
    [self.userManager autoLoginToServer:^(BOOL success, NSString *des) {
        XCTAssertTrue(success);
    }];
}
//退出登录
- (void)testlogout {
    [self.userManager logout:^(BOOL success, NSString *des) {
        XCTAssertTrue(success);
    }];
}
//加载缓存数据
- (void)testloadUserInfo{
    BOOL result = [self.userManager loadUserInfo];
    XCTAssertFalse(result);
}

- (void)testloadUserOuathInfo {
    BOOL result = [self.userManager loadUserOuathInfo];
    XCTAssertFalse(result);
}


-(void)testsaveUserInfo {
    [self.userManager saveUserInfo];
    XCTAssertNil(self.userManager.curUserInfo);
}

-(void)testsaveLawUserInfo {
    [self.userManager saveLawUserInfo];
    XCTAssertNil(self.userManager.lawUserInfo);
}
-(void)testloadLawUserInfo {
    BOOL result = [self.userManager loadUserOuathInfo];
    XCTAssertFalse(result);
}

-(void)testsaveUserState {
    [self.userManager saveUserState];
    XCTAssertLessThan(self.userManager.userStatus,4);
    
}
-(void)testloadUserState {
    BOOL result = [self.userManager loadUserState];
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
