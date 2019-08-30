//
//  IMManagerTests.m
//  GKHelpOutAppTests
//
//  Created by kky on 2019/8/28.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IMManager.h"
#import "IMManager+tests.h"
#import <OCMock/OCMock.h>

@interface IMManagerTests : XCTestCase
@property(nonatomic,strong)IMManager *immanager;

@end

@implementation IMManagerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.immanager = [IMManager sharedIMManager];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.immanager = nil;
}

- (void)testonKick {
    [self.immanager onKick:NIMKickReasonByServer clientType:NIMLoginClientTypeiOS];
}
- (void)testonKick1 {
    [self.immanager onKick:NIMKickReasonByClientManually clientType:NIMLoginClientTypeiOS];
}

- (void)testonRecvMessages {
    
    NSMutableArray<NIMMessage *> *messages = [NSMutableArray array];
//    id nimMessageMock = OCMClassMock([NIMMessage class]);
//    OCMStub([nimMessageMock setter]).andReturn(@"测试收到消息");
//    [messages addObject:nimMessageMock];
    NIMMessage *message = [NIMMessage new];
    message.text = @"收到新消息";
    [messages addObject:message];
    
    [self.immanager onRecvMessages:messages];
}
- (void)testonReceiveCustomSystemNotification {
    NIMCustomSystemNotification *nimCustomSysNotice = [[NIMCustomSystemNotification alloc] init];
    NSDictionary *content = @{@"type":@"RUSH_PAGE_REFRESH"};
    NSString *contentString = [NSString convertToJsonData:content];
//    nimCustomSysNotice.content = contentString;
    [nimCustomSysNotice setValue:contentString forKey:@"content"];
  //RUSH_PAGE_REFRESH //NOTIFICATION_LEGAL_ADVICE //NOTIFICATION_PRAISE_ADVICE
    [self.immanager onReceiveCustomSystemNotification:nimCustomSysNotice];
 

}

- (void)testonReceiveCustomSystemNotification1 {
    NIMCustomSystemNotification *nimCustomSysNotice = [[NIMCustomSystemNotification alloc] init];
    NSDictionary *content = @{@"type":@"NOTIFICATION_LEGAL_ADVICE"};
    NSString *contentString = [NSString convertToJsonData:content];
    [nimCustomSysNotice setValue:contentString forKey:@"content"];
    [self.immanager onReceiveCustomSystemNotification:nimCustomSysNotice];
}
- (void)testonReceiveCustomSystemNotification2 {
    NIMCustomSystemNotification *nimCustomSysNotice = [[NIMCustomSystemNotification alloc] init];
    NSDictionary *content = @{@"type":@"NOTIFICATION_PRAISE_ADVICE"};
    NSString *contentString = [NSString convertToJsonData:content];
    [nimCustomSysNotice setValue:contentString forKey:@"content"];
    [self.immanager onReceiveCustomSystemNotification:nimCustomSysNotice];
}

- (void)testonReceiveCustomSystemNotification3 {
    NIMCustomSystemNotification *nimCustomSysNotice = [[NIMCustomSystemNotification alloc] init];
    NSDictionary *content = @{@"type":@"other"};
    NSString *contentString = [NSString convertToJsonData:content];
    [nimCustomSysNotice setValue:contentString forKey:@"content"];
    [self.immanager onReceiveCustomSystemNotification:nimCustomSysNotice];
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
