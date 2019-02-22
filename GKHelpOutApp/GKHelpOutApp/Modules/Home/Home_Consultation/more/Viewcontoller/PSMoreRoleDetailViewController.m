//
//  PSMoreRoleDetailViewController.m
//  PrisonService
//
//  Created by kky on 2018/10/25.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSMoreRoleDetailViewController.h"
#import "MoreRoloCell.h"
#import "PSLawerViewModel.h"
#import "PSLawyerDetailsViewController.h"
@interface PSMoreRoleDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableview;

@end

@implementation PSMoreRoleDetailViewController

#pragma mark - CycleLife
- (instancetype)initWithViewModel:(PSViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        NSString *title = NSLocalizedString(@"legal_service", @"财务纠纷");
//        title = @"财产纠纷";
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
    [self refreshData];
}
#pragma mark - PrivateMethods
- (void)p_setUI {
    
    [self.view addSubview:self.myTableview];
    [self.myTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0,0,0,0));
    }];
    [self.myTableview registerClass:MoreRoloCell.class forCellReuseIdentifier:@"MoreRoloCell"];
    @weakify(self);
    self.myTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshData];
    }];
}

- (void)refreshData {
    PSLawerViewModel *viewModel =(PSLawerViewModel *)self.viewModel;
    [[PSLoadingView sharedInstance] show];
    @weakify(self)
    [viewModel refreshLawyerCompleted:^(PSResponse *response) {
        @strongify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            [[PSLoadingView sharedInstance] dismiss];
            [self reloadContents];
        });
    } failed:^(NSError *error) {
        @strongify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            [[PSLoadingView sharedInstance] dismiss];
            [self reloadContents];
        });
    }];
    
  
}


- (void)reloadContents {
    PSLawerViewModel *viewModel =(PSLawerViewModel *)self.viewModel;
   
    if (viewModel.hasNextPage) {
        @weakify(self)
        self.myTableview .mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMore];
        }];
    }else{
        self.myTableview .mj_footer = nil;
    }
    [self.myTableview .mj_header endRefreshing];
    [self.myTableview .mj_footer endRefreshing];
    [self.myTableview  reloadData];
}

- (void)loadMore {
   PSLawerViewModel*viewModel =(PSLawerViewModel *)self.viewModel;
    @weakify(self)
    [viewModel loadMoreLawyerCompleted:^(PSResponse *response) {
        @strongify(self)
        [self reloadContents];
    } failed:^(NSError *error) {
        @strongify(self)
        [self reloadContents];
    }];
}

#pragma mark - Delegate
//MARK:UITableViewDelegate&UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreRoloCell *cell = [[MoreRoloCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreRoloCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PSLawerViewModel*viewModel=[[PSLawerViewModel alloc]init];
    [self.navigationController pushViewController:[[PSLawyerDetailsViewController alloc]initWithViewModel:viewModel] animated:YES];
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
    }
    return _myTableview;
}




@end
