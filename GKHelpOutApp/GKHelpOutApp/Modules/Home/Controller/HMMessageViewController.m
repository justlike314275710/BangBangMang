//
//  HMMessageViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMMessageViewController.h"
#import "HMMessageCellTableViewCell.h"
#import "HMMessageLogic.h"

@interface HMMessageViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)HMMessageLogic *logic;

@end

@implementation HMMessageViewController
#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    _logic = [HMMessageLogic new];
    [self setupUI];
}


#pragma mark - PrivateMethods
-(void)setupUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight-kTabBarHeight-kStatusBarHeight) style:UITableViewStylePlain];
    [self.tableView registerClass:[HMMessageCellTableViewCell class] forCellReuseIdentifier:@"HMMessageCellTableViewCell"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;

    [self.view addSubview:self.tableView];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self refreshData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    [self setTableleUI];
    
}
-(void)setTableleUI {
    @weakify(self);
    if (_logic.hasNextPage) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMore];
        }];
    }else{
        self.tableView.mj_footer = nil;
    }
}
-(void)loadMore {
    [[PSLoadingView sharedInstance] show];
    [_logic loadMyMessageListCompleted:^(id data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[PSLoadingView sharedInstance] dismiss];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            [self setTableleUI];
        });
    } failed:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[PSLoadingView sharedInstance] dismiss];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            [self setTableleUI];
        });
    }];
}

-(void)refreshData {
    [[PSLoadingView sharedInstance] show];
    [_logic refreshMesagaeListCompleted:^(id data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            [self setTableleUI];
            [[PSLoadingView sharedInstance] dismiss];
        });
    } failed:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            [self setTableleUI];
            [[PSLoadingView sharedInstance] dismiss];
        });
    }];
}

#pragma mark - Delegate
//MARK:UITableViewDataSource&UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _logic.datalist.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HMMessageCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HMMessageCellTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HMMessageModel *model = _logic.datalist[indexPath.row];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

#pragma mark - DZNEmptyDataSetSource and DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    UIImage *emptyImage = _logic.dataStatus == PSDataEmpty ? [UIImage imageNamed:@"universalNoneIcon"] : [UIImage imageNamed:@"universalNetErrorIcon"];
    return _logic.dataStatus == PSDataInitial ? nil : emptyImage;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *tips = _logic.dataStatus == PSDataEmpty ? EMPTY_CONTENT : NET_ERROR;
    return _logic.dataStatus == PSDataInitial ? nil : [[NSAttributedString alloc] initWithString:tips attributes:@{NSFontAttributeName:AppBaseTextFont1,NSForegroundColorAttributeName:AppBaseTextColor1}];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    return _logic.dataStatus == PSDataError ? [[NSAttributedString alloc] initWithString:@"点击加载" attributes:@{NSFontAttributeName:AppBaseTextFont1,NSForegroundColorAttributeName:AppBaseTextColor1}] : nil;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self refreshData];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self refreshData];
}



@end
