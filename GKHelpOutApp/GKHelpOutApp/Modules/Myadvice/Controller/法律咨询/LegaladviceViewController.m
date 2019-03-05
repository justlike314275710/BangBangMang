//
//  LegaladviceViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/2/26.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "LegaladviceViewController.h"
#import "LegalAdviceCell.h"
#import "PSConsultationViewModel.h"
#import "PSConsultation.h"
#import "UIViewController+Tool.h"
#import "PSAdviceDetailsViewController.h"
@interface LegaladviceViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation LegaladviceViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
   // [self refreshData];
   [self renderContents];
    // Do any additional setup after loading the view.
    self.title = @"法律咨询";
   // [self setupUI];
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
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMore];
        }];
    }else{
        self.tableView.mj_footer = nil;
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}


- (void)renderContents {
    self.view.backgroundColor=UIColorFromRGBA(248, 247, 254, 1);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self refreshData];
        // [self loadMore];
    }];
  [self.tableView registerClass:[LegalAdviceCell class] forCellReuseIdentifier:@"LegalAdviceCellID"];
//    [self.tableView registerClass:[PSLawerAdviceTableViewCell class] forCellReuseIdentifier:@"PSLawerAdviceTableViewCell"];
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
self.tableView.height = KScreenHeight - kTopHeight-kTabBarHeight-50;

}


#pragma mark - PrivateMethosd
- (void)setupUI {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.height = KScreenHeight - kTopHeight-kTabBarHeight-50;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LegalAdviceCell class] forCellReuseIdentifier:@"LegalAdviceCellID"];
}

#pragma mark - Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    NSLog(@"%lu",(unsigned long)viewModel.myAdviceArray.count);
    return viewModel.myAdviceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    PSConsultation*model=viewModel.myAdviceArray[indexPath.row];
    LegalAdviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LegalAdviceCellID"];
    [self builedModel:model];
    [cell fillWithModel:model];
//    if (indexPath.row== 0) {
//        cell.noRead = YES;
//    } else {
//        cell.noRead = NO;
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    PSConsultation*Model=viewModel.myAdviceArray[indexPath.row];
    viewModel.adviceId=Model.cid;
    UIViewController *vc = [UIViewController jsd_getCurrentViewController];
    [vc.navigationController pushViewController:[[PSAdviceDetailsViewController alloc]initWithViewModel:viewModel] animated:YES];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
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

//设置模型
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
