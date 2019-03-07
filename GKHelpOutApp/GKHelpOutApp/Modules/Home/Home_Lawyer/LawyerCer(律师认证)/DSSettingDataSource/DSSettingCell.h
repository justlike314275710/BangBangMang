//
//  CertificateTableViewCell.h
//  DSSettingDataSource
//
//  Created by 狂生烈徒 on 2019/2/26.
//  Copyright © 2019年 HelloAda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSSettingItem.h"
#import "DSSettingCellProtocol.h"
@interface DSSettingCell : UITableViewCell<DSSettingCellProtocol>

//初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

//设置数据
- (void)refreshData:(DSSettingItem *)item tableView:(UITableView *)tableView;

@end

