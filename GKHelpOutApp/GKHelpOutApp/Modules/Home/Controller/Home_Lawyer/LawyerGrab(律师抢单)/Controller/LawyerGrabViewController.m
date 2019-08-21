//
//  LawyerGrabViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "LawyerGrabViewController.h"
#import "PSLawyerView.h"
#import "LegalAdviceCell.h"
#import "lawyerGrab_Logic.h"
#import "lawyerGrab.h"
#import "Grab_customer.h"
#import "NSString+Utils.h"
#import "LawyerAdviceDetalisVC.h"
@interface LawyerGrabViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic , strong) UITableView *LawyersTableview;
@property (nonatomic , strong) PSLawyerView *headerView;
@property (nonatomic , strong) lawyerGrab_Logic*logic;
@property (nonatomic , assign) BOOL isProcessing;
@property (nonatomic , strong) NSString *orderID;
@end

@implementation LawyerGrabViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.logic=[[lawyerGrab_Logic alloc]init];
    [self getProcessing];
//    [self renderContents];
    [self refreshData];
    [self SDWebImageAuth];
    self.title=@"法律咨询";


    // Do any additional setup after loading the view.
}

-(void)getProcessing{
    @weakify(self)
    [self.logic refreshAdviceProcessingCompleted:^(id data) {
        @strongify(self)
        if (data[@"id"]&&![data[@"id"] isKindOfClass:[NSNull class]]) {
            self.isProcessing=YES;
            self.orderID=data[@"id"];
        } else {
            self.isProcessing=NO;
        }
         [self renderContents];
    } failed:^(NSError *error) {
         [self renderContents];
    }];
}


- (void)loadMore {
    // lawyerGrab_Logic*logic=[[lawyerGrab_Logic alloc]init];
    @weakify(self)
    [self.logic loadLawyerAdviceCompleted:^(id data) {
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
    [self.logic refreshLawyerAdviceCompleted:^(id data) {
         [[PSLoadingView sharedInstance] dismiss];
         [self reloadContents];
    } failed:^(NSError *error) {
         [[PSLoadingView sharedInstance] dismiss];
         [self reloadContents];
    }];
}
-(void)p_pushDetalisViewController:(NSString*)orderId{
     LawyerAdviceDetalisVC*lawyerAdviceDetalisVC=[[LawyerAdviceDetalisVC alloc]init];
    lawyerAdviceDetalisVC.cid=orderId;
    [self.navigationController pushViewController:lawyerAdviceDetalisVC animated:YES];
}
-(void)Grap_Order:(NSString*)orderID{
    [[PSLoadingView sharedInstance]show];
    self.logic.cid=orderID;
    [self.logic POSTLawyergrabCompleted:^(id data) {
        [[PSLoadingView sharedInstance]dismiss];
        //[PSTipsView showTips:@"抢单成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationNewOrderState object:nil];
        [self AlertWithTitle:@"提示" message:@"恭喜您,抢单成功!" andOthers:@[@"关闭",@"查看"] animated:YES action:^(NSInteger index) {
            if (index == 1) {
                [self p_pushDetalisViewController:orderID];
            }
            else{
                 [self refreshData];
                
            }
        }];
        
    } failed:^(NSError *error) {
        [[PSLoadingView sharedInstance]dismiss];
        [PSTipsView showTips:@"不能抢单,当前有订单未处理!"];
    }];
}


-(void)processing_Order:(NSString*)orderID{
    [self AlertWithTitle:@"提示" message:@"您有订单未处理,请先处理!" andOthers:@[@"关闭",@"查看"] animated:YES action:^(NSInteger index) {
        if (index == 1) {
            [self p_pushDetalisViewController:orderID];
        }
        else{
            [self getProcessing];
            [self refreshData];
            
            
        }
    }];
}

-(void)renderContents{
    //self.view.backgroundColor=UIColorFromRGBA(248, 247, 254, 1);
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.headerView=[PSLawyerView new];
    [self.view addSubview:self.headerView];
    [self.headerView.avatarView sd_setImageWithURL:[NSURL URLWithString:help_userManager.curUserInfo.avatar] placeholderImage:IMAGE_NAMED(@"登录－头像")];
    self.headerView.nicknameLabel.text=help_userManager.lawUserInfo.name;
    self.headerView.addressLable.text=NSStringFormat(@"执业律所:%@",help_userManager.lawUserInfo.lawOffice);
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(110);
    }];

    
    
    self.LawyersTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.LawyersTableview.showsVerticalScrollIndicator=NO;
    self.LawyersTableview.dataSource = self;
    self.LawyersTableview.delegate = self;
    self.LawyersTableview.emptyDataSetSource = self;
    self.LawyersTableview.emptyDataSetDelegate = self;
    self.LawyersTableview.tableFooterView = [UIView new];
    self.LawyersTableview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.LawyersTableview  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.LawyersTableview registerClass:[LegalAdviceCell class] forCellReuseIdentifier:@"LegalAdviceCell"];
    [self.view addSubview:self.LawyersTableview];
    [self.LawyersTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(140);//140
        make.height.mas_equalTo(SCREEN_HEIGHT-140);
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
    return self.logic.rushAdviceArray.count;
    //logic.rushAdviceArray.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    lawyerGrab*grabModel=self.logic.rushAdviceArray[indexPath.row];
    Grab_customer*customer=[Grab_customer mj_objectWithKeyValues:grabModel.customer];
    LegalAdviceCell*cell=[tableView dequeueReusableCellWithIdentifier:@"LegalAdviceCell"];
    cell.moneyLab.text=customer.name;
    cell.timeLab.text=[NSString timeChange:grabModel.createdTime];
    cell.lawyerMoneyLab.text=NSStringFormat(@"¥%@", grabModel.reward);
    [self builedModel:grabModel];
     cell.typeLab.text=grabModel.category;
//    NSString*imageUrl=[NSString stringWithFormat:@"%@/users/%@/avatar",EmallHostUrl,customer.username];
      NSString*imageUrl=[NSString stringWithFormat:@"%@/users/by-username/avatar?username=%@",EmallHostUrl,customer.username];
    [ cell.avatarImg sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:IMAGE_NAMED(@"登录－头像")];
    cell.noRead=NO;
    cell.stateImg.hidden=YES;
    cell.detailLab.hidden = YES;
    cell.chatBtn.hidden=NO;
    cell.lawyerMoneyLab.hidden=NO;
    if (_isProcessing==YES) {
        [cell.chatBtn setTitle:@"抢单" forState:0];
        [cell.chatBtn setBackgroundImage:[self imageWithColor:[UIColor grayColor]] forState:UIControlStateNormal];
        [cell.chatBtn bk_whenTapped:^{
            [self processing_Order:self.orderID];
        }];
    } else {
        [cell.chatBtn setTitle:@"抢单" forState:0];
         [cell.chatBtn setBackgroundImage:IMAGE_NAMED(@"立即沟通底") forState:UIControlStateNormal];
        [cell.chatBtn bk_whenTapped:^{
            [self Grap_Order:grabModel.cid];
        }];
    }
   
    return cell;
    
}



#pragma mark - DZNEmptyDataSetSource and DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    UIImage *emptyImage =self.logic.dataStatus == PSDataEmpty ? [UIImage imageNamed:@"universalNoneIcon"] : [UIImage imageNamed:@"universalNetErrorIcon"];
    
    return self.logic.dataStatus == PSDataInitial ? nil : emptyImage;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *tips = self.logic.dataStatus == PSDataEmpty ? @"暂无可抢订单" : NET_ERROR;
    return self.logic.dataStatus == PSDataInitial ? nil : [[NSAttributedString alloc] initWithString:tips attributes:@{NSFontAttributeName:AppBaseTextFont1,NSForegroundColorAttributeName:AppBaseTextColor1}];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return self.logic.dataStatus == PSDataError ? [[NSAttributedString alloc] initWithString:@"点击加载" attributes:@{NSFontAttributeName:AppBaseTextFont1,NSForegroundColorAttributeName:AppBaseTextColor1}] : nil;
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


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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
