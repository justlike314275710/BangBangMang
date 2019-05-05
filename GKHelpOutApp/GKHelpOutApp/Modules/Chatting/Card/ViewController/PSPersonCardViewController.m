//
//  PSPersonCardViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/4/19.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "PSPersonCardViewController.h"
#import "NSString+JsonString.h"
#import "NTESAddFriendsMessageViewController.h"
#import "LifeCircleViewController.h"
@interface PSPersonCardViewController ()
@property (nonatomic,copy  ) NSString                *userId;
@property (nonatomic,copy  ) NSString                *phone;
@property (nonatomic,copy  ) NSString                *nickName;
@property (nonatomic,copy  ) NSString                *avatar;
@property (nonatomic,copy  ) NSString                *curUserName;
@property (nonatomic,copy  ) NSArray                 *pictuerArray;
@property (nonatomic,copy  ) NSString                *friendinfo ;
@end

@implementation PSPersonCardViewController
- (instancetype)initWithUserId:(NSString *)userId withPhone:(NSString*)phone withNickName:(NSString*)nickName withAvatar:(NSString*)avatar withCurUserName:(NSString*)curUserName withFriendinfo:(NSString*)friendinfo withCircleoffriendsPicture:(NSArray*)CircleoffriendsPicture;{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _nickName=nickName;
        _userId = userId;
        _phone=phone;
        _avatar=avatar;
        _curUserName=curUserName;
        _pictuerArray=CircleoffriendsPicture;
        _friendinfo=friendinfo;
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"好友信息";
    if ([self.friendinfo isEqualToString:@"1"]) { //好友
         [self p_setFriendsUI];
    } else {
         [self p_setNotFriendsUI];
       
    }
   
    [self SDWebImageAuth];
    
    // Do any additional setup after loading the view.
}

-(void)p_setData{
    
    NSString*url=[NSString stringWithFormat:@"%@%@",ChatServerUrl,URL_LifeCircle_getMyNewPicture];
    NSString *access_token =help_userManager.oathInfo.access_token;
    NSString *token = NSStringFormat(@"Bearer %@",access_token);
    [PPNetworkHelper setValue:token forHTTPHeaderField:@"Authorization"];
    [PPNetworkHelper GET:url parameters:nil success:^(id responseObject) {
        if (ValidArray(responseObject)) {
            self.pictuerArray = responseObject;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self p_setFriendsUI];
        });
    } failure:^(NSError *error) {

    }];
}

-(void)p_setNotFriendsUI{
    self.isShowLiftBack=YES;
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    UIView*personView=[UIView new];
    personView.backgroundColor=[UIColor whiteColor];
    personView.frame=CGRectMake(0, 15, SCREEN_WIDTH, 94);
    [self.view addSubview:personView];
    
    UIImageView*iconView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 64, 64)];
    [personView addSubview:iconView];
    if (_avatar) {
        NSString*url=AvaterImageWithUsername(self.avatar);
        [iconView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"登录－头像"]];
    } else {
        [iconView setImage:[UIImage imageNamed:@"登录－头像"]];
    }
    
    
    UILabel*nickName=[[UILabel alloc]initWithFrame:CGRectMake(64+30, 28, SCREEN_WIDTH-94, 20)];
    nickName.font=FontOfSize(18);
    nickName.textColor=[UIColor blackColor];
    [personView addSubview:nickName];
    nickName.text=self.nickName;
    
    
    UILabel*phone=[[UILabel alloc]initWithFrame:CGRectMake(64+30, 48+5, SCREEN_WIDTH-94, 20)];
    phone.font=FontOfSize(14);
    phone.textColor=AppBaseTextColor1;
    [personView addSubview:phone];
    phone.text=[NSString changeTelephone:self.phone];
    
    
    UIButton*addFriendsBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 30+94, SCREEN_WIDTH, 44)];
    [self.view addSubview:addFriendsBtn];
    [addFriendsBtn setTitle:@"添加到通讯录" forState:0];
    [addFriendsBtn setTitleColor:AppBaseTextColor3 forState:0];
    [addFriendsBtn setBackgroundColor:[UIColor whiteColor]];
    addFriendsBtn.titleLabel.font=FontOfSize(14);
    [addFriendsBtn addTapBlock:^(UIButton *btn) {
        [self addFriendsWithMessage];
    }];
    
}




-(void)p_setFriendsUI{
    self.isShowLiftBack=YES;
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    CGFloat sidding=15.0f;
    CGFloat personHeight=94.0f;
    CGFloat iconViewWitdh=64.0f;
    CGFloat picterViewHeight=70.0f;
    UIView*personView=[UIView new];
    personView.backgroundColor=[UIColor whiteColor];
    personView.frame=CGRectMake(0, sidding, SCREEN_WIDTH, personHeight);
    [self.view addSubview:personView];
    
    UIImageView*iconView=[[UIImageView alloc]initWithFrame:CGRectMake(sidding, sidding, iconViewWitdh, iconViewWitdh)];
    [personView addSubview:iconView];
    if (_avatar) {
        NSString*url=AvaterImageWithUsername(self.avatar);
        [iconView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"登录－头像"]];
    } else {
        [iconView setImage:[UIImage imageNamed:@"登录－头像"]];
    }

    UILabel*nickName=[[UILabel alloc]initWithFrame:CGRectMake(iconViewWitdh+2*sidding, 28, SCREEN_WIDTH-94, 20)];
    nickName.font=FontOfSize(18);
    nickName.textColor=[UIColor blackColor];
    [personView addSubview:nickName];
    nickName.text=self.nickName;
    
    UILabel*phone=[[UILabel alloc]initWithFrame:CGRectMake(iconViewWitdh+2*sidding, 48+5, SCREEN_WIDTH-94, 20)];
    phone.font=FontOfSize(14);
    phone.textColor=AppBaseTextColor1;
    [personView addSubview:phone];
    phone.text=[NSString changeTelephone:self.phone];
    
 
    UIView*picterView=[UIView new];
    picterView.backgroundColor=[UIColor whiteColor];
    picterView.frame=CGRectMake(0, personHeight+2*sidding, SCREEN_WIDTH, picterViewHeight);
    [self.view addSubview:picterView];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
      [picterView addGestureRecognizer:tapGesturRecognizer];

    
    UILabel*titleLable=[UILabel new];
    titleLable.frame=CGRectMake(sidding, 26, 50, 15);
    [picterView addSubview:titleLable];
    titleLable.text=@"生活圈";
    titleLable.font=FontOfSize(14);
    titleLable.textColor=[UIColor blackColor];
   
    NSMutableArray *mdic = [NSMutableArray array];
    for (NSDictionary *dic in self.pictuerArray) {
        [mdic addObject:[dic valueForKey:@"fileId"]];
    }
    
    for (int i=0; i<mdic.count; i++) {
        NSString*imageUrl=mdic[i];
        NSString*url=NSStringFormat(@"%@/files/%@",EmallHostUrl,imageUrl);
        UIImageView*friendsView=[[UIImageView alloc]init];
        [friendsView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:IMAGE_NAMED(@"朋友圈图片")];
        [picterView addSubview: friendsView];
        friendsView.frame=CGRectMake(80+i*59, 13, 44, 44);
        
    }
    
    UIImageView*arrawImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"进入icon"]];
    [picterView addSubview:arrawImage];
    arrawImage.frame=CGRectMake(SCREEN_WIDTH-25, 27, 10, 16);
    
    
    UIButton*sendMessageBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,3*sidding+picterViewHeight+personHeight , SCREEN_WIDTH, 44)];
    [self.view addSubview:sendMessageBtn];
    [sendMessageBtn setTitle:@"发消息" forState:0];
    [sendMessageBtn setTitleColor:AppBaseTextColor3 forState:0];
    [sendMessageBtn setBackgroundColor:[UIColor whiteColor]];
   sendMessageBtn.titleLabel.font=FontOfSize(14);
    [sendMessageBtn addTapBlock:^(UIButton *btn) {
        [self sendMessage];
    }];
    
}


-(void)tapAction{
    
    LifeCircleViewController *LifeCircleVC = [[LifeCircleViewController alloc] init];
    //自己
    if ([_phone isEqualToString:help_userManager.curUserInfo.username]) {
        LifeCircleVC.lifeCircleStyle = HMLifeCircleMy;
    } else {
        LifeCircleVC.lifeCircleStyle = HMLifeCircleOther;
        LifeCircleVC.friendusername = _avatar;
        LifeCircleVC.showName = _nickName;
    }
    PushVC(LifeCircleVC);
}
-(void)sendMessage{
    NIMSession *session = [NIMSession session:self.userId type:NIMSessionTypeP2P];
    NIMSessionViewController *vc = [[NIMSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addFriendsWithMessage{
    if ([_phone isEqualToString:help_userManager.curUserInfo.username]) {
        [PSAlertView showWithTitle:@"提示" message:@"你不能添加自己到通讯录" messageAlignment:NSTextAlignmentCenter image:nil handler:^(PSAlertView *alertView, NSInteger buttonIndex) {
            
        } buttonTitles:@"确定", nil];
    } else {
        NTESAddFriendsMessageViewController*vc=[[NTESAddFriendsMessageViewController alloc]initWithUserId:self.userId withCurUserName:self.curUserName];
        PushVC(vc);
    }
  
}


#pragma mark ————— 设置SDWebImage认证token —————
-(void)SDWebImageAuth{
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [SDWebImageManager.sharedManager.imageDownloader setValue:token forHTTPHeaderField:@"Authorization"];
    [SDWebImageManager sharedManager].imageCache.config.maxCacheAge=5*60.0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
