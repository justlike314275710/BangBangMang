//
//  HpBaseLogic.h
//  GKHelpOutApp
//
//  Created by kky on 2019/2/20.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestDataCompleted)(id data);
typedef void(^RequestDataFailed)(NSError *error);
typedef void(^RequestDataTaskCompleted)(id data);
typedef void(^CheckDataCallback)(BOOL successful, NSString *tips);
typedef void(^Complete)(void);

@interface HpBaseLogic : NSObject

- (void)checkDataWithCallback:(CheckDataCallback)callback;

- (void)fetchDataWithParams:(id)params completed:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;


@end

