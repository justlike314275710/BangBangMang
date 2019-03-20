//
//  PSLawyerDetailsViewController.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/2.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSLawyerDetailsViewController.h"
#import "PSLawyerView.h"
#import "MoreRoloCell.h"
#import "PSEvaluateTableViewCell.h"
@interface PSLawyerDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *LawyersTableview;
@property (nonatomic , strong) PSLawyerView *headerView;
@end

@implementation PSLawyerDetailsViewController

#pragma mark  - life cycle

- (instancetype)initWithViewModel:(PSViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
       
        self.title = @"律师详情";
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderContents];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  - notification

#pragma mark  - action

#pragma mark  - UITableViewDelegate
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH-30, 30)];
    headerView.backgroundColor=UIColorFromRGBA(248, 247, 254, 1);
    headerView.backgroundColor=[UIColor clearColor];
    UILabel*evaluateLable=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 180, 20)];
    evaluateLable.text=@"用户评价(100)";
    evaluateLable.font=FontOfSize(14);
    evaluateLable.textColor=[UIColor blackColor];
    [headerView addSubview:evaluateLable];

    UILabel*moreEvaluateLable=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-85, 5, 70, 20)];
    moreEvaluateLable.text=@"所有评价";
    moreEvaluateLable.font=FontOfSize(12);
    moreEvaluateLable.textColor=AppBaseTextColor3;
    [headerView addSubview:moreEvaluateLable];


    return headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PSEvaluateTableViewCell *cell = [[PSEvaluateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PSEvaluateTableViewCell"];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.pinmoneyTableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


/*
#pragma mark - DZNEmptyDataSetSource and DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    PSPinmoneyViewModel *PinmoneyViewModel  =(PSPinmoneyViewModel *)self.viewModel;
    UIImage *emptyImage = PinmoneyViewModel.dataStatus == PSDataEmpty ? [UIImage imageNamed:@"universalNoneIcon"] : [UIImage imageNamed:@"universalNetErrorIcon"];
    return PinmoneyViewModel.dataStatus == PSDataInitial ? nil : emptyImage;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    PSPinmoneyViewModel *PinmoneyViewModel  =(PSPinmoneyViewModel *)self.viewModel;
    NSString *tips = PinmoneyViewModel.dataStatus == PSDataEmpty ? EMPTY_CONTENT : NET_ERROR;
    return PinmoneyViewModel.dataStatus == PSDataInitial ? nil : [[NSAttributedString alloc] initWithString:tips attributes:@{NSFontAttributeName:AppBaseTextFont1,NSForegroundColorAttributeName:AppBaseTextColor1}];
    
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    PSPinmoneyViewModel *PinmoneyViewModel  =(PSPinmoneyViewModel *)self.viewModel;
    return PinmoneyViewModel.dataStatus == PSDataError ? [[NSAttributedString alloc] initWithString:@"点击加载" attributes:@{NSFontAttributeName:AppBaseTextFont1,NSForegroundColorAttributeName:AppBaseTextColor1}] : nil;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self refreshData];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self refreshData];
}

*/
#pragma mark  - UI
- (void)renderContents {
    self.view.backgroundColor=UIColorFromRGBA(248, 247, 254, 1);
    self.headerView=[PSLawyerView new];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(140);
    }];
    

    self.LawyersTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.LawyersTableview.showsVerticalScrollIndicator=NO;
    self.LawyersTableview.dataSource = self;
    self.LawyersTableview.delegate = self;
    self.LawyersTableview.tableFooterView = [UIView new];
    [self.LawyersTableview  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.LawyersTableview registerClass:[PSEvaluateTableViewCell class] forCellReuseIdentifier:@"PSEvaluateTableViewCell"];
    self.LawyersTableview.tableFooterView = [UIView new];
    [self.view addSubview:self.LawyersTableview];
    [self.LawyersTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(230);
        make.height.mas_equalTo(125);
    }];
    
    UIButton*ConsultationButton=[UIButton new];
    ConsultationButton.backgroundColor=AppBaseTextColor3;
    [ConsultationButton setTitleColor:[UIColor whiteColor] forState:0];
    [ConsultationButton setTitle:@"立即咨询" forState:0];
    ConsultationButton.titleLabel.font=FontOfSize(14);
    [self.view addSubview:ConsultationButton];
    [ConsultationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-30);
        make.height.mas_equalTo(44);
    }];
    
    
}


#pragma mark  - setter & getter



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
