//
//  SendLifeCircleViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/4/19.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "SendLifeCircleViewController.h"

@interface SendLifeCircleViewController ()

@end

@implementation SendLifeCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发生活圈";
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


@end
