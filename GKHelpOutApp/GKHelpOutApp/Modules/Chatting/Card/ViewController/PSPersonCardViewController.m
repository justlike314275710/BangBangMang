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
@interface PSPersonCardViewController ()
@property (nonatomic,copy  ) NSString                *userId;
@property (nonatomic,copy  ) NSString                *phone;
@property (nonatomic,copy  ) NSString                *nickName;
@property (nonatomic,copy  ) NSString                *avatar;
@property (nonatomic,copy  ) NSString                *curUserName;
@end

@implementation PSPersonCardViewController
- (instancetype)initWithUserId:(NSString *)userId withPhone:(NSString*)phone withNickName:(NSString*)nickName withAvatar:(NSString*)avatar withCurUserName:(NSString*)curUserName{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _nickName=nickName;
        _userId = userId;
        _phone=phone;
        _avatar=avatar;
        _curUserName=curUserName;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setUI];
    
    // Do any additional setup after loading the view.
}
-(void)p_setUI{
    self.isShowLiftBack=YES;
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    UIView*personView=[UIView new];
    personView.backgroundColor=[UIColor whiteColor];
    personView.frame=CGRectMake(0, 15, SCREEN_WIDTH, 94);
    [self.view addSubview:personView];
    
    UIImageView*iconView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 64, 64)];
    [personView addSubview:iconView];
    if (!self.avatar) {
        [iconView sd_setImageWithURL:[NSURL URLWithString:self.avatar] placeholderImage:[UIImage imageNamed:@"登录－头像"]];
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
-(void)addFriendsWithMessage{
    NTESAddFriendsMessageViewController*vc=[[NTESAddFriendsMessageViewController alloc]initWithUserId:self.userId withCurUserName:self.curUserName];
    PushVC(vc);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
