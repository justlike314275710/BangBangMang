//
//  PSPersonCardViewController.h
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/4/19.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "RootViewController.h"

@interface PSPersonCardViewController : RootViewController
- (instancetype)initWithUserId:(NSString *)userId withPhone:(NSString*)phone withNickName:(NSString*)nickName withAvatar:(NSString*)avatar withCurUserName:(NSString*)curUserName withFriendinfo:(NSString*)friendinfo withCircleoffriendsPicture:(NSArray*)CircleoffriendsPicture;


@end
