//
//  NTESAddFriendsMessageViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/4/16.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "NTESAddFriendsMessageViewController.h"
#import "NIMCommonTableDelegate.h"
#import "NIMCommonTableData.h"
#import "UIView+Toast.h"
#import "NTESColorButtonCell.h"
#import "UIView+NTES.h"

#import "NTESBundleSetting.h"
#import "UIAlertView+NTESBlock.h"
#import "NTESPersonalCardViewController.h"
@interface NTESAddFriendsMessageViewController ()
@property (nonatomic,copy  ) NSString                *userId;
@property (nonatomic,copy  ) NSString                *curUserName;
@property (nonatomic , strong) UITextField           *messageField ;
@end

@implementation NTESAddFriendsMessageViewController


- (instancetype)initWithUserId:(NSString *)userId withCurUserName:(NSString *)curUserName{
        self = [super initWithNibName:nil bundle:nil];
        if (self) {
            _userId = userId;
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
    self.title=@"朋友验证";
    self.isShowLiftBack=YES;
    [self createRightBarButtonItemWithTarget:self action:@selector(addFriend) title:@"发送"];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    UILabel*titleLable=[[UILabel alloc]init];
    titleLable.frame=CGRectMake(15, 10, SCREEN_WIDTH-30, 14);
    titleLable.text=@"你需要发送验证申请，等对方通过";
    titleLable.font=FontOfSize(12);
    titleLable.textColor=AppBaseTextColor1;
    [self.view addSubview:titleLable];
    
    
    UIView*backGroundView=[UIView new];
    backGroundView.backgroundColor=[UIColor whiteColor];
    backGroundView.frame=CGRectMake(0, 35, SCREEN_WIDTH, 44);
    [self.view addSubview:backGroundView];
    
    _messageField=[[UITextField alloc]init];
    _messageField.frame=CGRectMake(15, 0, SCREEN_WIDTH, 44);
    _messageField.placeholder=@"请输入验证信息";
    _messageField.text=NSStringFormat(@"我是%@",help_userManager.curUserInfo.nickname);
    _messageField.font=FontOfSize(14);
    [backGroundView addSubview:_messageField];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFriend{
    NIMUserRequest *request = [[NIMUserRequest alloc] init];
    request.userId = self.userId;
    request.operation = NIMUserOperationRequest;
    NSDictionary*dic= @{@"verifyContent":_messageField.text,@"nickName":help_userManager.curUserInfo.nickname,@"curUserName":self.curUserName};
    request.message = [dic mj_JSONString];
    NSString *successText = request.operation == NIMUserOperationAdd ? @"添加成功" : @"好友请求成功";
    NSString *failedText =  request.operation == NIMUserOperationAdd ? @"添加失败" : @"好友请求失败";
    
    __weak typeof(self) wself = self;
    [[PSLoadingView sharedInstance] show];
    [[NIMSDK sharedSDK].userManager requestFriend:request completion:^(NSError *error) {
        [[PSLoadingView sharedInstance] dismiss];
        if (!error) {
            [wself.view makeToast:successText
                         duration:2.0f
                         position:CSToastPositionCenter];
           // [wself refresh];
//            NTESPersonalCardViewController *vc = [[NTESPersonalCardViewController alloc] initWithUserId:self.userId];
//            [wself.navigationController pushViewController:vc animated:YES];
        }else{
            [wself.view makeToast:failedText
                         duration:2.0f
                         position:CSToastPositionCenter];
        }
    }];
}


- (void)backBtnClicked{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
