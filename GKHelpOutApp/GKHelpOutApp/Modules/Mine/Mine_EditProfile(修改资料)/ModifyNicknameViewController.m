//
//  ModifyNicknameViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/1.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "ModifyNicknameViewController.h"

@interface ModifyNicknameViewController ()

@end

@implementation ModifyNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改昵称";
    self.isShowLiftBack = YES;
    
    [self setupUI];
}

-(void)setupUI{
    switch (self.modifyType) {
        case ModifyNickName:
        {
            self.title=@"修改昵称";
        }
            break;
        case ModifyNickZipCode:
        {
            self.title=@"修改邮编";
        }
            break;
        case ModifyAddress:
        {
            self.title=@"修改住址";
        }
            break;
            
        default:
            break;
    }
}


@end
