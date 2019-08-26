//
//  MineViewController.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//
#import "NTESContactViewController.h"
#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "MineHeaderView.h"
#import "ProfileViewController.h"
#import "SettingViewController.h"
#import "XYTransitionProtocol.h"
#import "UploadAvatarViewController.h"
#import "Mine_AuthViewController.h"
#import "PSWriteFeedbackListViewController.h"
#import "ModifyDataViewController.h"
#import "Mine_ExpViewController.h"
#import "HMAccountBalanceViewController.h"
#import "HMBillViewController.h"
#import "PSWriteFeedbackViewController.h"
#import "NSString+JsonString.h"
#import "FriendsViewController.h"
#import "MyConsultationViewController.h"
#import "UITabBar+CustomBadge.h"

//#define KHeaderHeight ((260 * Iphone6ScaleWidth) + kStatusBarHeight)
#define KHeaderHeight 140


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,headerViewDelegate,XYTransitionProtocol,NIMSystemNotificationManager>
{
    UILabel * lbl;
    NSArray *_dataSource;
    MineHeaderView *_headerView;//头部view
    UIView *_NavView;//导航栏
    NSString *_LifeRedDot;
}
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = NO;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _LifeRedDot = @"0";
    [self createUI];
    [self initData];
    [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
    //个人中心资料变化
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(initData)
                                                 name:KNotificationMineDataChange
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(initDotData:)
                                                 name:KNotificationMineRefreshDot
                                               object:nil];
    
    
}


#pragma mark ————— 生活圈底部tabbar —————

- (void)initDotData:(NSNotification*)notification{
    NSString *dotString = [notification object];
    _LifeRedDot = dotString;
    [self initData];
}
- (void)onSystemNotificationCountChanged:(NSInteger)unreadCount{
    [self initData];
}

- (void)dealloc{
     [[NIMSDK sharedSDK].systemNotificationManager removeDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getRequset];
    NSInteger systemCount = [[[NIMSDK sharedSDK] systemNotificationManager] allUnreadCount];
    if (systemCount>0) {
        [kAppDelegate.mainTabBar setRedDotWithIndex:3 isShow:YES];
    } else {
        [kAppDelegate.mainTabBar setRedDotWithIndex:3 isShow:NO];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

#pragma mark ————— 拉取数据 —————
-(void)getRequset{
    _headerView.userInfo = curUser;
}

#pragma mark ————— 头像被点击 —————
-(void)headerViewClick{
//        [self ysl_addTransitionDelegate:self];
//    ProfileViewController *profileVC = [ProfileViewController new];
//    profileVC.headerImage = _headerView.headImgView.image;
    [self modifyData];
}

#pragma mark ————— 昵称被点击 —————
-(void)nickNameViewClick{
//    [self.navigationController pushViewController:[RootViewController new] animated:YES];
    [self modifyData];
}
#pragma mark ————— 律师认证被点击 —————
-(void)cerLawViewClick {
}

#pragma mark -- YSLTransitionAnimatorDataSource
//-(UIImageView *)pushTransitionImageView{
//    return _headerView.headImgView;
//}
//
//- (UIImageView *)popTransitionImageView
//{
//    return nil;
//}
-(UIView *)targetTransitionView{
    return _headerView.headImgView;
}
-(BOOL)isNeedTransition{
    return YES;
}


#pragma mark ————— 创建页面 —————
-(void)initData{
    
    if (help_userManager.avatarImage) {
        _headerView.headImgView.image = help_userManager.avatarImage;
    } else {
        [_headerView.headImgView sd_setImageWithURL:[NSURL URLWithString:help_userManager.curUserInfo.avatar] placeholderImage:[UIImage imageWithColor:KGrayColor]];
    }
    _headerView.nickNameLab.text = help_userManager.curUserInfo.nickname;
    _headerView.phoneNuberLab.text = help_userManager.curUserInfo.username;
    if (curUser.username.length>10) {
        NSString *phoneNumber = [NSString changeTelephone:help_userManager.curUserInfo.username];
        _headerView.phoneNuberLab.text = phoneNumber;
    }
  
    
    NSString *accont = help_userManager.lawUserInfo.rewardAmount?help_userManager.lawUserInfo.rewardAmount:@"";
    if (accont.length>0) {
        accont = NSStringFormat(@"¥%.2f",[accont floatValue]);
    } else {
        accont = @"0.00";
    }
     NSInteger systemCount = [[[NIMSDK sharedSDK] systemNotificationManager] allUnreadCount];
    NSString *systemCountStr = [NSString stringWithFormat: @"%ld", (long)systemCount];
  
    //通讯录
    NSDictionary *addressbook = @{@"titleText":@"通讯录",@"clickSelector":@"",@"title_icon":@"通讯录icon",@"detailText":@"",@"arrow_icon":@"arrow_icon",@"reddot":systemCountStr};
    //我的生活圈
    NSDictionary *lifeCircle = @{@"titleText":@"我的生活圈",@"clickSelector":@"",@"title_icon":@"生活圈icon",@"detailText":@"",@"arrow_icon":@"arrow_icon",@"reddot":_LifeRedDot};
    //我的咨询
    NSDictionary *myConsultation = @{@"titleText":@"我的咨询",@"clickSelector":@"",@"title_icon":@"我的咨询icon",@"detailText":@"",@"arrow_icon":@"arrow_icon",@"reddot":@"0"};
    
    NSDictionary *accountBalance = @{@"titleText":@"账户余额",@"clickSelector":@"",@"title_icon":@"账户余额icon",@"detailText":accont,@"arrow_icon":@"arrow_icon",@"reddot":@"0"};
    NSDictionary *Bill = @{@"titleText":@"账单",@"clickSelector":@"",@"title_icon":@"账单icon",@"arrow_icon":@"arrow_icon",@"reddot":@"0"};
    NSDictionary *expertsInt = @{@"titleText":@"专家入驻",@"clickSelector":@"",@"title_icon":@"专家入驻icon",@"detailText":@"",@"arrow_icon":@"arrow_icon",@"reddot":@"0"};
    NSDictionary *mySet = @{@"titleText":@"设置",@"clickSelector":@"",@"title_icon":@"设置icon",@"detailText":@"",@"arrow_icon":@"arrow_icon",@"reddot":@"0"};
    
    NSMutableArray *section1 = [NSMutableArray array];
    [section1 addObject:addressbook];
    [section1 addObject:lifeCircle];
    [section1 addObject:myConsultation];
    
    NSMutableArray *section2 = [NSMutableArray array];
    //认证律师才有账户余额
    if (help_userManager.userStatus == CERTIFIED) {
        [section2 addObject:accountBalance];
    }
    
    [section2 addObject:Bill];
    NSMutableArray *section3 = [NSMutableArray array];
    [section3 addObject:expertsInt];
    NSMutableArray *section4 = [NSMutableArray array];
    [section4 addObject:mySet];
    
    _dataSource = @[section1,section2,section3,section4];
    [self.tableView reloadData];
}

-(void)createUI{
    
    self.tableView.height = KScreenHeight - kTopHeight-kTabBarHeight;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"MineTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, -KHeaderHeight, KScreenWidth, KHeaderHeight)];
    _headerView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(_headerView.height, 0, 0, 0);
    [self.tableView addSubview:_headerView];
    [self.view addSubview:self.tableView];
    
    [self createNav];
}
#pragma mark ————— 创建自定义导航栏 —————
-(void)createNav{
    _NavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kTopHeight)];
    _NavView.backgroundColor = KClearColor;
    
    UILabel * titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, KScreenWidth/2, kNavBarHeight )];
    titlelbl.centerX = _NavView.width/2;
    titlelbl.textAlignment = NSTextAlignmentCenter;
    titlelbl.font= SYSTEMFONT(17);
    titlelbl.textColor = KWhiteColor;
    titlelbl.text = self.title;
    [_NavView addSubview:titlelbl];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"设置" forState:UIControlStateNormal];
    btn.titleLabel.font = SYSTEMFONT(16);
    [btn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.frame = CGRectMake(_NavView.width - btn.width - 15, kStatusBarHeight, btn.width, 40);
    [btn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeUser) forControlEvents:UIControlEventTouchUpInside];
    
//    [_NavView addSubview:btn];
//    [self.view addSubview:_NavView];
}

#pragma mark ————— tableview 代理 ————
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *sectionAry = _dataSource[section];
    return sectionAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell" forIndexPath:indexPath];
    NSMutableArray *sectionAry = _dataSource[indexPath.section];
    cell.cellData = sectionAry[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:
        {
            if (indexPath.row==0) {
                [self ContactFriends];
            }
            else if (indexPath.row==1){
                [self FriendsCircle];
            }
            else if (indexPath.row==2){
                [self MyConsultation];
            }
            else {
                
            }
            
        }
            break;
        case 1:
        {
            //认证律师
            if (help_userManager.userStatus==CERTIFIED) {
                if (indexPath.row==0) {
                     NSLog(@"点击了 账户余额");
                    [self accountBalance];
                } else {
                     NSLog(@"点击了 账单");
                    [self accountbill];
                }
            } else {
                [self accountbill];
            }
        }
              break;
        case 2:
        {
            //[self.navigationController pushViewController:[[Mine_AuthViewController alloc]init] animated:YES];
            [self.navigationController pushViewController:[[Mine_ExpViewController alloc]init] animated:YES];
            NSLog(@"点击了 专家入驻");
        }
            break;
        case 3:
        {
             [self changeUser];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark ————— scrollView 代理 —————
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y ;
    CGFloat totalOffsetY = scrollView.contentInset.top + offset;
    
    NSLog(@"offset    %.f   totalOffsetY %.f",offset,totalOffsetY);
    //    if (totalOffsetY < 0) {
    _headerView.frame = CGRectMake(0, offset, self.view.width, KHeaderHeight- totalOffsetY);
    //    }
    
}
#pragma mark ————— 我的咨询 —————
-(void)MyConsultation{
    [self.navigationController pushViewController:[[MyConsultationViewController alloc]init] animated:YES];
}
#pragma mark ————— 生活圈 —————
-(void)FriendsCircle{
    _LifeRedDot = @"0";
    LifeCircleViewController *LifeCircleVC = [[LifeCircleViewController alloc] init];
    LifeCircleVC.lifeCircleStyle = HMLifeCircleMy;
    PushVC(LifeCircleVC);
}

#pragma mark ————— 通讯录 —————
-(void)ContactFriends{
    [self.navigationController pushViewController:[[NTESContactViewController alloc]init] animated:YES];
}

#pragma mark ————— 设置 —————
-(void)changeUser{
    SettingViewController *settingVC = [SettingViewController new];
    [self.navigationController pushViewController:settingVC animated:YES];
}
#pragma mark ————— 意见反馈 —————
-(void)feedback{
//    PSWriteFeedbackListViewController *feedBackListVC = [[PSWriteFeedbackListViewController alloc] init];
//    [self.navigationController pushViewController:feedBackListVC animated:YES];
    PSWriteFeedbackViewController *feedBackVC = [[PSWriteFeedbackViewController alloc] init];
    [self.navigationController pushViewController:feedBackVC animated:YES];
    
}

#pragma mark ————— 修改资料 —————
-(void)modifyData{
    ModifyDataViewController *modifyDataVC = [[ModifyDataViewController alloc] init];
    [self.navigationController pushViewController:modifyDataVC animated:YES];
}
#pragma mark ————— 账户余额 —————
-(void)accountBalance{
    HMAccountBalanceViewController *accounBalanceVC = [[HMAccountBalanceViewController alloc] init];
    [self.navigationController pushViewController:accounBalanceVC animated:YES];
}
#pragma mark ————— 账单 —————
-(void)accountbill{
    HMBillViewController *BillVC = [[HMBillViewController alloc]init];
    [self.navigationController pushViewController:BillVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
