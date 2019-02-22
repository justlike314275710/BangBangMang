//
//  PSAliHandler.m
//  Start
//
//  Created by Glen on 17/3/8.
//  Copyright © 2017年 DingSNS. All rights reserved.
//

#import "PSAliHandler.h"
//#import "PSAlipayRequest.h"
//#import "PSBusinessConstants.h"
#import <AlipaySDK/AlipaySDK.h>
//#import "PSRemittanceBusinessRequest.h"
#import <AFNetworking/AFNetworking.h>
#import"PSAlipayInfo.h"
@interface PSAliHandler ()

@property (nonatomic, strong) PSPayInfo *payInfo;
//@property (nonatomic, strong) PSAlipayRequest *alipayRequest;
@property (nonatomic, strong) PSAlipayInfo *alipayInfo;
//@property (nonatomic, strong) PSRemittanceBusinessRequest *remittanceBusinessRequest;

@end

@implementation PSAliHandler{
    AFHTTPSessionManager *manager;
}
@synthesize payCallback;

- (void)dealloc {
    
}

- (void)goPayWithPayInfo:(PSPayInfo *)payInfo {
    self.payInfo = payInfo;
    [self goPay];
}

- (void)goRemittanceWithPayInfo:(PSPayInfo *)payInfo {
    self.payInfo = payInfo;
    [self goRemittance];
}

-(void)goOrderWithPayInfo:(PSPayInfo *)payInfo{
    self.payInfo=payInfo;
    [self goOrderPay];
}

-(void)goOrderPay{
    NSLog(@"支付宝支付");
    manager=[AFHTTPSessionManager manager];
    NSString*token=help_userManager.oathInfo.access_token;
    NSString *url = [NSString stringWithFormat:@"%@/legal-advice/%@/alipay",ConsultationHostUrl,self.payInfo.productID];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"***%@",responseObject);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode==200) {
            if (responseObject) {
                self.alipayInfo=[PSAlipayInfo new];
                self.alipayInfo.response = responseObject[@"body"];
                NSLog(@"---%@",responseObject[@"body"]);
                [self goAliPay];
            }
            else{
                if (self.payCallback) {
                    self.payCallback(NO, [NSError errorWithDomain:@"支付宝支付接口数据异常" code:101 userInfo:nil]);
                }
            }
        } else {
            if (self.payCallback) {
                self.payCallback(NO, [NSError errorWithDomain: @"支付宝支付接口异常" code:102 userInfo:nil]);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.payCallback) {
            self.payCallback(NO, [NSError errorWithDomain:@"支付宝支付接口超时" code:103 userInfo:nil]);
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
            PSAlipayResponse *payResponse = (PSAlipayResponse *)response;
            if (payResponse.data) {
                self.alipayInfo = payResponse.data;
                [self goAliPay];
            }else{
                if (self.payCallback) {
                    self.payCallback(NO, [NSError errorWithDomain:@"支付宝支付接口数据异常" code:201 userInfo:nil]);
                }
            }
        }else{
            if (self.payCallback) {
                self.payCallback(NO, [NSError errorWithDomain:response.msg ? response.msg : @"支付宝支付接口异常" code:202 userInfo:nil]);
            }
        }
    } errorCallback:^(PSRequest *request, NSError *error) {
        @strongify(self)
        if (self.payCallback) {
            self.payCallback(NO, [NSError errorWithDomain:@"支付宝支付接口超时" code:203 userInfo:nil]);
        }
    }];
     */
}

//汇款
- (void)goRemittancePayInfo:(PSPayInfo *)payInfo {
    self.payInfo = payInfo;
}

- (void)goPay {
    [self goPurchase];
}

- (void)goPurchase {
    /*
    self.alipayRequest = [PSAlipayRequest new];
    self.alipayRequest.jailId = self.payInfo.jailId;
    self.alipayRequest.familyId = self.payInfo.familyId;
    self.alipayRequest.itemName = self.payInfo.productName;
    self.alipayRequest.amount = self.payInfo.amount;
    self.alipayRequest.num = self.payInfo.quantity;
    self.alipayRequest.itemId = self.payInfo.productID;
    @weakify(self)
    [self.alipayRequest send:^(PSRequest *request, PSResponse *response) {
        @strongify(self)
        if (response.code == 200) {
            PSAlipayResponse *payResponse = (PSAlipayResponse *)response;
            if (payResponse.data) {
                self.alipayInfo = payResponse.data;
                [self goAliPay];
            }else{
                if (self.payCallback) {
                    self.payCallback(NO, [NSError errorWithDomain:@"支付宝支付接口数据异常" code:201 userInfo:nil]);
                }
            }
        }else{
            if (self.payCallback) {
                self.payCallback(NO, [NSError errorWithDomain:response.msg ? response.msg : @"支付宝支付接口异常" code:202 userInfo:nil]);
            }
        }
    } errorCallback:^(PSRequest *request, NSError *error) {
        @strongify(self)
        if (self.payCallback) {
            self.payCallback(NO, [NSError errorWithDomain:@"支付宝支付接口超时" code:203 userInfo:nil]);
        }
    }];
     */
}

- (void)goAliPay {
    @weakify(self)
    [[AlipaySDK defaultService] payOrder:self.alipayInfo.response fromScheme:AppScheme callback:^(NSDictionary *resultDic) {
        @strongify(self)
        [self handleAlipayResult:resultDic];
    }];
}

- (void)handleAlipayResult:(NSDictionary *)resultDic {
    NSInteger status = [resultDic[@"resultStatus"] integerValue];
    switch (status) {
        case 9000:
        {
            //支付成功
            if (self.payCallback) {
                self.payCallback(YES,nil);
            }
        }
            break;
        case 6001:
        {
            //用户取消
            NSError *error = [NSError errorWithDomain:@"取消支付" code:204 userInfo:nil];
            if (self.payCallback) {
                self.payCallback(NO,error);
            }
        }
            break;
        default:
        {
            NSError *error = [NSError errorWithDomain:resultDic[@"memo"] ? resultDic[@"memo"] : @"支付失败" code:205 userInfo:nil];
            if (self.payCallback) {
                self.payCallback(NO,error);
            }
        }
            break;
    }
}

@end
