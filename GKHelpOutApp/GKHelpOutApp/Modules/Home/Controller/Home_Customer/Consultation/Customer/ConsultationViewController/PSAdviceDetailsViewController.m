//
//  PSAdviceDetailsViewController.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/6.
//  Copyright © 2018年 calvin. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import "PSAdviceDetailsViewController.h"
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
@interface PSAdviceDetailsViewController ()<CDZStarsControlDelegate,UITextViewDelegate>
@property (nonatomic , strong) PSConsultation *model;
@property (nonatomic , strong) PSLawer *layerModel;
@property (nonatomic , strong) PSAdviceDetailsView *detailsView;
@property (nonatomic , strong)  PSPayView *payView;
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
@end

@implementation PSAdviceDetailsViewController
- (instancetype)initWithViewModel:(PSViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        self.title =@"咨询详情";
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    [self refreshData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowLiftBack = YES;
   
}
#pragma mark -- 网络请求
-(void)checkDataIsEmpty{
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    @weakify(self)
    [viewModel checkEvaluateDataWithCallback:^(BOOL successful, NSString *tips) {
        @strongify(self)
        if (successful) {
            [self addAdviceEvaluate];
        } else {
            [PSTipsView showTips:tips];
        }
    }];
}

-(void)addAdviceEvaluate{
    [[PSLoadingView sharedInstance]show];
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    [viewModel requestAddEvaluateCompleted:^(PSResponse *response) {
         [[PSLoadingView sharedInstance]dismiss];
         [PSTipsView showTips:@"评价提交成功"];
         [self refreshData];
        
    } failed:^(NSError *error) {
         [[PSLoadingView sharedInstance]dismiss];
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (data) {
            id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString*code=body[@"message"];
            [PSTipsView showTips:code?code:@"评价提交失败"];
            
        }
    }];
}

-(void)deleteAdvice{
     [[PSLoadingView sharedInstance]show];
     PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    [viewModel deleteConsultationCompleted:^(PSResponse *response) {
        [[PSLoadingView sharedInstance]dismiss];
        [PSTipsView showTips:@"删除订单成功"];
        KPostNotification(KNotificationOrderStateChange, nil);
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSError *error) {
        [[PSLoadingView sharedInstance]dismiss];
        [PSTipsView showTips:@"删除订单失败"];
    }];
}

-(void)cancelAdvice{
      [[PSLoadingView sharedInstance]show];
     PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    [viewModel cancelConsultationCompleted:^(PSResponse *response) {
        [[PSLoadingView sharedInstance]dismiss];
         KPostNotification(KNotificationOrderStateChange, nil);
        [PSTipsView showTips:@"取消订单成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSError *error) {
        [[PSLoadingView sharedInstance]dismiss];
        [PSTipsView showTips:@"取消订单失败"];
    }];
}
//获取评论
-(void)getComments{
     PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    [viewModel requestCommentsCompleted:^(PSResponse *response) {
        self.comments=[PSAdviceComments mj_objectWithKeyValues:response];
        [self p_commentsUI];
        
    } failed:^(NSError *error) {
        
    }];
}


-(void)chatAtion{
     PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    [viewModel GETProcessedCompleted:self.model.cid :^(id data) {
        [PSTipsView showTips:@"模拟通话完成!"];
        [self refreshData];
    } failed:^(NSError *error) {
         [PSTipsView showTips:@"模拟通话失败!"];
    }];
    
//    [viewModel GETProcessedCompleted:^(id data) {
//        [PSTipsView showTips:@"模拟通话完成!"];
//        [self refreshData];
//    } failed:^(NSError *error) {
//         [PSTipsView showTips:@"模拟通话失败!"];
//    }];
    /*
    //viewModel.chatMessageAccount
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    viewModel.userName=self.layerModel.username;
    
    [viewModel getChatUsernameCompleted:^(PSResponse *response) {
    NIMSession *session = [NIMSession session:viewModel.chatMessageAccount type:NIMSessionTypeP2P];
    NIMSessionViewController *vc = [[NIMSessionViewController alloc] initWithSession:session];
    vc.titleName=self.layerModel.name;
    NTESAttachment *attachment = [[NTESAttachment alloc] init];
        attachment.title = self.model.des;
        attachment.cid = self.model.cid;
        attachment.category=self.model.category;
        attachment.categoryType=self.model.type;
        attachment.time= [NSString timeChange:self.model.createdTime];
        
        //构造自定义MessageObject
        NIMCustomObject *object = [[NIMCustomObject alloc] init];
        object.attachment = attachment;
       
        
        //构造自定义消息
        NIMMessage *message = [[NIMMessage alloc] init];
        message.messageObject =object;
        
        //发送消息
        [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
        vc.orderID=self.model.cid;
        vc.videoDuration=self.model.videoDuration;
       
        if ([self.model.videoDuration isEqualToString:@"0"]) {
            [PSTipsView showTips:@"通话时长不足,请充值"];
            [PSAlertView showWithTitle:nil message:@"您的视频通话时长已用完" messageAlignment:NSTextAlignmentCenter image:nil handler:^(PSAlertView *alertView, NSInteger buttonIndex) {
                
            } buttonTitles:@"取消",@"充值", nil];
        } else {
            vc.videoDuration=self.model.videoDuration;
             [self.navigationController pushViewController:vc animated:YES];
        }
   
    } failed:^(NSError *error) {
        [PSTipsView showTips:@"云信聊天失败!"];
    }];
     */
}
- (void)refreshData {
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    @weakify(self)
      [[PSLoadingView sharedInstance]show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [viewModel refreshMyAdviceDetailsCompleted:^(PSResponse *response) {
            @strongify(self)
            dispatch_async(dispatch_get_main_queue(), ^{
                self.model=[PSConsultation mj_objectWithKeyValues:response];
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

#pragma mark -- 微信支付宝支付
- (void)buyCardAction:(NSString*)cid withReward:(NSString*)reward{
    PSPhoneCardViewModel*viewModel=[[PSPhoneCardViewModel alloc]init];
    PSPayView *payView = [PSPayView new];
    [payView setGetAmount:^CGFloat{
        return [reward floatValue];
    }];
    [payView setGetRows:^NSInteger{
        return viewModel.payments.count;
    }];
    [payView setGetSelectedIndex:^NSInteger{
        return viewModel.selectedPaymentIndex;
    }];
    [payView setGetIcon:^UIImage *(NSInteger index) {
        PSPayment *payment = viewModel.payments.count > index ? viewModel.payments[index] : nil;
        return payment ? [UIImage imageNamed:payment.iconName] : nil;
    }];
    [payView setGetName:^NSString *(NSInteger index) {
        PSPayment *payment = viewModel.payments.count > index ? viewModel.payments[index] : nil;
        return payment ? payment.name : nil;
    }];
    [payView setSeletedPayment:^(NSInteger index) {
        self.index=index;
        viewModel.selectedPaymentIndex = index;
    }];
    
    @weakify(self)
    [payView setGoPay:^{
        @strongify(self)
        [self goPay:cid];
        
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [payView showAnimated:YES];
    });
    
    _payView = payView;
}

-(void)goPay:(NSString*)cid{
    PSPhoneCardViewModel*viewModel=[[PSPhoneCardViewModel alloc]init];
    PSPayInfo*payinfo=[PSPayInfo new];
    PSPayment *paymentInfo = viewModel.payments[_index];
    payinfo.productID=cid;
    payinfo.payment=paymentInfo.payment;
    [[PSLoadingView sharedInstance] show];
    @weakify(self)
    [[PSPayCenter payCenter] goPayWithPayInfo:payinfo type:PayTypeOrd callback:^(BOOL result, NSError *error) {
        @strongify(self)
        [[PSLoadingView sharedInstance] dismiss];
        if (error) {
            if (error.code != 106 && error.code != 206) {
                [PSTipsView showTips:error.domain];
            }
        }else{
            [self.navigationController popViewControllerAnimated:NO];
            self.payView.status = PSPaySuccessful;

        }
    }];
    
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
//            NSString*imageUrl=[NSString stringWithFormat:@"%@/users/%@/avatar",EmallHostUrl,self.layerModel.username];
            NSString*imageUrl=[NSString stringWithFormat:@"%@/users/by-username/avatar?username=%@",EmallHostUrl,self.layerModel.username];
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
        if (self.layerModel.username) {
            //            NSString*imageUrl=[NSString stringWithFormat:@"%@/users/%@/avatar",EmallHostUrl,self.layerModel.username];
            NSString*imageUrl=[NSString stringWithFormat:@"%@/users/by-username/avatar?username=%@",EmallHostUrl,self.layerModel.username];
            [self.detailsView.avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        }
        else{
            [self setupHeadImg:self.model.category];
        }
        
//        if (self.layerModel.avatarFileId) {
//            NSString*imageUrl=[NSString stringWithFormat:@"%@/files/%@",EmallHostUrl,self.layerModel.avatarFileId];
//            [self.detailsView.avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
//        }
//        else{
//            [self setupHeadImg:self.model.category];
//        }
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
        
        if (self.layerModel.username) {
            //            NSString*imageUrl=[NSString stringWithFormat:@"%@/users/%@/avatar",EmallHostUrl,self.layerModel.username];
            NSString*imageUrl=[NSString stringWithFormat:@"%@/users/by-username/avatar?username=%@",EmallHostUrl,self.layerModel.username];
            [self.detailsView.avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        }
        else{
            [self setupHeadImg:self.model.category];
        }
//        if (self.layerModel.avatarFileId) {
//            NSString*imageUrl=[NSString stringWithFormat:@"%@/files/%@",EmallHostUrl,self.layerModel.avatarFileId];
//            [self.detailsView.avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
//
//        } else {
//            [self setupHeadImg:self.model.category];
//        }
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
        if (self.layerModel.username) {
            //            NSString*imageUrl=[NSString stringWithFormat:@"%@/users/%@/avatar",EmallHostUrl,self.layerModel.username];
            NSString*imageUrl=[NSString stringWithFormat:@"%@/users/by-username/avatar?username=%@",EmallHostUrl,self.layerModel.username];
            [self.detailsView.avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        }
        else{
            [self setupHeadImg:self.model.category];
        }
        
//        if (self.layerModel.avatarFileId) {
//
//            NSString*imageUrl=[NSString stringWithFormat:@"%@/files/%@",EmallHostUrl,self.layerModel.avatarFileId];
//            [self.detailsView.avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
//
//        } else {
//            [self setupHeadImg:self.model.category];
//        }
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
        if (self.layerModel.username) {
            //            NSString*imageUrl=[NSString stringWithFormat:@"%@/users/%@/avatar",EmallHostUrl,self.layerModel.username];
            NSString*imageUrl=[NSString stringWithFormat:@"%@/users/by-username/avatar?username=%@",EmallHostUrl,self.layerModel.username];
            [self.detailsView.avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        }
        else{
            [self setupHeadImg:self.model.category];
        }
        
//        if (self.layerModel.avatarFileId) {
//
//            NSString*imageUrl=[NSString stringWithFormat:@"%@/files/%@",EmallHostUrl,self.layerModel.avatarFileId];
//            [self.detailsView.avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
//            
//        } else {
//            [self setupHeadImg:self.model.category];
//        }
        
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
            [self cancelAdvice];
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
    }
    else if ([status isEqualToString:@"待付款"]){
        UIButton*cancelButton=[[UIButton alloc]init];
        cancelButton.frame=IS_IPHONEX?CGRectMake(15, SCREEN_HEIGHT-130-64, (SCREEN_WIDTH-60)/2, 44):CGRectMake(15, SCREEN_HEIGHT-130, (SCREEN_WIDTH-60)/2, 44);
        [cancelButton setBackgroundColor:AppBaseTextColor3];
        [cancelButton setTitle:@"删除订单" forState:0];
        cancelButton.titleLabel.font=FontOfSize(14);
        cancelButton.layer.masksToBounds = YES;
        cancelButton.layer.cornerRadius = 4.0f;
        [self.view addSubview:cancelButton];
        [cancelButton bk_whenTapped:^{
            [self deleteAdvice];
        }];
        
        UIButton*payButton=[[UIButton alloc]init];
        payButton.frame=IS_IPHONEX?CGRectMake((SCREEN_WIDTH-70)/2+50, SCREEN_HEIGHT-130-64, (SCREEN_WIDTH-60)/2, 44):CGRectMake((SCREEN_WIDTH-70)/2+50, SCREEN_HEIGHT-130, (SCREEN_WIDTH-60)/2, 44);
        [payButton setBackgroundColor:AppBaseTextColor3];
        [payButton setTitle:@"立即支付" forState:0];
        payButton.titleLabel.font=FontOfSize(14);
        payButton.layer.masksToBounds = YES;
        payButton.layer.cornerRadius = 4.0;
        [self.view addSubview:payButton];
        [payButton bk_whenTapped:^{
            [self buyCardAction:self.model.cid withReward:self.model.reward];
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
            [self deleteAdvice];
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
        
        
        
//        self.messageButton=[[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT-130, (SCREEN_WIDTH-60)/2, 44)];
//        [messageButton setBackgroundColor:AppBaseTextColor3];
//        [messageButton setTitle:@"立即沟通" forState:0];
//        messageButton.titleLabel.font=FontOfSize(14);
//        messageButton.layer.masksToBounds = YES;
//        messageButton.layer.cornerRadius = 4.0;
        self.messageButton.frame = CGRectMake(15, SCREEN_HEIGHT-130, (SCREEN_WIDTH-60)/2, 44);
        [self.messageButton setTitle:@"立即沟通" forState:0];
        [self.view addSubview:self.messageButton];
        [self.messageButton bk_whenTapped:^{
            [self  chatAtion];
        }];
        
//        UIButton*endButton=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2+50, SCREEN_HEIGHT-130, (SCREEN_WIDTH-60)/2, 44)];
//        [endButton setBackgroundColor: AppBaseTextColor3];
//        [endButton setTitle:@"结束咨询" forState:0];
//        endButton.titleLabel.font=FontOfSize(14);
//        endButton.layer.masksToBounds = YES;
//        endButton.layer.cornerRadius = 4.0;
        self.endButton.frame = CGRectMake((SCREEN_WIDTH-70)/2+50, SCREEN_HEIGHT-130, (SCREEN_WIDTH-60)/2, 44);
        [self.endButton setTitle:@"结束咨询" forState:0];
        [self.view addSubview:self.endButton];
        [self.endButton bk_whenTapped:^{
            [self checkDataIsEmpty];
            //小屏幕滑动到底部
            if (IS_iPhone_5) {
                [self.myScrollview setContentOffset:CGPointMake(0,40) animated:YES];
            }
        }];
        
        self.sendButton.hidden = YES;
    }
    else if ([self.model.status isEqualToString:@"已完成"]){
        [self.bgView removeAllSubviews];
        self.endButton.hidden = YES;
        self.messageButton.hidden = YES;

        
        [self.myScrollview addSubview:self.bgView];
        [self.bgView addSubview:self.statusLable];
        self.statusLable.text=self.model.status;
        [self.bgView addSubview:self.creatTimeLable];
        [self.bgView addSubview:self.endLable];
        [self getComments];
        UIView*line_view=[[UIView alloc]initWithFrame:CGRectMake(12, 132, SCREEN_WIDTH-24, 1)];
        line_view.backgroundColor=AppBaseLineColor;
        [self.bgView addSubview:line_view];

        [self.view addSubview:self.sendButton];
        self.sendButton.frame =IS_IPHONEX? CGRectMake(12, SCREEN_HEIGHT-130-64, SCREEN_WIDTH-24, 44):CGRectMake(12, SCREEN_HEIGHT-130, SCREEN_WIDTH-24, 44);
        self.sendButton.hidden = NO;
        [_sendButton setTitle:@"删除订单" forState:0];
        [_sendButton bk_whenTapped:^{
            [self deleteAdvice];
        }];
        
    }
    else if ([self.model.status isEqualToString:@"已关闭"]){
        [self.myScrollview addSubview:self.bgView];
        [self.bgView addSubview:self.statusLable];
        self.statusLable.text=self.model.status;
        [self.bgView addSubview:self.creatTimeLable];
        [self.bgView addSubview:self.endLable];
        [self getComments];
        UIView*line_view=[[UIView alloc]initWithFrame:CGRectMake(12, 125, SCREEN_WIDTH-24, 1)];
        line_view.backgroundColor=AppBaseLineColor;
        [self.bgView addSubview:line_view];
        [self.view addSubview:self.sendButton];
        [self.sendButton setTitle:@"删除订单" forState:0];
        [self.sendButton bk_whenTapped:^{
            [self deleteAdvice];
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
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    viewModel.isResolved=@"true";
}

-(void)noAction:(UIButton*)sender{
    BOOL select= !sender.selected;
    _yesButton.selected=!select;
    _noButton.selected=select;
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    viewModel.isResolved=@"false";
}


#pragma mark -- delegate

- (void)textViewDidEndEditing:(UITextView *)textView {
    PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
    viewModel.content = textView.text;
}

- (void)starsControl:(CDZStarsControl *)starsControl didChangeScore:(CGFloat)score{
   PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
   viewModel.rate=[NSString stringWithFormat:@"%.2f", score];
    
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
        
        _sendButton=[[UIButton alloc]init];
        _sendButton.frame=IS_IPHONEX?CGRectMake(12, SCREEN_HEIGHT-130-64, SCREEN_WIDTH-24, 44):CGRectMake(12, SCREEN_HEIGHT-130, SCREEN_WIDTH-24, 44);
        [_sendButton setBackgroundColor:AppBaseTextColor3];
        [_sendButton setTitle:@"取消订单" forState:0];
        _sendButton.layer.masksToBounds = YES;
        _sendButton.layer.cornerRadius = 4.0;
     
    }
    return _sendButton;
    
}

- (UIButton *)messageButton{
    
    if (!_messageButton) {
        _messageButton=[[UIButton alloc]init];
        _messageButton.frame=IS_IPHONEX?CGRectMake(15, SCREEN_HEIGHT-130-64, (SCREEN_WIDTH-60)/2, 44):CGRectMake(15, SCREEN_HEIGHT-130, (SCREEN_WIDTH-60)/2, 44);
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
