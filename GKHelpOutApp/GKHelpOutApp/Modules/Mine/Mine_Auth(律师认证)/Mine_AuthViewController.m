//
//  MineViewController.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "Mine_AuthViewController.h"
#import "MineTableViewCell.h"
#import "MineHeaderView.h"
#import "ProfileViewController.h"
#import "SettingViewController.h"
#import "XYTransitionProtocol.h"
#import "UploadAvatarViewController.h"


//#define KHeaderHeight ((260 * Iphone6ScaleWidth) + kStatusBarHeight)
#define KHeaderHeight 140

@interface Mine_AuthViewController ()<UITableViewDelegate,UITableViewDataSource,headerViewDelegate,XYTransitionProtocol>
{
    UILabel * lbl;
    NSArray *_dataSource;
    MineHeaderView *_headerView;//头部view
    UIView *_NavView;//导航栏
}
@end

@implementation Mine_AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"专家入驻——法律咨询师";
    self.isHidenNaviBar = NO;
    self.StatusBarStyle = UIStatusBarStyleLightContent;
    self.isShowLiftBack = NO;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    
    [self createUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self getRequset];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
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

-(BOOL)isNeedTransition{
    return YES;
}


#pragma mark ————— 创建页面 —————
-(void)createUI{
    
    self.tableView.height = KScreenHeight - kTabBarHeight;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"MineTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UILabel *headView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    headView.backgroundColor = [UIColor colorWithRed:255/255.0 green:246/255.0 blue:233/255.0 alpha:1.0];
    headView.text = @"未认证，请填写资料申请认证.\n此认证信息仅用于平台审核，我们将对你填写对内容严格保密";
    headView.textColor=[UIColor colorWithRed:182/255.0 green:114/255.0 blue:52/255.0 alpha:1.0];
    headView.numberOfLines=0;
    headView.font = [UIFont boldSystemFontOfSize:11.0f];
    headView.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = headView;
    
    
    [self.view addSubview:self.tableView];
    
    [self createNav];
    
    
    
    NSDictionary *Modifydata = @{@"titleText":@"修改资料",@"clickSelector":@"",@"title_icon":@"修改资料icon",@"detailText":@"",@"arrow_icon":@"arrow_icon"};
    
    NSDictionary *myMission = @{@"titleText":@"账户余额",@"clickSelector":@"",@"title_icon":@"账户余额icon",@"detailText":@"666¥",@"arrow_icon":@"arrow_icon"};
    
    NSDictionary *myFriends = @{@"titleText":@"账单",@"clickSelector":@"",@"title_icon":@"账单icon",@"arrow_icon":@"arrow_icon"};
    NSDictionary *myLevel = @{@"titleText":@"专家入驻",@"clickSelector":@"",@"title_icon":@"专家入驻icon",@"detailText":@"",@"arrow_icon":@"arrow_icon"};
    NSDictionary *myAdvice = @{@"titleText":@"意见反馈",@"clickSelector":@"",@"title_icon":@"意见反馈icon",@"detailText":@"",@"arrow_icon":@"arrow_icon"};
    NSDictionary *mySet = @{@"titleText":@"设置",@"clickSelector":@"",@"title_icon":@"设置icon",@"detailText":@"",@"arrow_icon":@"arrow_icon"};
    
    
    
    NSMutableArray *section1 = [NSMutableArray array];
    [section1 addObject:Modifydata];
    NSMutableArray *section2 = [NSMutableArray array];
    
    [section2 addObject:myMission];
    [section2 addObject:myFriends];
    NSMutableArray *section3 = [NSMutableArray array];
    [section3 addObject:myLevel];
    NSMutableArray *section4 = [NSMutableArray array];
    [section4 addObject:myAdvice];
    [section4 addObject:mySet];
    
    _dataSource = @[section1,section2,section3,section4];
    [self.tableView reloadData];
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
            //<<<<<<< HEAD
            //            [self.navigationController pushViewController:[[LawyerAuthenticationCViewController alloc]init] animated:YES];
            //=======
        {
            NSLog(@"点击了 修改资料");
        }
            break;
        case 1:
        {
            if (indexPath.row==0) {
                NSLog(@"点击了 账户余额");
            } else {
                NSLog(@"点击了 账单");
            }
        }
            break;
        case 2:
        {
            NSLog(@"点击了 专家入驻");
        }
            break;
        case 3:
        {
            if (indexPath.row==0) {
                NSLog(@"意见反馈");
            } else {
                NSLog(@"设置");
            }
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

#pragma mark ————— 切换账号 —————
-(void)changeUser{
    SettingViewController *settingVC = [SettingViewController new];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
