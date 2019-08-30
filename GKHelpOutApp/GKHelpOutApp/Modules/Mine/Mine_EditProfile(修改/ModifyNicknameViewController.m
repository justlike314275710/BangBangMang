//
//  ModifyNicknameViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/1.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "ModifyNicknameViewController.h"
#import "PSLoadingView.h"

@interface ModifyNicknameViewController ()
@property(nonatomic,strong)UITextField *textField;

@end

@implementation ModifyNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.modifyType == ModifyNickName) {
         self.title = @"修改昵称";
    } else {
         self.title = @"修改邮编";
    }
    self.isShowLiftBack = YES;
    [self addNavigationItemWithTitles:@[@"保存"] isLeft:NO target:self action:@selector(saveAction) tags:@[@2000]];
    [self setupUI];
}
#pragma mark - PravateMetods
-(void)setupUI{
    [self.view addSubview:self.textField];
    if (self.modifyType==ModifyNickName) {
        _textField.placeholder = @"请输入昵称";
    } else {
        _textField.placeholder = @"请输入邮政编码";
    }
    
}

#pragma mark - TouchEvent
-(void)saveAction{
    if (self.modifyType == ModifyNickName) {
        [self modifyAccountNickname];
    } else {
        self.title = @"修改邮编";
    }
}


#pragma mark - 修改用户昵称
- (void)modifyAccountNickname {
    
    if (self.textField.text.length==0) {
        [PSTipsView showTips:@"请输入昵称！"];
        return;
    } else if(self.textField.text.length>6) {
        [PSTipsView showTips:@"昵称不能超过6位数！"];
        return;
    }
    UserInfo *user = help_userManager.curUserInfo;
    NSLog(@"%@",user);
    [[PSLoadingView sharedInstance]show];
    NSString*url=[NSString stringWithFormat:@"%@%@",EmallHostUrl,URL_modify_nickname];
    NSDictionary*parmeters=@{
                             @"phoneNumber":help_userManager.curUserInfo.username,
                             @"nickname":self.textField.text
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString*token=[NSString stringWithFormat:@"Bearer %@",help_userManager.oathInfo.access_token];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager PUT:url parameters:parmeters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode==204) {
            [PSTipsView showTips:@"昵称修改成功"];
            help_userManager.curUserInfo.nickname = self.textField.text;
            [help_userManager saveUserInfo];
            [[PSLoadingView sharedInstance]dismiss];
            //发送通知
            KPostNotification(KNotificationModifyDataChange,nil);
            KPostNotification(KNotificationMineDataChange, nil);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[PSLoadingView sharedInstance]dismiss];
        NSLog(@"%@",error);
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (ValidData(data)) {
            id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString*code=body[@"code"];
//            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

#pragma mark - Setting&Getting
-(UITextField*)textField{
    CGFloat spaceX = 15;
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.frame = CGRectMake(spaceX,spaceX ,KScreenWidth-2*spaceX,35);
        _textField.backgroundColor = KWhiteColor;
        _textField.layer.cornerRadius = 4.0;
        _textField.font = FFont1;
        _textField.textColor = CFontColor2;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        UIView *lefeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,15, 35)];
        lefeView.backgroundColor = KClearColor;
        _textField.leftView = lefeView;
    }
    return _textField;
}


@end
