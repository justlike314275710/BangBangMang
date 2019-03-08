//
//  MyonsultationViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/2/26.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "MyConsultationViewController.h"
#import "LegaladviceViewController.h"
#import "CounselingViewController.h"
#import "ZWTopSelectButton.h"
#import "ZWTopSelectVcView.h"
#import "PSMyAdviceViewController.h"
#import "PSConsultationViewModel.h"
#import "LawyerAdviceViewController.h"

@interface MyConsultationViewController ()<ZWTopSelectVcViewDataSource,ZWTopSelectVcViewDelegate> {
    BOOL              isChangeChildVc;
    int               selectIndex;
    UIViewController *selectViewController;
}
@property (nonatomic, strong) ZWTopSelectVcView *topSelectVcView;
@property (nonatomic, strong) UIImageView *iconImg1;
@property (nonatomic, strong) UIImageView *iconImg2;

@end

@implementation MyConsultationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的咨询";
//    [self addNavigationItemWithImageNames:@[@"会话icon－红点"] isLeft:NO target:self action:@selector(rightAction) tags:@[@2000]];
    
    [self setupUI];
    
}

#pragma mark - PrivateMethods
- (void)setupUI {
    
    ZWTopSelectVcView *topSelectVcView=[[ZWTopSelectVcView alloc]init];
    topSelectVcView.frame=CGRectMake(0,14,KScreenWidth,KScreenHeight);
    [self.view addSubview:topSelectVcView];
    self.topSelectVcView=topSelectVcView;
    self.topSelectVcView.dataSource=self;
    self.topSelectVcView.delegate=self;
    
    [self.topSelectVcView setupZWTopSelectVcViewUI];
    self.topSelectVcView.animationType=Push;
    
    [self.topSelectVcView addSubview:self.iconImg1];
    self.iconImg1.frame = CGRectMake(40,(50-13)/2, 13, 13);
    
    [self.topSelectVcView addSubview:self.iconImg2];
    self.iconImg2.frame = CGRectMake(40+KScreenWidth/2,(50-13)/2, 13, 13);
    //fix
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(KScreenWidth/2,14,KScreenHeight/2,50);
    [self.view addSubview:btn];
    btn.backgroundColor= KClearColor;
    [btn addTapBlock:^(UIButton *btn) {
         [PSTipsView showTips:Hmsg_Comingsoon];
    }];

}

#pragma mark - TouchEvent
-(void)rightAction {
    [PSTipsView showTips:Hmsg_Comingsoon];
}

#pragma mark - ZWTopSelectVcViewDelegate
- (void)topSelectVcView:(ZWTopSelectVcView *)topSelectVcView didSelectVc:(UIViewController *)selectVc atIndex:(int)index
{
    NSLog(@"\n当前选中Vc %@ \n index为%d  222",selectVc,index);
    selectIndex = index;
    selectViewController = selectVc;
    if (index==0) {
        _iconImg1.image = IMAGE_NAMED(@"用户icon");
        _iconImg2.image = [UIImage imageNamed:@"wezxicon"];
    } else {
        _iconImg1.image = IMAGE_NAMED(@"用户icon");
        _iconImg2.image = [UIImage imageNamed:@"wezxicon"];
    }
    
}

#pragma mark - ZWTopSelectVcViewDataSource
//初始化设置
-(NSMutableArray *)totalControllerInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    NSMutableArray *controllerMutableArr=[NSMutableArray array];
    
    switch (help_userManager.userStatus) {
        case 3:{
            LawyerAdviceViewController *showtwoVc= [[ LawyerAdviceViewController alloc]init];
            showtwoVc.title=@"法律咨询";
            [controllerMutableArr addObject:showtwoVc];}//普通用户
            break;
            
        default:{
            PSMyAdviceViewController *showtwoVc= [[ PSMyAdviceViewController alloc]initWithViewModel:[[PSConsultationViewModel alloc] init]];
            showtwoVc.title=@"法律咨询";
            [controllerMutableArr addObject:showtwoVc];}
            break;
    }
    
    
    LegaladviceViewController *showoneVc= [[LegaladviceViewController alloc]initWithViewModel:[[PSConsultationViewModel alloc] init]];
    showoneVc.title=@"心理咨询";
    [controllerMutableArr addObject:showoneVc];
    
    return controllerMutableArr;
}
//（可选）初始化展示第几个控制器（默认第一个，以UIViewController查找，优先级高）
-(UIViewController *)showChildViewVcNameInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    
    return selectViewController;
}

//顶部按钮间隔线颜色
-(UIColor *)topSliderLineSpacingColorInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcViedew
{
    return CLineColor;
}
//顶部按钮文字选中背景色设置
-(UIColor *)topSliderViewSelectedTitleColorInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcViedew
{
    return CFontColor1;
}
//顶部按钮文字未选中背景色设置
-(UIColor *)topSliderViewNotSelectedTitleColorInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcViedew
{
    return CFontColor2;
}
//顶部滑块背景设置
-(UIColor *)topSliderViewBackGroundColorInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    return CFontColor3;
}
-(CGFloat)topViewHeightInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView {
    return 50;
}
#pragma mark - Setting&Getting
- (UIImageView *)iconImg1 {
    if (!_iconImg1) {
        _iconImg1 = [UIImageView new];
        _iconImg1.image = IMAGE_NAMED(@"用户icon");
    }
    return _iconImg1;
}
- (UIImageView *)iconImg2 {
    if (!_iconImg2) {
        _iconImg2 = [UIImageView new];
        _iconImg2.image = [UIImage imageNamed:@"wezxicon"];
    }
    return _iconImg2;
}

@end
