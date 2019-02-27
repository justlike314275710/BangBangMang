//
//  PSStorageViewController.h
//  PrisonService
//
//  Created by kky on 2018/12/18.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSBusinessViewController.h"
typedef void (^ClearScuessBlock)();

@interface PSStorageViewController : PSBusinessViewController
@property (nonatomic, copy)ClearScuessBlock clearScuessBlock;



@end


