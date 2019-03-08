//
//  HMBillViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMBillViewController.h"
#import "HMBillLogic.h"
#import "HMBillCell.h"
#import "HMBillModel.h"

@interface HMBillViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UILabel *headLab;
@property(nonatomic,strong)HMBillLogic *logic;


@end

@implementation HMBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单";
    _logic = [[HMBillLogic alloc] init];
    [self setupUI];
    
}
#pragma mark - PrivateMethods

-(void)setupUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight-kTabBarHeight-kStatusBarHeight) style:UITableViewStylePlain];
    [self.tableView registerClass:[HMBillCell class] forCellReuseIdentifier:@"HMBillCell"];
    [self.view addSubview:self.tableView];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
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
    [_logic loadMyAdviceCompleted:^(id data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[PSLoadingView sharedInstance] dismiss];
            [self.tableView.mj_footer endRefreshing];
            [self setTableleUI];
            [self.tableView reloadData];
        });
    } failed:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[PSLoadingView sharedInstance] dismiss];
            [self.tableView.mj_footer endRefreshing];
            [self setTableleUI];
            [self.tableView reloadData];
        });
    }];
}

-(void)refreshData {
    [[PSLoadingView sharedInstance] show];
    [_logic refreshMyAdviceCompleted:^(id data) {
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
    HMBillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HMBillCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HMBillModel *model = _logic.datalist[indexPath.row];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
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
/*
 
 -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 2;
 }
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 55)];
    UILabel *monthLab = [[UILabel alloc] initWithFrame:CGRectMake(15,10,200,20)];
    monthLab.text = @"本月";
    monthLab.font = FFont1;
    monthLab.textColor = CFontColor1;
    monthLab.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:monthLab];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15,monthLab.bottom+2,bgView.width-30,20)];
    lable.text = @"充值¥100.00 退款¥100.00 消费¥10.00";
    lable.font = FFont1;
    lable.textColor = CFontColor2;
    lable.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:lable];
    
    return bgView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
 */









@end
