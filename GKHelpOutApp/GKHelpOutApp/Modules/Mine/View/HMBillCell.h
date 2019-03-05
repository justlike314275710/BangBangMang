//
//  HMBillCell.h
//  GKHelpOutApp
//
//  Created by kky on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMBillCell : UITableViewCell
@property(nonatomic, strong) UILabel *titleLab;
@property(nonatomic, strong) UILabel *dataLab;
@property(nonatomic, strong) UILabel *payWayLab;
@property(nonatomic, strong) UILabel *orderLab;
@property(nonatomic, strong) UILabel *moneylab;

@end

NS_ASSUME_NONNULL_END
