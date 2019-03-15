//
//  Mine_StatusViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/5.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "Mine_StatusViewController.h"
#import "Mine_AuthViewController.h"
#import "Mine_AuthLogic.h"
#import "Mine_ExpViewController.h"
@interface Mine_StatusViewController ()
@property (nonatomic , strong) UIImageView *backImageView;
@property (nonatomic , strong) UILabel *titleLable;
@property (nonatomic , strong) UIButton *operationButton;

@end

@implementation Mine_StatusViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self refreshData];
}
- (void)backBtnClicked{
    [self.navigationController popToViewController:[[Mine_ExpViewController alloc]init] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   [self renderContents];
    self.title=@"资格认证";
    // Do any additional setup after loading the view.
}

-(void)refreshData{
    Mine_AuthLogic *authLogic = [Mine_AuthLogic new];
    [authLogic getLawyerProfilesData:^(id data) {
        if (ValidDict(data)) {
            NSString *userStaus = [data valueForKey:@"certificationStatus"];
            if ([userStaus isEqualToString:@"PENDING_CERTIFIED"]) {
                help_userManager.userStatus = PENDING_CERTIFIED;
            } else if ([userStaus isEqualToString:@"PENDING_APPROVAL"]){
                help_userManager.userStatus = PENDING_APPROVAL;
            } else if ([userStaus isEqualToString:@"APPROVAL_FAILURE"]){
                help_userManager.userStatus = APPROVAL_FAILURE;
            } else if ([userStaus isEqualToString:@"CERTIFIED"]){
                help_userManager.userStatus = CERTIFIED;
            }
            [self saveUserState];
        }
    } failed:^(NSError *error) {
        if (![self loadUserState]) {
            help_userManager.userStatus = PENDING_CERTIFIED;
        }
    }];
}

-(void)saveUserState {
    YYCache *cache = [[YYCache alloc] initWithName:KUserCacheName];
    NSString *state = NSStringFormat(@"%ld",help_userManager.userStatus);
    [cache setObject:state forKey:KUserStateName];
    [self renderContents];
}

-(BOOL)loadUserState {
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    NSString *stateStr = (NSString *)[cache objectForKey:KUserStateName];
    if (stateStr) {
        help_userManager.userStatus = [stateStr integerValue];
        return YES;
    }
    return NO;
}

- (void)renderContents{
    
    CGFloat horSpace = 20;
    _titleLable = [UILabel new];
    _titleLable.font = AppBaseTextFont3;
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.textColor = AppBaseTextColor1;
    //_titleLable.text=@"您还未进行家属认证～";
    _titleLable.numberOfLines=0;
     [self.view addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(horSpace);
        make.right.mas_equalTo(-horSpace);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(self.view);
    }];
    
    
    
    _backImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"资格认证背景图"]];
    [self.view addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.titleLable.mas_top).offset(-35);
        make.size.mas_equalTo(self.backImageView.frame.size);
    }];
    
    CGFloat btWidth = 89;
    CGFloat btHeight = 34;
    _operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _operationButton.layer.borderWidth = 1.0;
    _operationButton.layer.borderColor = AppBaseTextColor1.CGColor;
    _operationButton.layer.cornerRadius = btHeight / 2;
    _operationButton.titleLabel.font = AppBaseTextFont1;
    [_operationButton setTitleColor:AppBaseTextColor1 forState:UIControlStateNormal];
     [self.view addSubview:_operationButton];
    [_operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLable.mas_bottom).offset(44);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(btWidth);
        make.height.mas_equalTo(btHeight);
    }];
    
    switch (help_userManager.userStatus) {
        case PENDING_CERTIFIED:{
              _operationButton.hidden=NO;
             [_operationButton setTitle:@"马上认证" forState:0];
            _titleLable.text=@"您还未进行家属认证～";
            
        }
            break;
        case PENDING_APPROVAL:{
              _operationButton.hidden=YES;
             _titleLable.text=@"您提交的认证申请正在审核中，请耐心等待～";
         }
            break;
            
        case APPROVAL_FAILURE:{
            _operationButton.hidden=NO;
            [_operationButton setTitle:@"重新认证" forState:0];
            _titleLable.text=@"您提交的认证申请没有通过审核，请重新认证～";

        }
            break;
        case CERTIFIED:{
            _operationButton.hidden=YES;
        }
            break;
        default:
            break;
    }

    [_operationButton bk_whenTapped:^{
        [self.navigationController pushViewController:[[Mine_AuthViewController alloc]init] animated:YES];
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
