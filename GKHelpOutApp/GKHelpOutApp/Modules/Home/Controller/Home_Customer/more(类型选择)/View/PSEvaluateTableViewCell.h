//
//  PSEvaluateTableViewCell.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/5.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDZStarsControl.h"
@interface PSEvaluateTableViewCell : UITableViewCell<CDZStarsControlDelegate>
@property (nonatomic,strong) CDZStarsControl *starsControl;
@end
