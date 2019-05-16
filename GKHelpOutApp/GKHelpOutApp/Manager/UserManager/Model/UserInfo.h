//
//  UserInfo.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/23.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameInfo;

typedef NS_ENUM(NSInteger,UserGender){
    UserGenderUnKnow = 0,
    UserGenderMale, //男
    UserGenderFemale //女
};

@interface UserInfo : NSObject

@property (nonatomic,copy) NSString * username;//展示用的用户ID //手机号码
//公共服务获取网易账号信息
@property (nonatomic,copy) NSString * account;  //网易云账号
@property (nonatomic,copy) NSString * avatar;   //头像
@property (nonatomic,copy) NSString * id;       //网易云账号
@property (nonatomic,copy) NSString * nickname; //昵称
@property (nonatomic,copy) NSString * lastUpdatedTime;
@property (nonatomic,copy) NSString * im_username;  //网易云IM账号名称
@property (nonatomic,copy) NSString * createdTime;  //账号创建时间
@property (nonatomic,copy) NSString * token;  //网易云登录token



#pragma mark ——————————————————————————————————————————————————————
@property(nonatomic,assign)long long userid;//用户ID
@property (nonatomic,copy) NSString * idcard;//展示用的用户ID
@property (nonatomic,copy) NSString * photo;//头像
@property (nonatomic, assign) UserGender sex;//性别
@property (nonatomic,copy) NSString * imId;//IM账号
@property (nonatomic,copy) NSString * imPass;//IM密码
@property (nonatomic,assign) NSInteger  degreeId;//用户等级
@property (nonatomic,copy) NSString * signature;//个性签名
@property (nonatomic, strong) GameInfo *info;//游戏数据




@end
