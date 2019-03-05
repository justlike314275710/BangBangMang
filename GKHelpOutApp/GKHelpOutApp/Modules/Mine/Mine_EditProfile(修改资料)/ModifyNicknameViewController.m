//
//  ModifyNicknameViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/1.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "ModifyNicknameViewController.h"

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
