//
//  Mine_StatusViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/5.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "Mine_StatusViewController.h"

@interface Mine_StatusViewController ()
@property (nonatomic , strong) UIImageView *backImageView;
@property (nonatomic , strong) UILabel *titleLable;
@end

@implementation Mine_StatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderContents];
    self.title=@"资格认证";
    // Do any additional setup after loading the view.
}
- (void)renderContents{
    
    CGFloat horSpace = 20;
    _titleLable = [UILabel new];
    _titleLable.font = AppBaseTextFont1;
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.textColor = AppBaseTextColor1;
    _titleLable.text=@"您于2017/08/09提交的认证申请没有通过审核，请重新认证～";
    _titleLable.numberOfLines=0;
     [self.view addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(horSpace);
        make.right.mas_equalTo(-horSpace);
        make.height.mas_equalTo(32);
        make.centerY.mas_equalTo(self.view);
    }];
    
    
    
    _backImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"资格认证背景图"]];
    [self.view addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.titleLable.mas_top).offset(-35);
        make.size.mas_equalTo(self.backImageView.frame.size);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (UIImageView *)backImageView{
//    //资格认证背景图
//    if (!_backImageView) {
//        CGFloat width=164.0f;
//        _backImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"资格认证背景图"]];
//        _backImageView.frame=CGRectMake((SCREEN_WIDTH-width)/2, 147, width, width);
//    }
//    return _backImageView;
//}
//
//- (UILabel *)titleLable{
//    if (!_titleLable) {
//        _titleLable=[UILabel alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
