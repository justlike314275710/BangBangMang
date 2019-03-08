//
//  PSFWriteFeedSuccessViewController.m
//  PrisonService
//
//  Created by kky on 2018/12/25.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSFWriteFeedSuccessViewController.h"
#import "PSWriteFeedbackListViewController.h"
#import "MineViewController.h"
#import "PSFeedbackViewModel.h"

@interface PSFWriteFeedSuccessViewController ()

@end

@implementation PSFWriteFeedSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PSFeedbackViewModel *viewModel = (PSFeedbackViewModel *)self.viewModel;
    NSString *title = @"意见反馈";
    if (viewModel.writefeedType == PSPrisonfeedBack) {
         title=@"投诉建议";
    }

    self.title = title;
    self.view.backgroundColor = UIColorFromRGBA(248, 247, 254, 1);
    NSString*close= @"关闭";
    [self createRightBarButtonItemWithTarget:self action:@selector(rightAction) title:close];
    [self p_setUI];
}

- (void)p_setUI {
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width-156)/2,60, 156, 138)];
    imageV.image = [UIImage imageNamed:@"writeFeedscuess"];
    [self.view addSubview:imageV];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake((self.view.width-200)/2,imageV.bottom+30,200,25);
    label.numberOfLines = 0;
    NSString *title = @"反馈成功";
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:19];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColorFromRGB(38, 76, 144);
    [self.view addSubview:label];
    
    UILabel *msgLab = [[UILabel alloc] init];
    msgLab.frame = CGRectMake((self.view.width-250)/2,label.bottom+5,250,60);
    msgLab.numberOfLines = 0;
    NSString *msg = @"您的反馈我们会认真查看，并尽快修复及完善 感谢您对帮帮忙一如既往的支持。";
    msgLab.text = msg;
    msgLab.font = FontOfSize(12);
    msgLab.textAlignment = NSTextAlignmentCenter;
    msgLab.textColor = UIColorFromRGB(102,102,102);
    [self.view addSubview:msgLab];
}

- (IBAction)actionOfLeftItem:(id)sender {
    [self rightAction];
}
- (void)rightAction {
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[MineViewController class]]) {
            [self.navigationController popToViewController:obj animated:YES];
            *stop = YES;
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    //刷新列表
    [[NSNotificationCenter defaultCenter] postNotificationName:@"wirtefeedListfresh" object:nil];
}

@end
