//
//  PSBusinessViewController.h
//  PrisonService
//
//  Created by calvin on 2018/4/3.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSViewController.h"
#import "PSViewModel.h"
#import "PSTipsView.h"
#import "PSLoadingView.h"

@interface PSBusinessViewController : PSViewController

@property (nonatomic, strong, readonly) PSViewModel *viewModel;

- (instancetype)initWithViewModel:(PSViewModel *)viewModel;

@end
