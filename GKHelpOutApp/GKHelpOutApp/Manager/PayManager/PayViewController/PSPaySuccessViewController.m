//
//  PSPaySuccessViewController.m
//  PrisonService
//
//  Created by calvin on 2018/4/23.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSPaySuccessViewController.h"

@interface PSPaySuccessViewController ()

@end

@implementation PSPaySuccessViewController

- (void)renderContents {
    UIImageView *successView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appointmentPaymentSuccess"]];
    [self.view addSubview:successView];
    [successView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(successView.frame.size);
    }];
    CGFloat btWidth = 89;
    CGFloat btHeight = 34;
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.titleLabel.font = FontOfSize(12);
    [finishButton setTitleColor:AppBaseTextColor1 forState:UIControlStateNormal];
    [finishButton setTitle:@"支付成功" forState:UIControlStateNormal];
    if (![self.payType isEqualToString:@"law"]) {
        finishButton.layer.borderColor = AppBaseTextColor1.CGColor;
        finishButton.layer.cornerRadius = btHeight / 2;
        finishButton.layer.borderWidth = 1.0;
        [finishButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    @weakify(self)
    [finishButton bk_whenTapped:^{
        @strongify(self)
        if (self.closeAction) {
            self.closeAction();
        }
    }];
    [self.view addSubview:finishButton];
    [finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([self.payType isEqualToString:@"law"]) {
            make.top.mas_equalTo(successView.mas_bottom).offset(10);
        } else {
            make.top.mas_equalTo(successView.mas_bottom).offset(40);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(btWidth);
        make.height.mas_equalTo(btHeight);
        
    }];
    
    if ([self.payType isEqualToString:@"law"]) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20,finishButton.bottom+2,self.view.width-40, 21)];
            label.text = @"您已成功发布咨询,请耐心等待律师接单";
            label.font = FontOfSize(11);
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = UIColorFromRGB(51,51,51);
            [self.view addSubview:label];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10,label.bottom+5, self.view.width-20, 1)];
            line.backgroundColor = UIColorFromRGB(230,230,230);
            [self.view addSubview:line];
            
            UIButton *backHomePage = [[UIButton alloc] initWithFrame:CGRectMake(30,line.bottom+5,80, 34)];
            backHomePage.titleLabel.font = FontOfSize(12);
            [backHomePage setTitleColor:AppBaseTextColor1 forState:UIControlStateNormal];
            [backHomePage setTitle:@"返回主页" forState:UIControlStateNormal];
            backHomePage.layer.borderColor = UIColorFromRGB(119,146,185).CGColor;
            backHomePage.layer.cornerRadius = btHeight / 2;
            backHomePage.layer.borderWidth = 1.0;
            [self.view addSubview:backHomePage];
            
            [backHomePage bk_whenTapped:^{
                @strongify(self)
                if (self.goHomeAction) {
                    self.goHomeAction();
                }
            }];
            
            
            UIButton *myZy = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width-110,line.bottom+5,80, 34)];
            myZy.titleLabel.font = FontOfSize(12);
            [myZy setTitleColor:AppBaseTextColor1 forState:UIControlStateNormal];
            [myZy setTitle:@"我的咨询" forState:UIControlStateNormal];
            myZy.layer.borderColor = UIColorFromRGB(119,146,185).CGColor;
            myZy.layer.cornerRadius = btHeight / 2;
            myZy.layer.borderWidth = 1.0;
            [self.view addSubview:myZy];
            
            [myZy bk_whenTapped:^{
                @strongify(self)
                if (self.gozxAction) {
                    self.gozxAction();
                }
            }];
            
            
            
        });
    }
}


- (BOOL)fd_interactivePopDisabled {
    return YES;
}

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.view.backgroundColor = [UIColor clearColor];
    [self renderContents];
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
