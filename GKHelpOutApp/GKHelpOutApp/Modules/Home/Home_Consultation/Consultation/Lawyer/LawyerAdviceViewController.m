//
//  LawyerGrabViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "LawyerAdviceViewController.h"
#import "PSLawyerView.h"
#import "LegalAdviceCell.h"
#import "lawyerGrab_Logic.h"
#import "lawyerGrab.h"
#import "Grab_customer.h"
#import "NSString+Utils.h"
#import "LawyerAdviceTableViewCell.h"
#import "UIViewController+Tool.h"
#import "LawyerAdviceDetalisViewController.h"
#import "LawyerAdviceDetalisVC.h"
@interface LawyerAdviceViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic , strong) UITableView *LawyersTableview;
@property (nonatomic , strong) PSLawyerView *headerView;
@property (nonatomic , strong) lawyerGrab_Logic*logic;
@end

@implementation LawyerAdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logic=[[lawyerGrab_Logic alloc]init];
    [self renderContents];
    [self refreshData];
    [self SDWebImageAuth];
}


- (void)loadMore {
    @weakify(self)
    [self.logic loadMygrabCompleted:^(id data) {
        @strongify(self)
        [self reloadContents];
    } failed:^(NSError *error) {
        @strongify(self)
        [self reloadContents];
    }];
}

- (void)refreshData {
    //lawyerGrab_Logic*logic=[[lawyerGrab_Logic alloc]init];
    [[PSLoadingView sharedInstance] show];
    [self.logic GETMygrabCompleted:^(id data) {
        [[PSLoadingView sharedInstance] dismiss];
        [self reloadContents];
    } failed:^(NSError *error) {
        [[PSLoadingView sharedInstance] dismiss];
        [self reloadContents];
    }];
    
}



-(void)renderContents{
    self.view.backgroundColor=UIColorFromRGBA(248, 247, 254, 1);

    self.LawyersTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.LawyersTableview.showsVerticalScrollIndicator=NO;
    self.LawyersTableview.dataSource = self;
    self.LawyersTableview.delegate = self;
    self.LawyersTableview.emptyDataSetSource = self;
    self.LawyersTableview.emptyDataSetDelegate = self;
    self.LawyersTableview.tableFooterView = [UIView new];
    [self.LawyersTableview  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.LawyersTableview registerClass:[LawyerAdviceTableViewCell class] forCellReuseIdentifier:@"LawyerAdviceTableViewCell"];
    [self.view addSubview:self.LawyersTableview];
    [self.LawyersTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    @weakify(self)
    self.LawyersTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self refreshData];
    }];
}

- (void)reloadContents {
    //lawyerGrab_Logic*logic=[[lawyerGrab_Logic alloc]init];
    if (self.logic.hasNextPage) {
        @weakify(self)
        self.LawyersTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMore];
        }];
    }else{
        self.LawyersTableview.mj_footer = nil;
    }
    [self.LawyersTableview.mj_header endRefreshing];
    [self.LawyersTableview.mj_footer endRefreshing];
    [self.LawyersTableview reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.logic.myAdviceArray.count;
    //logic.rushAdviceArray.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    lawyerGrab*grabModel=self.logic.myAdviceArray[indexPath.row];
    Grab_customer*customer=[Grab_customer mj_objectWithKeyValues:grabModel.customer];
    LawyerAdviceTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"LawyerAdviceTableViewCell"];
    cell.moneyLab.text=customer.name;
    cell.timeLab.text=[NSString timeChange:grabModel.createdTime];
    cell.lawyerMoneyLab.text=NSStringFormat(@"¥%@", grabModel.reward);
    [self builedModel:grabModel];
    cell.typeLab.text=grabModel.category;
    NSString*imageUrl=[NSString stringWithFormat:@"%@/users/%@/avatar",EmallHostUrl,customer.username];
    [ cell.avatarImg sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:IMAGE_NAMED(@"lawHead")];
    cell.noRead=NO;
    cell.stateImg.hidden=NO;
    cell.detailLab.hidden = YES;
    cell.chatBtn.hidden=NO;
    cell.lawyerMoneyLab.hidden=NO;
    [cell fillWithModel:grabModel];
    [cell.chatBtn bk_whenTapped:^{
       
    }];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    lawyerGrab*grabModel=self.logic.myAdviceArray[indexPath.row];
    LawyerAdviceDetalisVC*lawyerAdviceDetalisVC=[[LawyerAdviceDetalisVC alloc]init];
    lawyerAdviceDetalisVC.cid=grabModel.cid;
    UIViewController *vc = [UIViewController jsd_getCurrentViewController];
    [vc.navigationController pushViewController:lawyerAdviceDetalisVC animated:YES];
}



#pragma mark - DZNEmptyDataSetSource and DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    lawyerGrab_Logic*logic=[[lawyerGrab_Logic alloc]init];
    UIImage *emptyImage = logic.dataStatus == PSDataEmpty ? [UIImage imageNamed:@"universalNoneIcon"] : [UIImage imageNamed:@"universalNetErrorIcon"];
    return logic.dataStatus == PSDataInitial ? nil : emptyImage;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    lawyerGrab_Logic*logic=[[lawyerGrab_Logic alloc]init];
    NSString *tips = logic.dataStatus == PSDataEmpty ? EMPTY_CONTENT : NET_ERROR;
    return logic.dataStatus == PSDataInitial ? nil : [[NSAttributedString alloc] initWithString:tips attributes:@{NSFontAttributeName:AppBaseTextFont1,NSForegroundColorAttributeName:AppBaseTextColor1}];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    lawyerGrab_Logic*logic=[[lawyerGrab_Logic alloc]init];
    return logic.dataStatus == PSDataError ? [[NSAttributedString alloc] initWithString:@"点击加载" attributes:@{NSFontAttributeName:AppBaseTextFont1,NSForegroundColorAttributeName:AppBaseTextColor1}] : nil;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self refreshData];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self refreshData];
}




#pragma mark ————— 设置SDWebImage认证token —————
-(void)SDWebImageAuth{
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [SDWebImageManager.sharedManager.imageDownloader setValue:token forHTTPHeaderField:@"Authorization"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 构造模型--
-(lawyerGrab*)builedModel:(lawyerGrab*)model{
    
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
