//
//  NTESContentView.h
//  DemoApplication
//
//  Created by chris on 15/11/1.
//  Copyright © 2015年 chris. All rights reserved.
//

#import "NIMKit.h"
#import "NIMSessionMessageContentView.h"
#import "PSNavigationController.h"
@interface NTESContentView : NIMSessionMessageContentView

@property (nonatomic, strong) UIImageView *postImageView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic , strong) NSString *cid;
@property (nonatomic , strong) NSString *categoy;
@property (nonatomic, strong) PSNavigationController *consulationNavigationController;
@end
