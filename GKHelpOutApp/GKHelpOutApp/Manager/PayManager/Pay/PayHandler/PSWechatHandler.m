//
//  PSWechatHandler.m
//  Start
//
//  Created by calvin on 16/7/18.
//  Copyright © 2016年 DingSNS. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import "PSWechatHandler.h"
#import "WXApi.h"
#import "PSWechatInfo.h"
//#import "PSWechatPayRequest.h"
//#import "PSRemittanceBusinessRequest.h"
//#import "PSBusinessConstants.h"

@interface PSWechatHandler ()

@property (nonatomic, strong) PSPayInfo *payInfo;
//@property (nonatomic, strong) PSWechatPayRequest *wechatPayRequest;
//@property (nonatomic, strong) PSRemittanceBusinessRequest *remittanceBusinessRequest;
@property (nonatomic, strong) PSWechatInfo *wechatInfo;

@end

@implementation PSWechatHandler
{
    AFHTTPSessionManager *manager;
    
}
@synthesize payCallback;
- (void)dealloc {
    
}

- (void)goPayWithPayInfo:(PSPayInfo *)payInfo {
    self.payInfo = payInfo;
    [self goPay];
}
//法律咨询支付
- (void)goOrderWithPayInfo:(PSPayInfo *)payInfo{
    self.payInfo=payInfo;
    [self goOrderPay];
}
//汇款
- (void)goRemittanceWithPayInfo:(PSPayInfo *)payInfo {
    self.payInfo = payInfo;
    [self goRemittance];
}


-(void)goOrderPay{
    manager=[AFHTTPSessionManager manager];
    NSString*token=help_userManager.oathInfo.access_token;
    NSString *url = [NSString stringWithFormat:@"%@/legal-advice/%@/we-chat-pay",ConsultationHostUrl,self.payInfo.productID];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode==200) {
            if (responseObject) {
                self.wechatInfo=[PSWechatInfo new];
                self.wechatInfo.appid=responseObject[@"appId"];
                self.wechatInfo.noncestr=responseObject[@"nonce"];
                self.wechatInfo.prepayid=responseObject[@"prepayId"];
                self.wechatInfo.sign=responseObject[@"sign"];
                self.wechatInfo.timestamp=responseObject[@"timestamp"];
                self.wechatInfo.packageName=responseObject[@"extension"];
                self.wechatInfo.partnerid=responseObject[@"merchantId"];
                [self wechatPay];
            }
            else{
                if (self.payCallback) {
                    self.payCallback(NO, [NSError errorWithDomain:@"微信支付接口数据异常" code:101 userInfo:nil]);
                }
            }
        } else {
            if (self.payCallback) {
                self.payCallback(NO, [NSError errorWithDomain: @"微信支付接口异常" code:102 userInfo:nil]);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.payCallback) {
            self.payCallback(NO, [NSError errorWithDomain:@"微信支付接口超时" code:103 userInfo:nil]);
        }
    }];
    
}

- (void)goRemittance {
    /*
    self.remittanceBusinessRequest = [PSRemittanceBusinessRequest new];
    self.remittanceBusinessRequest.jailId = self.payInfo.jailId;
    self.remittanceBusinessRequest.familyId = self.payInfo.familyId;
    self.remittanceBusinessRequest.prisonerId = self.payInfo.prisonerId;
    self.remittanceBusinessRequest.remitType = [self.payInfo.payment isEqualToString:@"WEIXIN"]?@"1":@"0";
    self.remittanceBusinessRequest.money = self.payInfo.money;
    @weakify(self)
    [self.remittanceBusinessRequest send:^(PSRequest *request, PSResponse *response) {
        @strongify(self)
        if (response.code == 200) {
            PSWechatPayResponse *payResponse = (PSWechatPayResponse *)response;
            if (payResponse.data) {
                self.wechatInfo = payResponse.data;
                [self wechatPay];
            }else{
                if (self.payCallback) {
                    self.payCallback(NO, [NSError errorWithDomain:@"微信支付接口数据异常" code:101 userInfo:nil]);
                }
            }
        }else{
            if (self.payCallback) {
                self.payCallback(NO, [NSError errorWithDomain:response.msg ? response.msg : @"微信支付接口异常" code:102 userInfo:nil]);
            }
        }
    } errorCallback:^(PSRequest *request, NSError *error) {
        @strongify(self)
        if (self.payCallback) {
            self.payCallback(NO, [NSError errorWithDomain:@"微信支付接口超时" code:103 userInfo:nil]);
        }
    }];
     */
}

- (void)goPurchase {
    /*
    self.wechatPayRequest = [PSWechatPayRequest new];
    self.wechatPayRequest.jailId = self.payInfo.jailId;
    self.wechatPayRequest.familyId = self.payInfo.familyId;
    self.wechatPayRequest.itemName = self.payInfo.productName;
    self.wechatPayRequest.amount = self.payInfo.amount;
    self.wechatPayRequest.num = self.payInfo.quantity;
    self.wechatPayRequest.itemId = self.payInfo.productID;
    @weakify(self)
    [self.wechatPayRequest send:^(PSRequest *request, PSResponse *response) {
        @strongify(self)
        if (response.code == 200) {
            PSWechatPayResponse *payResponse = (PSWechatPayResponse *)response;
            if (payResponse.data) {
                self.wechatInfo = payResponse.data;
                [self wechatPay];
            }else{
                if (self.payCallback) {
                    self.payCallback(NO, [NSError errorWithDomain:@"微信支付接口数据异常" code:101 userInfo:nil]);
                }
            }
        }else{
            if (self.payCallback) {
                self.payCallback(NO, [NSError errorWithDomain:response.msg ? response.msg : @"微信支付接口异常" code:102 userInfo:nil]);
            }
        }
    } errorCallback:^(PSRequest *request, NSError *error) {
        @strongify(self)
        if (self.payCallback) {
            self.payCallback(NO, [NSError errorWithDomain:@"微信支付接口超时" code:103 userInfo:nil]);
        }
    }];
     */
}

#pragma mark - 调用微信支付
- (void)wechatPay {
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = self.wechatInfo.partnerid;
    request.prepayId = self.wechatInfo.prepayid;
    request.package = self.wechatInfo.packageName;
    request.nonceStr = self.wechatInfo.noncestr;
    request.timeStamp = [self.wechatInfo.timestamp intValue];
    request.sign = self.wechatInfo.sign;
    [WXApi sendReq:request];
    
}



- (void)goPay {
    [self goPurchase];
}

@end
