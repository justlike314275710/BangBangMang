//
//  LifeCircleManager.h
//  GKHelpOutApp
//
//  Created by kky on 2019/4/29.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HpBaseLogic.h"


@interface LifeCircleManager : NSObject

+ (LifeCircleManager *)sharedInstance;

- (void)requestLifeCircleNewDatacompleted:(CheckDataCallback)callback;



@end

