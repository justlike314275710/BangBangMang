//
//  PubOauthModel.h
//  GKHelpOutApp
//
//  Created by kky on 2019/2/20.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OauthInfo: NSObject

@property (nonatomic,copy) NSString *tenant;
@property (nonatomic,copy) NSString *jti;
@property (nonatomic,copy) NSString *token_type;
@property (nonatomic,copy) NSString *scope;
@property (nonatomic,copy) NSString *refresh_token;  //刷新token
@property (nonatomic,copy) NSString *group;
@property (nonatomic,copy) NSString *access_token;   
@property (nonatomic,copy) NSString *expires_in;




@end


