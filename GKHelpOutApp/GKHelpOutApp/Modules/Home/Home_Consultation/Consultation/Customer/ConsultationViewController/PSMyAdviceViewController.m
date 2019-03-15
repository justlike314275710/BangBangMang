
//
//  PSRefundViewController.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/6/4.
//  Copyright © 2018年 calvin. All rights reserved.
//
#import "UIViewController+Tool.h"
#import "PSMyAdviceViewController.h"
#import "PSConsultationViewModel.h"
//#import "PSRefundViewController.h"
#import "MJRefresh.h"
//#import "NSString+Date.h"

#import "PSTipsConstants.h"
#import "PSMyAdviceTableViewCell.h"
#import "PSConsultation.h"
#import "MJExtension.h"
#import "PSCustomer.h"
//#import "PSSessionManager.h"
#import "PSAdviceDetailsViewController.h"
#import "PSLawerAdviceTableViewCell.h"
#import "LegalAdviceCell.h"

@interface PSMyAdviceViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UITableView *honorTableView;
@end

@implementation PSMyAdviceViewController

- (instancetype)initWithViewModel:(PSViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        self.title =@"我的咨询";
    }
    return self;
}

- (void)loadMore {
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    @weakify(self)
    [viewModel loadMyAdviceCompleted:^(PSResponse *response) {
        @strongify(self)
        [self reloadContents];
    } failed:^(NSError *error) {
        @strongify(self)
        [self reloadContents];
    }];
}

- (void)refreshData {
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    [[PSLoadingView sharedInstance] show];
    @weakify(self)
    [viewModel refreshMyAdviceCompleted:^(PSResponse *response) {
        @strongify(self)
        [[PSLoadingView sharedInstance] dismiss];
        [self reloadContents];
    } failed:^(NSError *error) {
        @strongify(self)
        [[PSLoadingView sharedInstance] dismiss];
        [self reloadContents];
    }];
}

- (void)reloadContents {
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    //(PSTransactionRecordViewModel *)self.viewModel;
    if (viewModel.hasNextPage) {
        @weakify(self)
        self.honorTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMore];
        }];
    }else{
        self.honorTableView.mj_footer = nil;
    }
    [self.honorTableView.mj_header endRefreshing];
    [self.honorTableView.mj_footer endRefreshing];
    [self.honorTableView reloadData];
}

- (void)renderContents {
    self.view.backgroundColor=UIColorFromRGBA(248, 247, 254, 1);
    _honorTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.honorTableView.dataSource = self;
    self.honorTableView.delegate = self;
    self.honorTableView.emptyDataSetSource = self;
    self.honorTableView.emptyDataSetDelegate = self;
    self.honorTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.honorTableView.backgroundColor = [UIColor clearColor];
    @weakify(self)
    self.honorTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self refreshData];
        // [self loadMore];
    }];
    [self.honorTableView registerClass:[PSMyAdviceTableViewCell class] forCellReuseIdentifier:@"PSMyAdviceTableViewCell"];
    [self.honorTableView registerClass:[PSLawerAdviceTableViewCell class] forCellReuseIdentifier:@"PSLawerAdviceTableViewCell"];
    [self.honorTableView registerClass:[LegalAdviceCell class] forCellReuseIdentifier:@"LegalAdviceCell"];
    self.honorTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.honorTableView];
    [self.honorTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-49-kTopHeight-44-14);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        //make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self renderContents];
    [self refreshData];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:KNotificationOrderStateChange object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshData)
                                                 name:KNotificationOrderStateChange
                                               object:nil];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    return viewModel.myAdviceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    PSConsultation*model=viewModel.myAdviceArray[indexPath.row];
    LegalAdviceCell*cell=[tableView dequeueReusableCellWithIdentifier:@"LegalAdviceCell"];
//    PSMyAdviceTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PSMyAdviceTableViewCell"];
    [self builedModel:model];
    [cell fillWithModel:model];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    PSConsultation*Model=viewModel.myAdviceArray[indexPath.row];
    viewModel.adviceId=Model.cid;
    UIViewController *vc = [UIViewController jsd_getCurrentViewController];
    [vc.navigationController pushViewController:[[PSAdviceDetailsViewController alloc]initWithViewModel:viewModel] animated:YES];
    
    
    
}

#pragma mark - DZNEmptyDataSetSource and DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    UIImage *emptyImage = viewModel.dataStatus == PSDataEmpty ? [UIImage imageNamed:@"universalNoneIcon"] : [UIImage imageNamed:@"universalNetErrorIcon"];
    return viewModel.dataStatus == PSDataInitial ? nil : emptyImage;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    
    NSString *tips = viewModel.dataStatus == PSDataEmpty ? EMPTY_CONTENT : NET_ERROR;
    return viewModel.dataStatus == PSDataInitial ? nil : [[NSAttributedString alloc] initWithString:tips attributes:@{NSFontAttributeName:AppBaseTextFont1,NSForegroundColorAttributeName:AppBaseTextColor1}];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    return viewModel.dataStatus == PSDataError ? [[NSAttributedString alloc] initWithString:@"点击加载" attributes:@{NSFontAttributeName:AppBaseTextFont1,NSForegroundColorAttributeName:AppBaseTextColor1}] : nil;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self refreshData];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- set or get
-(PSConsultation*)builedModel:(PSConsultation*)model{
    
    
    if ([model.category isEqualToString:@"PROPERTY_DISPUTES"]) {
        model.category=@"财产纠纷";
    }
    else if ([model.category isEqualToString:@"MARRIAGE_FAMILY"]){
        model.category=@"婚姻家庭";
    }
    else if ([model.category isEqualToString:@"TRAFFIC_ACCIDENT"]){
        model.category=@"交通事故";
    }
    else if ([model.category isEqualToString:@"WORK_COMPENSATION"]){
        model.category=@"工伤赔偿";
    }
    else if ([model.category isEqualToString:@"CONTRACT_DISPUTE"]){
        model.category=@"合同纠纷";
    }
    else if ([model.category isEqualToString:@"CRIMINAL_DEFENSE"]){
        model.category=@"刑事辩护";
    }
    else if ([model.category isEqualToString:@"HOUSING_DISPUTES"]){
        model.category=@"房产纠纷";
    }
    else if ([model.category isEqualToString:@"LABOR_EMPLOYMENT"]){
        model.category=@"劳动就业";
    }
    
    
    return model;
}


@end



