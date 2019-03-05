//
//  HMMessageCellTableViewCell.h
//  GKHelpOutApp
//
//  Created by kky on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMMessageCellTableViewCell : UITableViewCell
@property(nonatomic, strong) UIImageView *iconImg;
@property(nonatomic, strong) UILabel *titleLab;
@property(nonatomic, strong) UILabel *dataLab;
@property(nonatomic, strong) UILabel *detailLab;
@property(nonatomic, strong) UIImageView *arrowImg;

@end

NS_ASSUME_NONNULL_END
