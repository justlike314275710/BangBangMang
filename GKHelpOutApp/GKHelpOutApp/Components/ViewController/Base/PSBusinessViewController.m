//
//  PSBusinessViewController.m
//  PrisonService
//
//  Created by calvin on 2018/4/3.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSBusinessViewController.h"

@interface PSBusinessViewController ()

@end

@implementation PSBusinessViewController

- (instancetype)initWithViewModel:(PSViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (UIImage *)leftItemImage {
    return [UIImage imageNamed:@"universalBackIcon"];
}

- (UIImage *)navgationBarImage {
    return [UIImage imageNamed:@"universalNaviBar"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = AppBaseBackgroundColor1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
