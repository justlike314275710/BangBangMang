//
//  AuthItem.h
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/2/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthItem : NSObject
@property (nonatomic , strong) NSString *title;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, strong, nonnull) NSString *cellReusedId;//对应cell的复用标识
@end
