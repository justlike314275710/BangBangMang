//
//  IMManager.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/6/5.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "IMManager.h"
#import "NTESCellLayoutConfig.h"
#import "NTESAttachmentDecoder.h"
#import "ZQLocalNotification.h"
#import "XXAlertView.h"
@interface IMManager()<NIMLoginManagerDelegate,NIMChatManagerDelegate,NIMSystemNotificationManagerDelegate,NIMNetCallManagerDelegate>
//@interface IMManager()
@property (nonatomic, strong) NIMSession *session;
@end

@implementation IMManager

SINGLETON_FOR_CLASS(IMManager);

#pragma mark ————— 初始化IM —————
-(void)initIM{
    //在注册 NIMSDK appKey 之前先进行配置信息的注册，如是否使用新路径,是否要忽略某些通知，是否需要多端同步未读数
//    self.sdkConfigDelegate = [[NTESSDKConfigDelegate alloc] init];
//    [[NIMSDKConfig sharedConfig] setDelegate:self.sdkConfigDelegate];
    
    [[NIMSDKConfig sharedConfig] setShouldSyncUnreadCount:YES];
    [[NIMSDKConfig sharedConfig] setMaxAutoLoginRetryTimes:10];

    [[[NIMSDK sharedSDK] loginManager] addDelegate:self];
    [[[NIMSDK sharedSDK] chatManager] addDelegate:self];
    [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
    [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
    
    //注入 NIMKit 布局管理器
    [[NIMKit sharedKit] registerLayoutConfig:[NTESCellLayoutConfig new]];

    [[NIMSDK sharedSDK] registerWithAppID:kIMAppKey
                                  cerName:kIMPushCerName];
}

#pragma mark ————— IM登录 —————
-(void)IMLogin:(NSString *)IMID IMPwd:(NSString *)IMPwd completion:(loginBlock)completion{
    
    [[[NIMSDK sharedSDK] loginManager] login:IMID token:IMPwd completion:^(NSError * _Nullable error) {
        if (!error) {
            if (completion) {
                completion(YES,nil);
                //未读消息
                NSInteger messageCount = [NIMSDK sharedSDK].conversationManager.allUnreadCount;
                if (messageCount>0) {
                    [kAppDelegate.mainTabBar setRedDotWithIndex:1 isShow:YES];
                } else {
                    [kAppDelegate.mainTabBar setRedDotWithIndex:1 isShow:NO];
                }
                //系统未读消息数
                NSInteger systemCount = [[[NIMSDK sharedSDK] systemNotificationManager] allUnreadCount];
                if (systemCount>0) {
                    [kAppDelegate.mainTabBar setRedDotWithIndex:3 isShow:YES];
                } else {
                    [kAppDelegate.mainTabBar setRedDotWithIndex:3 isShow:NO];
                }
            }
        }else{
            if (completion) {
                completion(NO,error.localizedDescription);
            }
        }
    }];
}
#pragma mark ————— IM退出 —————
-(void)IMLogout{
    [[[NIMSDK sharedSDK] loginManager] logout:^(NSError * _Nullable error) {
        if (!error) {
            DLog("IM 退出成功");
        }else{
            DLog("IM 退出失败 %@",error.localizedDescription);
        }
    }];
}

-(void)onKick:(NIMKickReason)code clientType:(NIMLoginClientType)clientType
{
    NSString *reason = @"你被踢下线";
    switch (code) {
            case NIMKickReasonByClient:
            case NIMKickReasonByClientManually:{
                reason = @"你的帐号被踢出下线，请注意帐号信息安全";
                NSString*determine=NSLocalizedString(@"determine", @"确定");
                NSString*Tips=NSLocalizedString(@"Tips", @"提示");
                NSString*pushed_off_line=NSLocalizedString(@"pushed_off_line", @"您的账号已在其他设备登陆,已被挤下线");
                XXAlertView*alert=[[XXAlertView alloc]initWithTitle:Tips message:pushed_off_line sureBtn:determine cancleBtn:nil];
                alert.clickIndex = ^(NSInteger index) {
                    if (index==2) {
                        [help_userManager logout:nil];
                    }
                };
                [alert show];
                break;
            }
            case NIMKickReasonByServer:
            reason = @"你被服务器踢下线";
            break;
        default:
            break;
    }
    KPostNotification(KNotificationOnKick, nil);
}

#pragma mark ————— 代理 收到新消息 —————
- (void)onRecvMessages:(NSArray<NIMMessage *> *)messages{
    DLog(@"收到新消息");
    NIMMessage *meeesage = [messages objectAtIndex:1];
    NSString *msg = meeesage.text;
    [ZQLocalNotification NotificationType:CountdownNotification Identifier:@"0" activityId:1900001 alertBody:msg alertTitle:@"帮帮忙" alertString:@"确定" withTimeDay:0 hour:0 minute:0 second:1];
    
    //未读消息
    NSInteger systemCount = [NIMSDK sharedSDK].conversationManager.allUnreadCount;
    if (systemCount>0) {
        [kAppDelegate.mainTabBar setRedDotWithIndex:1 isShow:YES];
    } else {
        [kAppDelegate.mainTabBar setRedDotWithIndex:1 isShow:NO];
    }
}


-(void)onReceiveCustomSystemNotification:(NIMCustomSystemNotification *)notification{
    NSData *jsonData = [notification.content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if ([dic[@"type"] isEqualToString:@"RUSH_PAGE_REFRESH"]) {
        KPostNotification(@"RUSH_PAGE_REFRESH", nil);
        EBBannerView *banner = [EBBannerView bannerWithBlock:^(EBBannerViewMaker *make) {
            make.style = 11;
            make.content = @"您有一笔新的订单!";

        }];
        [banner show];
        [ZQLocalNotification NotificationType:CountdownNotification Identifier:@"1" activityId:1900000 alertBody:@"您有一笔新的订单!" alertTitle:@"帮帮忙" alertString:@"确定" withTimeDay:0 hour:0 minute:0 second:1];

    }
    else if ([dic[@"type"] isEqualToString:@"NOTIFICATION_LEGAL_ADVICE"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationOrderStateChange object:nil];
        EBBannerView *banner = [EBBannerView bannerWithBlock:^(EBBannerViewMaker *make) {
            make.style = 11;
            make.content = dic[@"content"];
        }];
        [banner show];
        [ZQLocalNotification NotificationType:CountdownNotification Identifier:@"2" activityId:1900000 alertBody: dic[@"content"] alertTitle:@"帮帮忙" alertString:@"确定" withTimeDay:0 hour:0 minute:0 second:1];
    }
    else if ([dic[@"type"] isEqualToString:@"NOTIFICATION_PRAISE_ADVICE"]||[dic[@"type"] isEqualToString:@"NOTIFICATION_COMMENT_ADVICE"]){  //评论点赞
        KPostNotification(KNotificationMineRefreshDot, @"1");
        EBBannerView *banner = [EBBannerView bannerWithBlock:^(EBBannerViewMaker *make) {
            make.style = 11;
            make.content = dic[@"content"];
        }];
        [banner show]; //NOTIFICATION_PRAISE_ADVICE
        [ZQLocalNotification NotificationType:CountdownNotification Identifier:@"3" activityId:1900000 alertBody:dic[@"content"] alertTitle:@"帮帮忙" alertString:@"确定" withTimeDay:0 hour:0 minute:0 second:1];
        
    }
    else {
        EBBannerView *banner = [EBBannerView bannerWithBlock:^(EBBannerViewMaker *make) {
            make.style = 11;
            make.content = dic[@"content"];
        }];
        [banner show];
        [ZQLocalNotification NotificationType:CountdownNotification Identifier:@"4" activityId:1900000 alertBody:dic[@"content"] alertTitle:@"帮帮忙" alertString:@"确定" withTimeDay:0 hour:0 minute:0 second:1];
        if (ValidStr(dic[@"content"])) {
            NSString *content = dic[@"content"];
            if ([content containsString:@"您的律师认证审核已通过"]) {
                help_userManager.userStatus =  CERTIFIED;
                KPostNotification(KNotificationMineDataChange, nil);
            }
        }
    }
}






+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
    options:NSJSONReadingMutableContainers
    error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}




@end
