//
//  CertificateTableViewCell.h
//  DSSettingDataSource
//
//  Created by 狂生烈徒 on 2019/2/26.
//  Copyright © 2019年 HelloAda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DSSettingItem;
@protocol DSSettingCellProtocol <NSObject>

//初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@optional
//传数据用这个
- (void)refreshData:(DSSettingItem *)item tableView:(UITableView *)tableView;

@end
