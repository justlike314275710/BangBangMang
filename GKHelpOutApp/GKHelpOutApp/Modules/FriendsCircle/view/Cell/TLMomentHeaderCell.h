//
//  TLMomentHeaderCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

@interface TLMomentHeaderCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) UserInfo *user;

@end
