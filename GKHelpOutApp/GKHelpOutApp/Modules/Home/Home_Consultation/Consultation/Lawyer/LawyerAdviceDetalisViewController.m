//
//  PSAdviceDetailsViewController.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/6.
//  Copyright © 2018年 calvin. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import "PSConsultationViewModel.h"
#import "PSConsultation.h"
#import "MJExtension.h"
#import "PSAdviceDetailsView.h"
//#import "PSSessionManager.h"
#import "PSScoreViewController.h"
#import "PSEvaluateViewmodel.h"
#import "PSPhoneCardViewModel.h"
#import "PSPayView.h"
#import "PSPayCenter.h"
#import "PSPayInfo.h"
#import "PSAttachments.h"
//#import "PSchatViewController.h"
//#import "NIMSessionViewController.h"
//#import "NTESSessionConfig.h"
//#import "NTESAttachment.h"
#import "PSLawer.h"
//#import "PSBusinessConstants.h"
#import "NSString+Utils.h"
#import "PSAdviceComments.h"
#import "CDZStarsControl.h"
#import "UITextView+Placeholder.h"
#import "PSAlertView.h"
#import "LawyerAdviceDetalisViewController.h"
#import "lawyerGrab_Logic.h"
@interface LawyerAdviceDetalisViewController ()<CDZStarsControlDelegate,UITextViewDelegate>
@property (nonatomic , strong) PSConsultation *model;
@property (nonatomic , strong) PSLawer *layerModel;
@property (nonatomic , strong) PSAdviceDetailsView *detailsView;

@property (nonatomic , assign) NSInteger index;
@property (nonatomic , strong) UIScrollView *myScrollview;
@property (nonatomic , strong) PSAdviceComments*comments ;
@property (nonatomic , strong) CDZStarsControl *starsControl;
@property (nonatomic , strong) UIButton *noButton;
@property (nonatomic , strong) UIButton *yesButton;

@property (nonatomic , strong)  UIView*bgView;
@property (nonatomic , strong)  UILabel*statusLable ;
@property (nonatomic , strong)  UIButton*sendButton ;

@property (nonatomic , strong)  UILabel*creatTimeLable;
@property (nonatomic , strong)  UILabel*endLable ;

@property (nonatomic , strong) UIButton*messageButton ;
@property (nonatomic , strong) UIButton*endButton ;
@property (nonatomic , strong) UIView* commentsView;
@property (nonatomic , strong) lawyerGrab_Logic *logic;
@end

@implementation LawyerAdviceDetalisViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    [self refreshData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.logic=[[lawyerGrab_Logic alloc]init];
    self.isShowLiftBack = YES;
    
}
#pragma mark -- 网络请求
-(void)checkDataIsEmpty{
    @weakify(self)
    [self.logic  checkEvaluateDataWithCallback:^(BOOL successful, NSString *tips) {
        @strongify(self)
        if (successful) {
            [self addAdviceEvaluate];
        } else {
            [PSTipsView showTips:tips];
        }
    }];
}

-(void)addAdviceEvaluate{

}


//获取评论
//-(void)getComments{
//    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
//    [viewModel requestCommentsCompleted:^(PSResponse *response) {
//        self.comments=[PSAdviceComments mj_objectWithKeyValues:response];
//        [self p_commentsUI];
//
//    } failed:^(NSError *error) {
//
//    }];
//}


-(void)chatAtion{
//    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
//    [viewModel GETProcessedCompleted:^(id data) {
//        [PSTipsView showTips:@"通话完成!"];
//    } failed:^(NSError *error) {
//        [PSTipsView showTips:@"通话失败!"];
//    }];
   
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
                self.layerModel=[PSLawer mj_objectWithKeyValues:self.model.lawyer];
                [self buildModel:self.model];
                [self renderContents];
                [[PSLoadingView sharedInstance]dismiss];
                NSLog(@"%@",self.model.videoDuration);
            });
        } failed:^(NSError *error) {
            [[PSLoadingView sharedInstance]dismiss];
            [self renderContents];
        }];
    
    });
}



#pragma mark -- UI
- (void)renderContents {
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [SDWebImageManager.sharedManager.imageDownloader setValue:token forHTTPHeaderField:@"Authorization"];
    [self.view addSubview:self.myScrollview];
    [self.myScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-70);
    }];
    self.detailsView=[[PSAdviceDetailsView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 124)];
    [_myScrollview addSubview:self.detailsView];
    if (self.model.reward) {
        self.detailsView.rewardLable.text=[NSString stringWithFormat:@"¥%@",self.model.reward];
    } else {
    }
    if ([self.model.status isEqualToString:@"已接单"]) {
        self.detailsView.categoryButton.hidden=YES;
        
        self.detailsView.payStatusLable.text=self.model.paymentStatus;
        if ([self.model.paymentStatus isEqualToString:@"已支付"]) {
            [self.detailsView.payStatusLable setTextColor:UIColorFromRGB(1,136,42)];
        } else if([self.model.paymentStatus isEqualToString:@"待支付"]) {
            [self.detailsView.payStatusLable setTextColor:UIColorFromRGB(255,138,7)];
        }
        
        
        self.detailsView.lawerTimeLabel.text=[NSString stringWithFormat:@"执业律所:%@",self.layerModel.lawOffice];
        self.detailsView.numberLable.text=[NSString stringWithFormat:@"编号:%@",self.model.number];
        self.detailsView.nicknameLabel.text=self.layerModel.name?self.layerModel.name:@"";
        self.detailsView.starsControl.score=[self.layerModel.rate integerValue];
        if (self.layerModel.username) {
            NSString*imageUrl=[NSString stringWithFormat:@"%@/users/%@/avatar",EmallHostUrl,self.layerModel.username];
            [self.detailsView.avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        }
        else{
            [self setupHeadImg:self.model.category];
        }
    }
    
    else if ([self.model.status isEqualToString:@"已完成"]){
        self.detailsView.categoryButton.hidden=YES;
        self.detailsView.numberLable.text=[NSString stringWithFormat:@"编号:%@",self.model.number];
        self.detailsView.starsControl.score=[self.layerModel.rate integerValue];
        self.detailsView.lawerTimeLabel.text=[NSString stringWithFormat:@"执业律所:%@",self.layerModel.lawOffice];
        self.detailsView.nicknameLabel.text=self.layerModel.name?self.layerModel.name:@"";
        self.detailsView.payStatusLable.text=self.model.paymentStatus;
        
        if ([self.model.paymentStatus isEqualToString:@"已支付"]) {
            [self.detailsView.payStatusLable setTextColor:UIColorFromRGB(1,136,42)];
        } else if([self.model.paymentStatus isEqualToString:@"待支付"]) {
            [self.detailsView.payStatusLable setTextColor:UIColorFromRGB(255,138,7)];
        }
        
        if (self.layerModel.avatarFileId) {
            NSString*imageUrl=[NSString stringWithFormat:@"%@/files/%@",EmallHostUrl,self.layerModel.avatarFileId];
            [self.detailsView.avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        }
        else{
            [self setupHeadImg:self.model.category];
        }
    }
    else if ([self.model.status isEqualToString:@"已关闭"]){
        self.detailsView.categoryButton.hidden=YES;
        self.detailsView.numberLable.text=[NSString stringWithFormat:@"编号:%@",self.model.number];
        self.detailsView.starsControl.score=[self.layerModel.rate integerValue];
        self.detailsView.lawerTimeLabel.text=[NSString timeChange:self.model.endTime];
        self.detailsView.nicknameLabel.text=        self.detailsView.nicknameLabel.text=self.layerModel.name?self.layerModel.name:@"";
        self.detailsView.payStatusLable.text=self.model.paymentStatus;
        
        if ([self.model.paymentStatus isEqualToString:@"已支付"]) {
            [self.detailsView.payStatusLable setTextColor:UIColorFromRGB(1,136,42)];
        } else if([self.model.paymentStatus isEqualToString:@"待支付"]) {
            [self.detailsView.payStatusLable setTextColor:UIColorFromRGB(255,138,7)];
        }
        
        if (self.layerModel.avatarFileId) {
            NSString*imageUrl=[NSString stringWithFormat:@"%@/files/%@",EmallHostUrl,self.layerModel.avatarFileId];
            [self.detailsView.avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
        } else {
            [self setupHeadImg:self.model.category];
        }
    }
    else if ([self.model.status isEqualToString:@"待接单"]){
        self.detailsView.starsControl.hidden=YES;
        self.detailsView.titleLable.hidden=YES;
        self.detailsView.categoryButton.hidden=NO;
        self.detailsView.numberLable.text=[NSString stringWithFormat:@"编号:%@",self.model.number];
        [self.detailsView.categoryButton setTitle:self.model.category forState:0];
        self.detailsView.lawerTimeLabel.text=[NSString timeChange:self.model.createdTime];
        self.detailsView.nicknameLabel.text=        self.detailsView.nicknameLabel.text=self.layerModel.name?self.layerModel.name:@"";
        self.detailsView.imagesArray=self.model.attachments;
        self.detailsView.payStatusLable.text=self.model.paymentStatus;
        
        if ([self.model.paymentStatus isEqualToString:@"已支付"]) {
            [self.detailsView.payStatusLable setTextColor:UIColorFromRGB(1,136,42)];
        } else if([self.model.paymentStatus isEqualToString:@"待支付"]) {
            [self.detailsView.payStatusLable setTextColor:UIColorFromRGB(255,138,7)];
        }
        
        if (self.layerModel.avatarFileId) {
            
            NSString*imageUrl=[NSString stringWithFormat:@"%@/files/%@",EmallHostUrl,self.layerModel.avatarFileId];
            [self.detailsView.avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
        } else {
            [self setupHeadImg:self.model.category];
        }
    }
    
    else {
        self.detailsView.categoryButton.hidden=YES;
        self.detailsView.numberLable.text=[NSString stringWithFormat:@"编号:%@",self.model.number];
        self.detailsView.starsControl.score=[self.layerModel.rate integerValue];
        [self.detailsView.categoryButton setTitle:self.model.category forState:0];
        self.detailsView.lawerTimeLabel.text=[NSString timeChange:self.model.createdTime];
        self.detailsView.nicknameLabel.text=        self.detailsView.nicknameLabel.text=self.layerModel.name?self.layerModel.name:@"";
        self.detailsView.imagesArray=self.model.attachments;
        self.detailsView.payStatusLable.text=self.model.paymentStatus;
        
        if ([self.model.paymentStatus isEqualToString:@"已支付"]) {
            [self.detailsView.payStatusLable setTextColor:UIColorFromRGB(1,136,42)];
        } else if([self.model.paymentStatus isEqualToString:@"待支付"]) {
            [self.detailsView.payStatusLable setTextColor:UIColorFromRGB(255,138,7)];
        }
        
        if (self.layerModel.avatarFileId) {
            
            NSString*imageUrl=[NSString stringWithFormat:@"%@/files/%@",EmallHostUrl,self.layerModel.avatarFileId];
            [self.detailsView.avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
        } else {
            [self setupHeadImg:self.model.category];
        }
        
    }
    [self p_statusUI:self.model.status];
    
}



-(void)p_commentsUI{
    _commentsView=[UIView new];
    [_myScrollview addSubview:_commentsView];
    _commentsView.frame=CGRectMake(0, 325, SCREEN_WIDTH, SCREEN_HEIGHT-320);
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
-(void)p_statusUI:(NSString*)status{
    if ([status isEqualToString:@"待接单"]) {
        [self.myScrollview addSubview:self.bgView];
        [self.bgView addSubview:self.statusLable];
        self.statusLable.text=self.model.status;
        [self.view addSubview:self.sendButton];
        [self.sendButton bk_whenTapped:^{
            //[self cancelAdvice];
        }];
        
    }
    else if ([status isEqualToString:@"已接单"]){
        [self.myScrollview addSubview:self.bgView];
        [self.bgView addSubview:self.statusLable];
        self.statusLable.text=self.model.status;
        [self.bgView addSubview:self.creatTimeLable];
        [self.view addSubview:self.sendButton];
        [self.sendButton setTitle:@"立即沟通" forState:0];
        [self.sendButton bk_whenTapped:^{
            [self  chatAtion];
        }];
//        [self.view addSubview:self.endButton];
//        [self.endButton bk_whenTapped:^{
//            PSScoreViewController*scoreViewControlller=[[PSScoreViewController alloc]initWithViewModel:[[PSEvaluateViewmodel alloc]init]];
//            scoreViewControlller.cid=self.model.cid;
//            [self.navigationController pushViewController:scoreViewControlller animated:YES];
//        }];
    }
    else if ([status isEqualToString:@"待付款"]){
        UIButton*cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT-130, (SCREEN_WIDTH-60)/2, 44)];
        [cancelButton setBackgroundColor:AppBaseTextColor3];
        [cancelButton setTitle:@"删除订单" forState:0];
        cancelButton.titleLabel.font=FontOfSize(14);
        cancelButton.layer.masksToBounds = YES;
        cancelButton.layer.cornerRadius = 4.0f;
        [self.view addSubview:cancelButton];
        [cancelButton bk_whenTapped:^{
          
        }];
        
        UIButton*payButton=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2+50, SCREEN_HEIGHT-130, (SCREEN_WIDTH-60)/2, 44)];
        [payButton setBackgroundColor:AppBaseTextColor3];
        [payButton setTitle:@"支付费用" forState:0];
        payButton.titleLabel.font=FontOfSize(14);
        payButton.layer.masksToBounds = YES;
        payButton.layer.cornerRadius = 4.0;
        [self.view addSubview:payButton];
        [payButton bk_whenTapped:^{
          
        }];
    }
    
    else if ([self.model.status isEqualToString:@"已取消"]){
        [self.myScrollview addSubview:self.bgView];
        [self.bgView addSubview:self.statusLable];
        self.statusLable.text=self.model.status;
        UIView*line_view=[[UIView alloc]initWithFrame:CGRectMake(12, 44, SCREEN_WIDTH-24, 1)];
        line_view.backgroundColor=AppBaseLineColor;
        [self.bgView addSubview:line_view];
        [self.bgView addSubview:self.creatTimeLable];
        NSRange range1 = NSMakeRange(11, 5);
        self.creatTimeLable.text=[NSString stringWithFormat:@"取消时间:  %@ %@",[self.model.endTime substringToIndex:10],[self.model.endTime substringWithRange:range1]];
        [self.bgView addSubview:self.endLable];
        if (self.model.isAutoEnd==YES) {
            self.endLable.text=@"取消原因:  三天内已无人接单,系统自动取消";
        } else {
            self.endLable.text=@"取消原因:  主动取消订单";
        }
        [self.sendButton setTitle:@"删除订单" forState:UIControlStateNormal];
        [self.view addSubview:self.sendButton];
        [self.sendButton bk_whenTapped:^{
            
        }];
        
        
    }
    else if ([self.model.status isEqualToString:@"待处理"]){
        
        [self.myScrollview addSubview:self.bgView];
        [self.bgView addSubview:self.statusLable];
        self.statusLable.text=self.model.status;
        [self.bgView addSubview:self.creatTimeLable];
        
        UIView*line_view=[[UIView alloc]initWithFrame:CGRectMake(12, 90, SCREEN_WIDTH-24, 1)];
        line_view.backgroundColor=AppBaseLineColor;
        [self.bgView addSubview:line_view];
        
        UIView*scoreBgView=[UIView new];
        scoreBgView.frame=CGRectMake(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT-300);
        scoreBgView.backgroundColor=[UIColor whiteColor];
        [_myScrollview addSubview:scoreBgView];
        
        UILabel*starLable=[UILabel new];
        starLable.textColor=AppBaseTextColor1;
        starLable.textAlignment=NSTextAlignmentLeft;
        starLable.font=FontOfSize(14);
        starLable.text=@"律师服务:";
        starLable.frame=CGRectMake(15, 10, 70, 15);
        [scoreBgView addSubview:starLable];
        
        self.starsControl=[CDZStarsControl.alloc initWithFrame:CGRectMake(75, 10, 100 , 15) stars:5 starSize:CGSizeMake(14, 14) noramlStarImage:[UIImage imageNamed:@"灰星星"] highlightedStarImage:[UIImage imageNamed:@"黄星星"]];
        _starsControl.delegate = self;
        _starsControl.allowFraction = YES;
        [scoreBgView addSubview:self.starsControl];
        
        
        
        UITextView*textView=[[UITextView alloc]init];
        textView.delegate=self;
        [scoreBgView addSubview:textView];
        textView.placeholder=@"请填写本次服务评价，两百字以内！";
        textView.layer.backgroundColor = [[UIColor clearColor] CGColor];
        textView.layer.borderColor = [AppBaseLineColor CGColor];
        textView.layer.cornerRadius = 4.0;
        textView.layer.borderWidth = 1.0;
        [textView.layer setMasksToBounds:YES];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(35);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(90);
        }];
        
        UILabel*titleLable=[UILabel new];
        [scoreBgView addSubview:titleLable];
        titleLable.text=@"是否解决问题";
        titleLable.font=FontOfSize(12);
        titleLable.textColor=AppBaseTextColor1;
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(textView.mas_bottom).offset(10);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(14);
        }];
        
        
        
        [scoreBgView addSubview:self.noButton];
        [_noButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(textView.mas_bottom).offset(10);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(14);
        }];
        [_noButton bk_whenTapped:^{
            [self noAction:self.noButton];
        }];
        
        
        [scoreBgView addSubview:self.yesButton];
        [_yesButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_noButton.mas_left).offset(-5);
            make.top.mas_equalTo(textView.mas_bottom).offset(10);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(14);
        }];
        [_yesButton bk_whenTapped:^{
            [self yesAction:self.yesButton];
        }];
        
        
        
        UIButton*messageButton=[[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT-130, (SCREEN_WIDTH-60)/2, 44)];
        [messageButton setBackgroundColor:AppBaseTextColor3];
        [messageButton setTitle:@"立即沟通" forState:0];
        messageButton.titleLabel.font=FontOfSize(14);
        messageButton.layer.masksToBounds = YES;
        messageButton.layer.cornerRadius = 4.0;
        
        [self.view addSubview:messageButton];
        [messageButton bk_whenTapped:^{
            [self  chatAtion];
        }];
        
        UIButton*endButton=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2+50, SCREEN_HEIGHT-130, (SCREEN_WIDTH-60)/2, 44)];
        [endButton setBackgroundColor: AppBaseTextColor3];
        [endButton setTitle:@"结束咨询" forState:0];
        endButton.titleLabel.font=FontOfSize(14);
        endButton.layer.masksToBounds = YES;
        endButton.layer.cornerRadius = 4.0;
        [self.view addSubview:endButton];
        [endButton bk_whenTapped:^{
            [self checkDataIsEmpty];
            //小屏幕滑动到底部
            if (IS_iPhone_5) {
                [_myScrollview setContentOffset:CGPointMake(0,40) animated:YES];
            }
        }];
        
        self.sendButton.hidden = YES;
    }
    else if ([self.model.status isEqualToString:@"已完成"]){
        
        [self.myScrollview addSubview:self.bgView];
        [self.bgView addSubview:self.statusLable];
        self.statusLable.text=self.model.status;
        [self.bgView addSubview:self.creatTimeLable];
        [self.bgView addSubview:self.endLable];
     //
        UIView*line_view=[[UIView alloc]initWithFrame:CGRectMake(12, 128, SCREEN_WIDTH-24, 1)];
        line_view.backgroundColor=AppBaseLineColor;
        [self.bgView addSubview:line_view];
        
        [self.view addSubview:self.sendButton];
        [_sendButton setTitle:@"删除订单" forState:0];
        [_sendButton bk_whenTapped:^{
          
        }];
        
    }
    else if ([self.model.status isEqualToString:@"已关闭"]){
        [self.myScrollview addSubview:self.bgView];
        [self.bgView addSubview:self.statusLable];
        self.statusLable.text=self.model.status;
        [self.bgView addSubview:self.creatTimeLable];
        [self.bgView addSubview:self.endLable];
       // [self getComments];
        UIView*line_view=[[UIView alloc]initWithFrame:CGRectMake(12, 125, SCREEN_WIDTH-24, 1)];
        line_view.backgroundColor=AppBaseLineColor;
        [self.bgView addSubview:line_view];
        [self.view addSubview:self.sendButton];
        [self.sendButton setTitle:@"删除订单" forState:0];
        [self.sendButton bk_whenTapped:^{
           
        }];
        
    }
    
}

-(void)setupHeadImg:(NSString*)category{
    if ([category isEqualToString:@"财产纠纷"]) {
        [self.detailsView.avatarView setImage:[UIImage imageNamed:@"咨询图-财务纠纷"]];
    }
    else if ([category isEqualToString:@"婚姻家庭"]){
        [self.detailsView.avatarView setImage:[UIImage imageNamed:@"咨询图-婚姻家庭"]];
    }
    else if ([category isEqualToString:@"交通事故"]){
        [self.detailsView.avatarView setImage:[UIImage imageNamed:@"咨询图-交通事故"]];
    }
    else if ([category isEqualToString:@"工伤赔偿"]){
        [self.detailsView.avatarView setImage:[UIImage imageNamed:@"咨询图-工伤赔偿"]];
    }
    else if ([category isEqualToString:@"合同纠纷"]){
        [self.detailsView.avatarView setImage:[UIImage imageNamed:@"咨询图-合同纠纷"]];
    }
    else if ([category isEqualToString:@"刑事辩护"]){
        [self.detailsView.avatarView setImage:[UIImage imageNamed:@"咨询图-刑事辩护"]];
    }
    else if ([category isEqualToString:@"房产纠纷"]){
        [self.detailsView.avatarView setImage:[UIImage imageNamed:@"咨询图-房产纠纷"]];
    }
    else if ([category isEqualToString:@"劳动就业"]){
        [self.detailsView.avatarView setImage:[UIImage imageNamed:@"咨询图-劳动就业"]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)yesAction:(UIButton*)sender{
    BOOL select= !sender.selected;
    _yesButton.selected=select;
    _noButton.selected=!select;
    self.logic.isResolved=@"true";
}

-(void)noAction:(UIButton*)sender{
    BOOL select= !sender.selected;
    _yesButton.selected=!select;
    _noButton.selected=select;
    self.logic.isResolved=@"false";
}


#pragma mark -- delegate

- (void)textViewDidEndEditing:(UITextView *)textView {
   self.logic.content = textView.text;
}

- (void)starsControl:(CDZStarsControl *)starsControl didChangeScore:(CGFloat)score{
    self.logic.rate=[NSString stringWithFormat:@"%.2f", score];
}

#pragma mark - setting&&getting
- (UIScrollView *)myScrollview {
    if (!_myScrollview) {
        _myScrollview = [[UIScrollView alloc] init];
        _myScrollview.contentSize = CGSizeMake(self.view.mj_w,140*4+80);
    }
    return _myScrollview;
}
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.frame=CGRectMake(0, 190+24, SCREEN_WIDTH, 120);
        _bgView.backgroundColor=[UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)statusLable{
    if (!_statusLable) {
        _statusLable=[[UILabel alloc]initWithFrame:CGRectMake(15, 15, 140, 16)];
        _statusLable.textColor=AppBaseTextColor3;
        _statusLable.textAlignment=NSTextAlignmentLeft;
        _statusLable.font=FontOfSize(14);
    }
    return _statusLable;
}




- (UILabel *)creatTimeLable{
    if (!_creatTimeLable) {
        _creatTimeLable=[[UILabel alloc]initWithFrame:CGRectMake(15, 54, 300, 16)];
        _creatTimeLable.text=self.model.acceptedTime?[NSString stringWithFormat:@"接单时间:  %@",[NSString timeChange:self.model.acceptedTime]]:@"";
        _creatTimeLable.textColor=AppBaseTextColor1;
        _creatTimeLable.textAlignment=NSTextAlignmentLeft;
        _creatTimeLable.font=FontOfSize(12);
    }
    return _creatTimeLable;
}


- (UILabel *)endLable{
    if (!_endLable) {
        _endLable=[[UILabel alloc]initWithFrame:CGRectMake(15, 80, 250, 16)];
        _endLable.text=
        self.model.endTime?[NSString stringWithFormat:@"完成时间:  %@",[NSString timeChange:self.model.endTime]]:@"";
        _endLable.textColor=AppBaseTextColor1;
        _endLable.textAlignment=NSTextAlignmentLeft;
        _endLable.font=FontOfSize(12);
    }
    return _endLable;
}





- (UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton=[[UIButton alloc]initWithFrame:CGRectMake(12, SCREEN_HEIGHT-130, SCREEN_WIDTH-24, 44)];
        [_sendButton setBackgroundColor:AppBaseTextColor3];
        [_sendButton setTitle:@"取消订单" forState:0];
        _sendButton.layer.masksToBounds = YES;
        _sendButton.layer.cornerRadius = 4.0;
        
    }
    return _sendButton;
    
}

- (UIButton *)messageButton{
    
    if (!_messageButton) {
        _messageButton=[[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT-130, (SCREEN_WIDTH-60)/2, 44)];
        [_messageButton setBackgroundColor:AppBaseTextColor3];
        _messageButton.layer.masksToBounds = YES;
        _messageButton.layer.cornerRadius = 4.0;
        [_messageButton setTitle:@"立即沟通" forState:0];
        _messageButton.titleLabel.font=FontOfSize(14);
    }
    return _messageButton;
}

- (UIButton *)endButton{
    if (!_endButton) {
        _endButton=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2+50, SCREEN_HEIGHT-130, (SCREEN_WIDTH-60)/2, 44)];
        _endButton.layer.masksToBounds = YES;
        _endButton.layer.cornerRadius = 4.0;
        [_endButton setBackgroundColor: AppBaseTextColor3];
        [_endButton setTitle:@"结束咨询" forState:0];
        _endButton.titleLabel.font=FontOfSize(14);
    }
    return _endButton;
}

- (UIButton *)yesButton{
    if (!_yesButton) {
        _yesButton=[UIButton new];
        _yesButton.selected=NO;
        [_yesButton setImage:[UIImage imageNamed:@"未勾选"] forState:0];
        [_yesButton setImage:[UIImage imageNamed:@"已勾选"] forState:UIControlStateSelected];
        [_yesButton setTitle:@"  是" forState:0];
        _yesButton.titleLabel.font=FontOfSize(12);
        [_yesButton setTitleColor:[UIColor blackColor] forState:0];
    }
    return _yesButton;
}


- (UIButton *)noButton{
    if (!_noButton) {
        _noButton=[UIButton new];
        _noButton.selected=NO;
        [_noButton setImage:[UIImage imageNamed:@"未勾选"] forState:0];
        [_noButton setImage:[UIImage imageNamed:@"已勾选"] forState:UIControlStateSelected];
        [_noButton setTitle:@"  否" forState:0];
        _noButton.titleLabel.font=FontOfSize(12);
        [_noButton setTitleColor:[UIColor blackColor] forState:0];
    }
    return _noButton;
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
    
    if ([model.paymentStatus isEqualToString:@"PENDING"]) {
        model.paymentStatus= @"待支付"; //@"未付款";
    }
    else if ([model.paymentStatus isEqualToString:@"AUTHORIZED"]){
        model.paymentStatus=@"已授权";
    }
    else if ([model.paymentStatus isEqualToString:@"PAID"]){
        model.paymentStatus=  @"已支付";  //@"已付款";
    }
    else if ([model.paymentStatus isEqualToString:@"REFUNDED"]){
        model.paymentStatus=@"已退款";
    }
    else if ([model.paymentStatus isEqualToString:@"REFUNDED"]){
        model.paymentStatus=@"已取消";
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
        model.status=@"待处理";
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
