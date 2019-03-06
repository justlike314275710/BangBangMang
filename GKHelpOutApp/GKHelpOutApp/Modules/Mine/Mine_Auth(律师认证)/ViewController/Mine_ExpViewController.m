//
//  Mine_ExpViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/2/28.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "Mine_ExpViewController.h"
#import "Mine_AuthViewController.h"
#import "Mine_StatusViewController.h"
@interface Mine_ExpViewController ()
@property (nonatomic , strong) UIImageView *backView;
@property (nonatomic , strong) UIImageView *one_titleImageView;
@property (nonatomic , strong) UIImageView *two_titleImageView;
@property (nonatomic , strong) UIView *whiteView;
@property (nonatomic , strong) UIView *orangeView;
@property (nonatomic , strong) UIView *greenView;

@property (nonatomic , strong) UIImageView *PsychologyIcon;
@property (nonatomic , strong) UILabel *one_PsychologyLable;
@property (nonatomic , strong) UILabel *two_PsychologyLable;
@property (nonatomic , strong) UIImageView *PsychologyArrow;

@property (nonatomic , strong) UIImageView *LawIcon;
@property (nonatomic , strong) UILabel *one_LawLable;
@property (nonatomic , strong) UILabel *two_LawLable;
@property (nonatomic , strong) UIImageView *LawArrow;


@end

@implementation Mine_ExpViewController



#pragma mark  - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUI];
   
    // Do any additional setup after loading the view.
}
#pragma mark  - Notification

#pragma mark  - Event
-(void)PsychologyClick{
    NSLog(@"心理咨询");
}
-(void)push_MineAuthViewController{
    [self.navigationController pushViewController:[[Mine_AuthViewController alloc]init] animated:YES];
}

-(void)push_statusViewController{
    [self.navigationController pushViewController:[[Mine_StatusViewController alloc]init] animated:YES];
}
#pragma mark  - Data

#pragma mark  - UITableViewDelegate


#pragma mark  - UI
-(void)SetUI{
    self.title=@"专家入驻";
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.one_titleImageView];
    [self.backView addSubview:self.two_titleImageView];
    [self.view addSubview:self.whiteView];
    
    [self.whiteView addSubview:self.orangeView];
    [self.orangeView addSubview:self.PsychologyIcon];
    [self.orangeView addSubview:self.one_PsychologyLable];
    [self.orangeView addSubview:self.two_PsychologyLable];
    [self.orangeView addSubview: self.PsychologyArrow];
    
    [self.whiteView addSubview:self.greenView];
    [self.greenView addSubview:self.LawIcon];
    [self.greenView addSubview:self.one_LawLable];
    [self.greenView addSubview:self.two_LawLable];
    [self.greenView addSubview:self.LawArrow];
    
    
}


-(void)judgeLoginStatus{
    [[UserManager sharedUserManager]JudgeIdentityCallback:^(BOOL success, NSString *des) {
        if (success) {
            switch (help_userManager.userStatus) {
                case PENDING_CERTIFIED:
                    [self push_statusViewController];
                    break;
                case PENDING_APPROVAL:
                    [self push_statusViewController];
                    break;
                case APPROVAL_FAILURE:
                    [self push_statusViewController];
                    break;
                case CERTIFIED:
                    [self push_MineAuthViewController];
                    break;
                default:
                    break;
            }
        }
        else{
            [PSTipsView showTips:@"服务器异常"];
        }
    }];
}

#pragma mark  - setter & getter

- (UIImageView *)backView{
    if (!_backView) {
        _backView=[UIImageView new];
        _backView.frame=CGRectMake(0, 0, KScreenWidth, KScreenHeight-kStatusBarHeight);
        [_backView setImage:[UIImage imageNamed:@"背景图"]];
        
    }
    return _backView;
}

- (UIImageView *)one_titleImageView{
    if (!_one_titleImageView) {
        CGFloat siding=15.0f;
        _one_titleImageView=[UIImageView new];
        _one_titleImageView.frame=CGRectMake(siding, 52, 130, 26);
        [_one_titleImageView setImage:[UIImage imageNamed:@"加入帮帮忙"]];
    }
    return _one_titleImageView;
}

- (UIImageView *)two_titleImageView{
    if (!_two_titleImageView) {
        CGFloat siding=15.0f;
        _two_titleImageView=[UIImageView new];
        _two_titleImageView.frame=CGRectMake(siding, _one_titleImageView.bottom+siding, 240, 30);
        [_two_titleImageView setImage:[UIImage imageNamed:@"携手共创咨询品牌"]];
    }
    return _two_titleImageView;
}

- (UIView *)whiteView{
    if (!_whiteView) {
        _whiteView=[UIView new];
         CGFloat siding=15.0f;
        _whiteView.frame=CGRectMake(siding, 138, KScreenWidth-2*siding, 386);
        _whiteView.backgroundColor=[UIColor whiteColor];
        ViewRadius(_whiteView, 10.0f);
        }
    return _whiteView;
}


- (UIView *)orangeView{
    if (!_orangeView) {
        _orangeView=[UIView new];
        CGFloat siding=24.0f;
        _orangeView.frame=CGRectMake(siding, 56, _whiteView.width-2*siding, 120);
        _orangeView.backgroundColor=[UIColor colorWithRed:253/255.0 green:176/255.0 blue:96/255.0 alpha:1.0];
        ViewRadius(_orangeView, 10.0f);
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PsychologyClick)];
        [_orangeView addGestureRecognizer:tapGesture];
    }
    return _orangeView;
}

- (UIView *)greenView{
    if (!_greenView) {
        _greenView=[UIView new];
        CGFloat siding=24.0f;
        _greenView.frame=CGRectMake(siding, _orangeView.bottom+36, _whiteView.width-2*siding, 120);
        _greenView.backgroundColor=[UIColor colorWithRed:143/255.0 green:210/255.0 blue:124/255.0 alpha:1.0];
        ViewRadius(_greenView, 10.0f);
        UITapGestureRecognizer * lawyerTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(judgeLoginStatus)];
        [_greenView addGestureRecognizer:lawyerTapGesture];
    }
    return _greenView;
}

- (UIImageView *)PsychologyIcon{
    if (!_PsychologyIcon) {
        CGFloat sidding=21.0f;
        CGFloat width=70.0f;
        CGFloat height=74.0f;
        _PsychologyIcon=[UIImageView new];
        _PsychologyIcon.frame=CGRectMake(sidding, sidding, width, height);
        [_PsychologyIcon setImage:[UIImage imageNamed:@"心理咨询师icon"]];
    }
    return _PsychologyIcon;
}
- (UIImageView *)LawIcon{
    if (!_LawIcon) {
        CGFloat sidding=21.0f;
        CGFloat width=70.0f;
        CGFloat height=74.0f;
        _LawIcon=[UIImageView new];
        _LawIcon.frame=CGRectMake(sidding, sidding, width, height);
        [_LawIcon setImage:[UIImage imageNamed:@"法律咨询师icon"]];
    }
    return _LawIcon;
}


- (UILabel *)one_PsychologyLable{
    if (!_one_PsychologyLable) {
        CGFloat sidding=15.0f;
        _one_PsychologyLable=[[UILabel alloc]initWithFrame:CGRectMake(_PsychologyIcon.right+sidding, _PsychologyIcon.top+18, 120, 17)];
        _one_PsychologyLable.font=FontOfSize(16);
        _one_PsychologyLable.textColor=KWhiteColor;
        _one_PsychologyLable.text=@"我是心理咨询师";
        
    }
    return _one_PsychologyLable;
}


- (UILabel *)one_LawLable{
    if (!_one_LawLable) {
        CGFloat sidding=15.0f;
        _one_LawLable=[[UILabel alloc]initWithFrame:CGRectMake(_LawIcon.right+sidding, _LawIcon.top+18, 120, 17)];
        _one_LawLable.font=FontOfSize(16);
        _one_LawLable.textColor=KWhiteColor;
        _one_LawLable.text=@"我是法律咨询师";
        
    }
    return _one_LawLable;
}


- (UILabel *)two_PsychologyLable{
    if (!_two_PsychologyLable) {
        CGFloat sidding=15.0f;
        _two_PsychologyLable=[[UILabel alloc]initWithFrame:CGRectMake(_PsychologyIcon.right+sidding, _one_PsychologyLable.bottom+sidding, 120, 17)];
        _two_PsychologyLable.font=FontOfSize(12);
        _two_PsychologyLable.textColor=KWhiteColor;
        _two_PsychologyLable.text=@"立即入驻心理咨询师";
        
    }
    return _two_PsychologyLable;
}

- (UILabel *)two_LawLable{
    if (!_two_LawLable) {
        CGFloat sidding=15.0f;
        _two_LawLable=[[UILabel alloc]initWithFrame:CGRectMake(_LawIcon.right+sidding, _one_LawLable.bottom+sidding, 120, 17)];
        _two_LawLable.font=FontOfSize(12);
        _two_LawLable.textColor=KWhiteColor;
        _two_LawLable.text=@"立即入驻法律咨询师";
        
    }
    return _two_LawLable;
}

- (UIImageView *)PsychologyArrow{
    if (!_PsychologyArrow) {
        _PsychologyArrow=[UIImageView new];
        _PsychologyArrow.frame=CGRectMake(self.orangeView.width-20, 54, 9, 12);
        [_PsychologyArrow setImage:[UIImage imageNamed:@"进入－白"]];
    }
    return _PsychologyArrow;
}

- (UIImageView *)LawArrow{
    if (!_LawArrow) {
        _LawArrow=[UIImageView new];
        _LawArrow.frame=CGRectMake(self.greenView.width-20, 54, 9, 12);
        [_LawArrow setImage:[UIImage imageNamed:@"进入－白"]];
    }
    return _LawArrow;
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
