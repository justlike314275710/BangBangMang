//
//  CertificateTableViewCell.h
//  DSSettingDataSource
//
//  Created by 狂生烈徒 on 2019/2/26.
//  Copyright © 2019年 HelloAda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DSSettingCell.h"
#import "DSSettingCellProtocol.h"
@interface DSSettingDataSource : NSObject<UITableViewDelegate, UITableViewDataSource>

//初始化
- (instancetype)initWithItems:(NSArray *)items;

@end
