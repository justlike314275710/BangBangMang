//
//  PSMoreServiceViewController.m
//  PrisonService
//
//  Created by kky on 2018/10/25.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSMoreServiceViewController.h"
#import "serciceIiem.h"
#import "PSMoreServiceViewModel.h"
#import "PSMoreRoleDetailViewController.h"
#import "PSConsultationViewController.h"
#import "PSConsultationViewModel.h"
#import "PSLawerViewModel.h"

@interface PSMoreServiceViewController ()
@property (nonatomic,strong) UIScrollView *myScrollview;
@property (nonatomic,strong) UIButton *releaseBtn;

@end

@implementation PSMoreServiceViewController

#pragma mark - CycleLife
- (instancetype)initWithViewModel:(PSViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        NSString *title = @"法律服务";
        self.title = title;

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor=UIColorFromRGBA(248, 247, 254, 1);
    [self p_setUI];
}

#pragma mark - PrivateMethod
- (void)p_setUI {
    
    [self.view addSubview:self.myScrollview];
    [self.myScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.right.left.mas_equalTo(self.view);
    }];
    
    //actionItem
    PSMoreServiceViewModel *PSMoreViewModel = (PSMoreServiceViewModel *)self.viewModel;
    for (int i = 0; i<8; i++) {
        int x = i%2 == 0 ? 0 : self.view.mj_w/2;
        int y = (i/2) * 140;
        PSMoreModel *model = PSMoreViewModel.functions[i];
        serciceIiem *actionItem = [[serciceIiem alloc] initWithFrame:CGRectMake(x, y,self.view.mj_w/2,140) logoImage:model.logoIcon title:model.title  message:model.message];
        actionItem.tag = i + 100;
        @weakify(self)
        [actionItem bk_whenTapped:^{
            @strongify(self);
            [self p_pushRoleDetailViewController:actionItem];
        }];
        actionItem.backgroundColor = [UIColor whiteColor];
        [self.myScrollview addSubview:actionItem];
    }
    
    UIView *v_line =  [UIView new];
    v_line.backgroundColor = UIColorFromRGB(217, 217, 217);
    [self.myScrollview addSubview:v_line];
    [v_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.myScrollview).offset(20);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(540);
        make.centerX.mas_equalTo(self.myScrollview);

    }];
    
    for (int i = 0;i < 3; i++ ) {
        UIView *w_line =  [UIView new];
        w_line.backgroundColor = UIColorFromRGB(217, 217, 217);
        [self.myScrollview addSubview:w_line];
        [w_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(140*(i+1));
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(self.myScrollview.contentSize.width-40);
            make.height.mas_equalTo(1);
        }];
    }
    //发布抢单
    [self.myScrollview addSubview:self.releaseBtn];
    [self.releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140*4+25);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self.myScrollview);
    }];
    @weakify(self);
    [self.releaseBtn bk_whenTapped:^{
        @strongify(self);
        [self p_pushReleaseViewController];
    }];
    
}

- (void)p_pushReleaseViewController {

    PSConsultationViewModel*viewModel=[[PSConsultationViewModel alloc]init];
    PSConsultationViewController*consultationViewController=[[PSConsultationViewController alloc]initWithViewModel:viewModel];
    [self.navigationController pushViewController:consultationViewController animated:YES];
}

-(void)p_pushRoleDetailViewController:(serciceIiem *)item {
    NSInteger actionIndex = item.tag - 100;
    if (actionIndex==0) {
        PSLawerViewModel*viewModel=[[PSLawerViewModel alloc]init];
        viewModel.category=@"PROPERTY_DISPUTES";
        PSMoreRoleDetailViewController *RoloDetailVC = [[PSMoreRoleDetailViewController alloc] initWithViewModel:viewModel];
        [self.navigationController pushViewController:RoloDetailVC animated:YES];
    }
    else if (actionIndex==1){
        
    }
    
}

#pragma mark - setting&&getting
- (UIScrollView *)myScrollview {
    if (!_myScrollview) {
        _myScrollview = [[UIScrollView alloc] init];
        _myScrollview.contentSize = CGSizeMake(self.view.mj_w,140*4+80);
        _myScrollview.backgroundColor = UIColorFromRGBA(249,248,254,1);
    }
    return _myScrollview;
}

- (UIButton *)releaseBtn {
    if (!_releaseBtn) {
        _releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_releaseBtn setTitle:@"发布抢单" forState:UIControlStateNormal];
        _releaseBtn.titleLabel.font = FontOfSize(14);
        _releaseBtn.layer.masksToBounds = YES;
        _releaseBtn.layer.borderWidth = 1;
        _releaseBtn.layer.cornerRadius = 20;
        _releaseBtn.layer.borderColor = UIColorFromRGB(38, 76, 144).CGColor;
        [_releaseBtn setTitleColor:UIColorFromRGB(38, 76, 144) forState:UIControlStateNormal];
    }
    return _releaseBtn;
}

@end
