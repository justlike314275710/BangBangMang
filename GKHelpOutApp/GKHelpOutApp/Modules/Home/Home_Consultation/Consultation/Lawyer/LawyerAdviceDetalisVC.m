//
//  LawyerAdviceDetalisVC.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/11.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "LawyerAdviceDetalisVC.h"
#import "lawyerGrab_Logic.h"
#import "PSConsultation.h"
#import "PSCustomer.h"
#import "headerDetailsView.h"
#import "NSString+Utils.h"
#import "PSAdviceComments.h"
#import "CDZStarsControl.h"
@interface LawyerAdviceDetalisVC ()
@property (nonatomic , strong) lawyerGrab_Logic *logic;
@property (nonatomic , strong) PSConsultation *model;
@property (nonatomic , strong) PSCustomer *customerModel;
@property (nonatomic , strong) PSAdviceComments*comments ;

@property (nonatomic , strong) UIScrollView *myScrollview;
@property (nonatomic , strong) headerDetailsView *detailsView;
@property (nonatomic , strong) UIView *paymentView;
@property (nonatomic , strong) UILabel *paymentLable;
@property (nonatomic , strong) UILabel *statusLable;
@property (nonatomic , strong) UILabel *statusTimeLable;
@property (nonatomic , strong) UILabel *processedTimeLable;

@property (nonatomic , strong) UIView *statusView;//律师赏金
@property (nonatomic , strong) UILabel*moneystatusLable;
@property (nonatomic , strong) UIView* commentsView;

@property (nonatomic , strong) UILabel*tipsLable;
@property (nonatomic , strong) UIButton*payButton;
@end

@implementation LawyerAdviceDetalisVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    [self refreshData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"咨询详情";
    self.logic=[[lawyerGrab_Logic alloc]init];
    self.isShowLiftBack = YES;
    [self SDWebImageAuth];
    
}

-(void)chattingAcion{
    self.logic.cid=self.cid;
    [self.logic GETProcessedCompleted:^(id data) {
        [PSTipsView showTips:@"模拟通话成功!"];
        [self refreshData];
    } failed:^(NSError *error) {
        [PSTipsView showTips:@"模拟通话失败!"];
    }];
}

- (void)refreshData {
    self.logic.cid=self.cid;
    @weakify(self)
    [[PSLoadingView sharedInstance]show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.logic GETLawyerDetailsCompleted:^(id data) {
            @strongify(self)
            dispatch_async(dispatch_get_main_queue(), ^{
                self.model=[PSConsultation mj_objectWithKeyValues:data];
                self.customerModel=[PSCustomer mj_objectWithKeyValues:self.model.customer];
                [self buildModel:self.model];
                [self renderContents];
                [[PSLoadingView sharedInstance]dismiss];
            });
        } failed:^(NSError *error) {
            [[PSLoadingView sharedInstance]dismiss];
            [self renderContents];
        }];
        
    });
}

//获取评论
-(void)getComments{
    self.logic.cid=self.cid;
    [self.logic requestCommentsCompleted:^(id data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.comments=[PSAdviceComments mj_objectWithKeyValues:data];
            [self p_commentsUI];
        });
//        self.comments=[PSAdviceComments mj_objectWithKeyValues:data];
//        [self p_commentsUI];
    } failed:^(NSError *error) {
        
    }];
}

-(void)DeleteLawyerDetails{
    [self.logic deleteConsultationCompleted:^(id data) {
        [PSTipsView showTips:@"删除订单成功!"];
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSError *error) {
        [PSTipsView showTips:@"删除订单失败!"];
    }];
}

-(void)p_commentsUI{
    _commentsView=[UIView new];
    [_myScrollview addSubview:_commentsView];
    _commentsView.frame=CGRectMake(0, 445, SCREEN_WIDTH, 50);
    _commentsView.backgroundColor=[UIColor whiteColor];
    UILabel*commentsTitle=[[UILabel alloc]initWithFrame:CGRectMake(15, 15,65 , 20)];
    [_commentsView addSubview:commentsTitle];
    commentsTitle.text=@"律师服务:";
    commentsTitle.font=FontOfSize(14);
    commentsTitle.textColor=[UIColor blackColor];
    
    
    CDZStarsControl*starsControl = [CDZStarsControl.alloc initWithFrame:CGRectMake(90, 14, 80 , 20) stars:4 starSize:CGSizeMake(15, 15) noramlStarImage:[UIImage imageNamed:@"灰星星"] highlightedStarImage:[UIImage imageNamed:@"黄星星"]];
    starsControl.score=[self.comments.rate intValue];
    starsControl.delegate = self;
    starsControl.allowFraction = YES;
    starsControl.enabled=NO;
    [_commentsView addSubview:starsControl];
    
    UILabel*isResolvedLable=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-95, 15, 80, 15)];
    if ([self.comments.isResolved isEqualToString:@"1"]) {
        isResolvedLable.text=@"已解决问题";
    } else {
        isResolvedLable.text=@"未解决问题";
    }
    
    isResolvedLable.font=FontOfSize(14);
    isResolvedLable.textColor=[UIColor blackColor];
    [_commentsView addSubview:isResolvedLable];
    
    UILabel*contentLable=[[UILabel alloc]initWithFrame:CGRectMake(15, 50, SCREEN_WIDTH-24, 33)];
    [_commentsView addSubview:contentLable];
    contentLable.text=self.comments.content.length>0?[NSString stringWithFormat:@"服务评价:%@",self.comments.content]:@"服务评价:此用户没有填写评价";
    contentLable.font=FontOfSize(12);
    contentLable.textColor=AppBaseTextColor1;
    
}

-(void)renderContents{
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.myScrollview];
    [self.myScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-70);
    }];
    
    self.detailsView=[[headerDetailsView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 124)];
    [_myScrollview addSubview:self.detailsView];
    self.detailsView.namelable.text=self.customerModel.name;
    self.detailsView.catagoylable.text=self.model.category;
    self.detailsView.moneylable.text=NSStringFormat(@"¥%@",self.model.reward);
    self.detailsView.numberlable.text=NSStringFormat(@"编号:%@",self.model.number);
    self.detailsView.timelable.text=[NSString timeChange:self.model.createdTime];
    NSString*imageUrl=[NSString stringWithFormat:@"%@/users/%@/avatar",EmallHostUrl,self.customerModel.username];
    [self.detailsView.avaterImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"登录－头像"]];
    [self.myScrollview addSubview:self.paymentView];
    
    if ([self.model.status isEqualToString:@"已接单"]) {
        [self.view addSubview:self.payButton];
        [self.payButton bk_whenTapped:^{
        [self chattingAcion];}];
        
    }
    else if ([self.model.status isEqualToString:@"处理中"]){
         [self.myScrollview addSubview:self.statusView];
         [self.view addSubview:self.payButton];
        [self.payButton bk_whenTapped:^{
            [self chattingAcion];
        }];
    }
    else if ([self.model.status isEqualToString:@"已完成"]){
        [self.myScrollview addSubview:self.statusView];
        _moneystatusLable.text=@"赏金到账";
        _tipsLable.font=FontOfSize(12);
        NSString*endTime=[NSString timeChange:self.model.endTime];
        _tipsLable.text=NSStringFormat(@"到账时间:%@",endTime);
         [self getComments];
        [self.payButton setTitle:@"删除订单" forState:0];
        [self.view addSubview:self.payButton];
        [self.payButton bk_whenTapped:^{
         [self DeleteLawyerDetails];
        }];
        
    }
    else if ([self.model.status isEqualToString:@"已关闭"]){
        [self.myScrollview addSubview:self.statusView];
        _moneystatusLable.text=@"赏金到账";
        NSString*endTime=[NSString timeChange:self.model.endTime];
        _tipsLable.font=FontOfSize(12);
        _tipsLable.text=NSStringFormat(@"到账时间:%@",endTime);
         [self getComments];
        [self.payButton setTitle:@"删除订单" forState:0];
        [self.view addSubview:self.payButton];
        [self.payButton bk_whenTapped:^{
            [self DeleteLawyerDetails];

        }];
    }
    else{
        [self.myScrollview addSubview:self.statusView];
    }
    
    
    
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - setting&&getting
- (UIScrollView *)myScrollview {
    if (!_myScrollview) {
        _myScrollview = [[UIScrollView alloc] init];
        _myScrollview.contentSize = CGSizeMake(self.view.mj_w,140*4+80);
    }
    return _myScrollview;
}


- (UIButton *)payButton{
    if (!_payButton) {
        _payButton=[[UIButton alloc]initWithFrame:CGRectMake(18, SCREEN_HEIGHT-130, SCREEN_WIDTH-36, 44)];
        [_payButton setBackgroundColor:AppBaseTextColor3];
        [_payButton setTitle:@"立即沟通" forState:0];
        _payButton.titleLabel.font=FontOfSize(14);
        _payButton.layer.masksToBounds = YES;
        _payButton.layer.cornerRadius = 4.0;
    }
    return _payButton;
}

- (UIView *)paymentView{
    if (!_paymentView) {
        _paymentView=[UIView new];
        _paymentView=[[UIView alloc]initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH, 190)];
        
        _paymentLable=[UILabel new];
        [_paymentView addSubview:_paymentLable];
        [ _paymentLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(16);
        }];
        _paymentLable.text=@"已支付";
         _paymentLable.textColor=UIColorFromRGB(1, 136, 42);
         _paymentLable.textAlignment=NSTextAlignmentLeft;
        _paymentLable.font=FontOfSize(14);
        
        
        
        UILabel*payTips=[UILabel new];
        [_paymentView addSubview:payTips];
        [payTips mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.paymentLable.mas_bottom).offset(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(48);
        }];
        payTips.text=@"＊三天内无人接单，系统自动取消 ;\n  无人接单／律师拒单后，付款金额将于7个工作日内原路返回。\n  每笔订单视频通话时长为20分钟，通话时长未用完结束;\n  订单一律不退还费用!";
        payTips.numberOfLines=0;
        payTips.textColor=AppBaseTextColor1;
        payTips.font=FontOfSize(10);
        
        
//        UIView*payTipsLine=[UIView new];
//        payTipsLine.backgroundColor =[UIColor groupTableViewBackgroundColor];
//        [_paymentView addSubview:payTipsLine];
//        [payTipsLine mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(15);
//            make.right.mas_equalTo(-15);
//            make.top.mas_equalTo(payTips.mas_bottom).offset(10);
//            make.height.mas_equalTo(2);
//        }];
        
        
        _statusLable=[UILabel new];
        [_paymentView addSubview:_statusLable];
        [ _statusLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(payTips.mas_bottom).offset(50);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(16);
        }];
        _statusLable.text=self.model.status;
        _statusLable.textColor=AppBaseTextColor3;
        _statusLable.textAlignment=NSTextAlignmentLeft;
        _statusLable.font=FontOfSize(14);
        
       _statusTimeLable=[UILabel new];
        [_paymentView addSubview:_statusTimeLable];
        [ _statusTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.statusLable.mas_bottom).offset(15);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(16);
        }];
        NSString*acceptTime=[NSString timeChange:self.model.acceptedTime];
        _statusTimeLable.text=NSStringFormat(@"接单时间:%@",acceptTime);
      
        _statusTimeLable.textColor=AppBaseTextColor1;
        _statusTimeLable.textAlignment=NSTextAlignmentLeft;
        _statusTimeLable.font=FontOfSize(12);
        
        _processedTimeLable=[UILabel new];
        [_paymentView addSubview:_processedTimeLable];
        [  _processedTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.statusTimeLable.mas_bottom).offset(15);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(16);
        }];
        NSString*processedTime=[NSString timeChange:self.model.processedTime];
        _processedTimeLable.text=self.model.processedTime?NSStringFormat(@"完成时间:%@",processedTime):@"";
         _processedTimeLable.textColor=AppBaseTextColor1;
         _processedTimeLable.textAlignment=NSTextAlignmentLeft;
         _processedTimeLable.font=FontOfSize(12);
        
    }
    return _paymentView;
}


- (UIView *)statusView{
    if (!_statusView) {
        _statusView=[UIView new];
        _statusView=[[UIView alloc]initWithFrame:CGRectMake(0, 380, SCREEN_WIDTH, 65)];
        
        
        _moneystatusLable=[UILabel new];
        [_statusView addSubview: _moneystatusLable];
        [ _moneystatusLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(16);
        }];
        _moneystatusLable.text=self.model.status;
        _moneystatusLable.textColor=UIColorFromRGB(255, 112, 17);
        _moneystatusLable.textAlignment=NSTextAlignmentLeft;
        _moneystatusLable.font=FontOfSize(14);
        
        
        _tipsLable=[UILabel new];
        [_statusView addSubview: _tipsLable];
        [  _tipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.moneystatusLable.mas_bottom).offset(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(16);
        }];
         _tipsLable.text=@"＊三小时内无再次咨询，系统将自动结束订单;";
         _tipsLable.textColor=AppBaseTextColor1;
         _tipsLable.textAlignment=NSTextAlignmentLeft;
         _tipsLable.font=FontOfSize(10);
        
    }
    return _statusView;
}

-(PSConsultation*)buildModel:(PSConsultation*)model{
    NSMutableArray*array=[NSMutableArray new];
    
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
    
    
    if ([model.status isEqualToString:@"PENDING_PAYMENT"]) {
        model.status=@"待付款";
    }
    else if ([model.status isEqualToString:@"PENDING_APPROVAL"]){
        model.status=@"待审核";
    }
    else if ([model.status isEqualToString:@"PENDING_ACCEPT"]){
        model.status=@"待接单";
    }
    else if ([model.status isEqualToString:@"ACCEPTED"]){
        model.status=@"已接单";
    }
    else if ([model.status isEqualToString:@"PROCESSING"]){
        model.status=@"处理中";
    }
    
    else if ([model.status isEqualToString:@"COMPLETE"]){
        model.status=@"已完成";
    }
    else if ([model.status isEqualToString:@"CLOSED"]){
        model.status=@"已关闭";
    }
    else if([model.status isEqualToString:@"CANCELLED"]){
        model.status=@"已取消";
    }
    model.categories=array;
    return model;
}


#pragma mark ————— 设置SDWebImage认证token —————
-(void)SDWebImageAuth{
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [SDWebImageManager.sharedManager.imageDownloader setValue:token forHTTPHeaderField:@"Authorization"];
    [SDWebImageManager sharedManager].imageCache.config.maxCacheAge=5*60.0;
    
    
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
