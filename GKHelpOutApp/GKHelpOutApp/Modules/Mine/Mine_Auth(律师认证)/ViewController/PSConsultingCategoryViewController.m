//
//  PSPrisonerFamilesViewController.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/9/14.
//  Copyright © 2018年 calvin. All rights reserved.
//
#define defaultTag 1990


#import "PSFamilyTableViewCell.h"
#import "PSAlertView.h"
#import "PSAppointmentViewModel.h"
#import <AFNetworking/AFNetworking.h>
#import "PSConsultingCategoryViewController.h"



@interface PSConsultingCategoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *consultingCategoryTableView;
@property (nonatomic , strong) NSMutableArray *selectArray;
@property (nonatomic , strong) NSArray *categoryArray;
@property (nonatomic, assign) NSInteger btnTag;
@end

@implementation PSConsultingCategoryViewController
- (instancetype)initWithViewModel:(PSViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        self.title = @"咨询类别";
        [self setIsShowLiftBack:YES];
        [self createRightBarButtonItemWithTarget:self action:@selector(sureAction) title:@"确定"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnTag = defaultTag;
    [self refreshData];
    [self renderContents];
    _selectArray=[[NSMutableArray alloc]init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reachability];
    self.tabBarController.tabBar.hidden=YES;
}
- (void)reachability {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [self showInternetError];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            break; } }];
    [mgr startMonitoring];
    
}


- (void)renderContents {
    self.consultingCategoryTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.consultingCategoryTableView.backgroundColor = [UIColor clearColor];
    self.consultingCategoryTableView.dataSource = self;
    self.consultingCategoryTableView.delegate = self;
    //    [self.prisonerFamilesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    [self.consultingCategoryTableView registerClass:[PSFamilyTableViewCell class] forCellReuseIdentifier:@"PSFamilyTableViewCell"];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 42)];
    headerView.backgroundColor = AppBaseBackgroundColor2;
    UILabel*tipsLable=[[UILabel alloc]init];
    tipsLable.font=FontOfSize(12);
    tipsLable.textColor=AppBaseTextColor3;
    tipsLable.text=@"可多选(不超过三个)";
    [headerView addSubview:tipsLable];
    [tipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    
    self.consultingCategoryTableView .tableHeaderView = headerView;
    self.consultingCategoryTableView .tableFooterView = [UIView new];
    self.consultingCategoryTableView .separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [self.view addSubview:self.consultingCategoryTableView ];
    [self.consultingCategoryTableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT-150);
    }];
    
}




-(void)sureAction{
    if (_selectArray.count>3) {
        [PSTipsView showTips: @"咨询类别不能超过三个"];
    }
    else{
        __weak typeof(self) weakself = self;
        if (weakself.returnValueBlock) {
            weakself.returnValueBlock(_selectArray);
        }
        [self.navigationController popViewControllerAnimated:YES];
        //self.tabBarController.tabBar.hidden=YES;
        
        
        if (self.completion) {
            self.completion(YES);
        }
    }
    
}


- (void)refreshData {
    if (_categoryArr) {
        _categoryArray=[NSArray new];
        _categoryArray=_categoryArr;
    } else {
        _categoryArray=[NSArray new];
        _categoryArray=@[@"财产纠纷",@"婚姻家庭",@"交通事故",@"工伤赔偿",@"合同纠纷",@"刑事辩护",@"房产纠纷",@"劳动就业"];
    }
    
    
}





#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _categoryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PSFamilyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PSFamilyTableViewCell"];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.textLabel.font = AppBaseTextFont1;
    cell.textLabel.textColor = AppBaseTextColor1;
    cell.textLabel.text = _categoryArray[indexPath.row];
    cell.selectBtn.tag = defaultTag+indexPath.row;
    
    
    if (cell.isSelect==NO) {
        [cell.selectBtn setImage:[UIImage imageNamed:@"homeManageNormal"] forState:UIControlStateNormal];
    } else {
        [cell.selectBtn setImage:[UIImage imageNamed:@"homeManageSelected"] forState:UIControlStateNormal];
    }
    __weak PSFamilyTableViewCell *weakCell =cell;
    [weakCell setQhxSelectBlock:^(BOOL choice,NSInteger btnTag){
        if (choice) {
            [weakCell.selectBtn setImage:[UIImage imageNamed:@"homeManageSelected"] forState:UIControlStateNormal];
            self.btnTag = btnTag;
            [self.selectArray addObject:_categoryArray[btnTag-defaultTag]];
            [self.consultingCategoryTableView reloadData];
        }
        else{
            [weakCell.selectBtn setImage:[UIImage imageNamed:@"homeManageSelected"] forState:UIControlStateNormal];
            self.btnTag = btnTag;
            [self.selectArray removeObject:_categoryArray[btnTag-defaultTag]];
            [self.consultingCategoryTableView reloadData];
            
        }
        
    }];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
