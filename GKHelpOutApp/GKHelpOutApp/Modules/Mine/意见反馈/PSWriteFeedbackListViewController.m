//
//  PSWriteFeedbackListViewController.m
//  PrisonService
//
//  Created by kky on 2018/12/24.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSWriteFeedbackListViewController.h"
#import "PSWriteFeedbackViewController.h"
#import "PSFeedbackViewModel.h"
#import "PSTipsConstants.h"
#import "UIScrollView+EmptyDataSet.h"
#import "PSFeedbackListViewModel.h"
#import "FeedbackListCell.h"
#import "PSWriteFeedbackDetailViewController.h"
#import "FeedbackTypeModel.h"
#import "UIViewController+Tool.h"

@interface PSWriteFeedbackListViewController ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableview;

@end

@implementation PSWriteFeedbackListViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {

    [super viewDidLoad];
    self.isShowLiftBack = YES;
    self.title = @"意见反馈";
    [self p_setUI];
//    [self p_refreshData];
    [self createRightBarButtonItemWithTarget:self action:@selector(p_rightAction) normalImage:[UIImage imageNamed:@"userCenterSettingFeedback"] highlightedImage:[UIImage imageNamed:@"userCenterSettingFeedback"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_refreshData) name:@"wirtefeedListfresh" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}

#pragma marl - PrivateMethods
- (void)p_setUI {
    self.view.backgroundColor=UIColorFromRGBA(248, 247, 254, 1);
    [self.view addSubview:self.myTableview];
    [self.myTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0,0,0,0));
    }];
    [self.myTableview registerClass:FeedbackListCell.class forCellReuseIdentifier:@"FeedbackListCell"];
    @weakify(self)
    self.myTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self p_refreshData];
    }];
}

- (void)p_refreshData {
    PSFeedbackListViewModel *feedbackListViewModel  =(PSFeedbackListViewModel *)self.viewModel;
    [[PSLoadingView sharedInstance]show];
    @weakify(self)
    [feedbackListViewModel refreshFeedbackListCompleted:^(PSResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            [[PSLoadingView sharedInstance] dismiss];
            [self p_reloadContents];
        });
    } failed:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            [[PSLoadingView sharedInstance] dismiss];
            [self p_reloadContents];
        });
    }];
}

- (void)p_reloadContents {
     PSFeedbackListViewModel *feedbackListViewModel  =(PSFeedbackListViewModel *)self.viewModel;
    if (feedbackListViewModel.hasNextPage) {
        @weakify(self)
        self.myTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self p_loadMore];
        }];
    }else{
        self.myTableview.mj_footer = nil;
    }
    [self.myTableview.mj_header endRefreshing];
    [self.myTableview.mj_footer endRefreshing];
    [self.myTableview reloadData];
}

- (void)p_loadMore {
    
    PSFeedbackListViewModel *feedbackListViewModel  =(PSFeedbackListViewModel *)self.viewModel;
    @weakify(self)
    [feedbackListViewModel loadMoreFeedbackListCompleted:^(PSResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            [self p_reloadContents];
        });
    } failed:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            [self p_reloadContents];
        });
    }];
}


#pragma mark - TouchEvent
- (void)p_rightAction {
    
    PSFeedbackViewModel *viewModel = [PSFeedbackViewModel new];
    viewModel.writefeedType = PSWritefeedBack;
    PSWriteFeedbackViewController *feedbackViewController = [[PSWriteFeedbackViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:feedbackViewController animated:YES];
}

#pragma mark - Delegate

//MARK:UITableViewDelegate&UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    PSFeedbackListViewModel*feedbackList  =(PSFeedbackListViewModel *)self.viewModel;
    return feedbackList.Recodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedbackListCell *feedbackListCell = [[FeedbackListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FeedbackListCell"];
    PSFeedbackListViewModel *feedbackListViewModel  =(PSFeedbackListViewModel *)self.viewModel;
    FeedbackTypeModel *model = feedbackListViewModel.Recodes[indexPath.row];
    model.writefeedType = feedbackListViewModel.writefeedType==PSWritefeedBack?@"0":@"1";
    feedbackListCell.model = model;
    return feedbackListCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PSFeedbackListViewModel *feedbackListViewModel  =(PSFeedbackListViewModel *)self.viewModel;
    FeedbackTypeModel *model = feedbackListViewModel.Recodes[indexPath.row];
    NSArray *imageUrls = [NSArray array];
    if (model.imageUrls.length > 0) {
        imageUrls = [model.imageUrls componentsSeparatedByString:@";"];
    }
    return imageUrls.count>0?190:120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PSFeedbackListViewModel *feedbackListViewModel  =(PSFeedbackListViewModel *)self.viewModel;
    FeedbackTypeModel *model = feedbackListViewModel.Recodes[indexPath.row];
    feedbackListViewModel.id = model.id;
    PSWriteFeedbackDetailViewController *feedbackDetailVC = [[PSWriteFeedbackDetailViewController alloc] initWithViewModel:feedbackListViewModel];
    UIViewController *VC = [UIViewController jsd_getCurrentViewController];
    [VC.navigationController pushViewController:feedbackDetailVC animated:YES];
//    [self.navigationController pushViewController:feedbackDetailVC animated:YES];
    
}

//MARK: DZNEmptyDataSetSource and DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    PSFeedbackListViewModel *feedbackListViewModel  =(PSFeedbackListViewModel *)self.viewModel;
    UIImage *emptyImage = feedbackListViewModel.dataStatus == PSDataEmpty ? [UIImage imageNamed:@"universalNoneIcon"] : [UIImage imageNamed:@"universalNetErrorIcon"];
    return feedbackListViewModel.dataStatus == PSDataInitial ? nil : emptyImage;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    PSFeedbackListViewModel *feedbackListViewModel  =(PSFeedbackListViewModel *)self.viewModel;
    NSString *tips = feedbackListViewModel.dataStatus == PSDataEmpty ? EMPTY_CONTENT : NET_ERROR;
    return feedbackListViewModel.dataStatus == PSDataInitial ? nil : [[NSAttributedString alloc] initWithString:tips attributes:@{NSFontAttributeName:AppBaseTextFont1,NSForegroundColorAttributeName:AppBaseTextColor1}];
    
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    PSFeedbackListViewModel *feedbackListViewModel  =(PSFeedbackListViewModel *)self.viewModel;
    return feedbackListViewModel.dataStatus == PSDataError ? [[NSAttributedString alloc] initWithString:CLICK_ADD attributes:@{NSFontAttributeName:AppBaseTextFont1,NSForegroundColorAttributeName:AppBaseTextColor1}] : nil;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self p_refreshData];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self p_refreshData];
}

#pragma mark - Setting&&Getting
- (UITableView *)myTableview {
    if (!_myTableview) {
        _myTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTableview.tableFooterView = [UIView new];
        _myTableview.backgroundColor = [UIColor clearColor];
        _myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableview.dataSource = self;
        _myTableview.delegate = self;
        _myTableview.emptyDataSetDelegate=self;
        _myTableview.emptyDataSetSource=self;
    }
    return _myTableview;
}


@end
