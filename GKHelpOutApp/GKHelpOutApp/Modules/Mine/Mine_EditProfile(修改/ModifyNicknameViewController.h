//
//  ModifyNicknameViewController.h
//  GKHelpOutApp
//
//  Created by kky on 2019/3/1.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "RootViewController.h"
typedef NS_ENUM(NSInteger, HMModifyType) {
    ModifyNickName = 0,    //设置昵称
    ModifyNickZipCode,     //设置邮编
};

NS_ASSUME_NONNULL_BEGIN

@interface ModifyNicknameViewController : RootViewController
@property(nonatomic,assign)HMModifyType modifyType;
@end

NS_ASSUME_NONNULL_END
