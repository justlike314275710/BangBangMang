//
//  PSPayManager.m
//  Start
//
//  Created by calvin on 16/7/12.
//  Copyright © 2016年 DingSNS. All rights reserved.
//

#import "PSPayCenter.h"
#import "PSWechatHandler.h"
#import "PSAliHandler.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@interface PSPayCenter () <WXApiDelegate>

@property (nonatomic, strong) PSPayInfo *payInfo;
@property (nonatomic, assign) BOOL didHandleWechatURL;
@property (nonatomic, assign) BOOL didHandleAliURL;
@property (nonatomic, strong) id<PSPayHandler> payHandler;

@end

@implementation PSPayCenter

+ (PSPayCenter *)payCenter {
    static PSPayCenter *payCenter = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken,^{
        if (!payCenter) {
            payCenter = [[self alloc] init];
        }
    });
    return payCenter;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)goPayWithPayInfo:(PSPayInfo *)payInfo type:(PayType)type  callback:(PSPayCallback)callback {
    self.payCallback = callback;
    self.payInfo = payInfo;
    //判断微信是否安装
    if ([self.payInfo.payment isEqualToString:@"WEIXIN"]) {
        BOOL Installed = [WXApi isWXAppInstalled];
        if (!Installed) {
            if (self.payCallback) {
                NSString *error_msg = NSLocalizedString(@"weChat not installed", @"微信未安装");
                NSError *error = [NSError errorWithDomain:error_msg code:102 userInfo:nil];
                self.payCallback(NO,error);
                return;
            }
        }
    }
    self.payHandler = [self buildPayHandlerWith:payInfo];
    if (self.payHandler) {
        @weakify(self)
        [self.payHandler setPayCallback:^(BOOL result, NSError *error){
            @strongify(self)
            [self removeEnterForegroundNotification];
            if (self.payCallback) {
                self.payCallback(result,error);
            }
        }];
        #warning TODO 支付汇款
        if (type == PayTypeOrd) { //汇款
            [self.payHandler goOrderWithPayInfo:payInfo];
            //[self.payHandler goRemittanceWithPayInfo:payInfo];
        } else {
            [self.payHandler goPayWithPayInfo:payInfo];
        }
    }else{
        if (self.payCallback) {
            NSError *error = [NSError errorWithDomain:@"不支持的支付方式！" code:101 userInfo:nil];
            self.payCallback(NO,error);
        }
    }
}



- (id<PSPayHandler>)buildPayHandlerWith:(PSPayInfo *)payInfo {
    id<PSPayHandler> handler = nil;
    if ([payInfo.payment isEqualToString:@"WEIXIN"]) {
        [self registerEnterForegroundNotification];
        PSWechatHandler *wechatHandler = [[PSWechatHandler alloc] init];
        handler = wechatHandler;
    }else if ([payInfo.payment isEqualToString:@"ALIPAY"]) {
        [self registerEnterForegroundNotification];
        PSAliHandler *aliHandler = [[PSAliHandler alloc] init];
        handler = aliHandler;
    }
    return handler;
}

#pragma mark - 微信支付
- (void)registerEnterForegroundNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleAppEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void)removeEnterForegroundNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];
}

- (void)handleWechatURLProcess {
    [self removeEnterForegroundNotification];
    if (_didHandleWechatURL) {
        _didHandleWechatURL = NO;
    }else {
        //此情况可能是跳转至微信后，用户没有支付，点击左上角的按钮直接返回APP，或者用户支付成功后留在微信，再点击左上角按钮返回APP而没有执行相应的回调
        NSError *error = [NSError errorWithDomain:@"未知支付结果" code:106 userInfo:nil];
        if (self.payCallback) {
            self.payCallback(NO,error);
        }
    }
}

- (void)handleAliUrlProcess {
    [self removeEnterForegroundNotification];
    if (_didHandleAliURL) {
        _didHandleAliURL = NO;
    }else {
        NSError *error = [NSError errorWithDomain:@"未知支付结果" code:206 userInfo:nil];
        if (self.payCallback) {
            self.payCallback(NO,error);
        }
    }
}

- (void)handleAppEnterForeground:(NSNotification *)notification {
    if ([self.payInfo.payment isEqualToString:@"WEIXIN"]) {
        [self performSelector:@selector(handleWechatURLProcess) withObject:nil afterDelay:0.5];
    }else if ([self.payInfo.payment isEqualToString:@"ALIPAY"]) {
        [self performSelector:@selector(handleAliUrlProcess) withObject:nil afterDelay:0.5];
    }
}

- (void)handleWeChatURL:(NSURL *)url {
    _didHandleWechatURL = YES;
    [WXApi handleOpenURL:url delegate:self];
}

- (void)handleAliURL:(NSURL *)url {
    _didHandleAliURL = YES;
    @weakify(self);
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        //处理钱包或者独立快捷app支付跳回商户app携带的支付结果
        @strongify(self);
        NSInteger status = [resultDic[@"resultStatus"] integerValue];
        NSLog(@"***支付宝支付结果**%ld",(long)status);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"aliPayResult" object:nil userInfo:resultDic];
        switch (status) {
            case 9000:
            {
                NSLog(@"支付成功");
                //支付成功
                if (self.payCallback) {
                    self.payCallback(YES,nil);
                }
            }
                break;
            case 6001:
            {
                 NSLog(@"用户取消");
                //用户取消
                NSError *error = [NSError errorWithDomain:@"取消支付" code:204 userInfo:nil];
                if (self.payCallback) {
                    self.payCallback(NO,error);
                }
            }
                break;
            default:
            {
                NSLog(@"支付失败");
                NSError *error = [NSError errorWithDomain:resultDic[@"memo"] ? resultDic[@"memo"] : @"支付失败" code:205 userInfo:nil];
                if (self.payCallback) {
                    self.payCallback(NO,error);
                }
            }
                break;
        }
    }];
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp*)resp{
    [self removeEnterForegroundNotification];
    
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        NSLog(@"**微信支付结果***%d",response.errCode);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"wxPayResult" object:nil userInfo:@{@"errCode":[NSNumber numberWithInt: response.errCode]}];
        switch (response.errCode) {
            case WXSuccess:
            {
                if (self.payCallback) {
                    self.payCallback(YES,nil);
                }
            }
                break;
            case WXErrCodeUserCancel:
            {
                NSError *error = [NSError errorWithDomain:@"取消支付" code:104 userInfo:nil];
                if (self.payCallback) {
                    self.payCallback(NO,error);
                }
            }
                break;
            default:
            {
                NSError *error = [NSError errorWithDomain:response.errStr ? response.errStr : @"支付失败" code:105 userInfo:nil];
                if (self.payCallback) {
                    self.payCallback(NO,error);
                }
            }
                break;
        }
    }
    
}



@end
