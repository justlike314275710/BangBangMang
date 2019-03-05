//
//  Mine_addressViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "Mine_addressViewController.h"

@interface Mine_addressViewController ()
@property (nonatomic , strong) UIButton*cityBtn;
@property (nonatomic , strong) UITextView *streetView;
@end

@implementation Mine_addressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setIsShowLiftBack:YES];
    self.title=@"律师会所";
    // Do any additional setup after loading the view.
}

-(void)setUI{
    CGFloat sidding=15.0f;
    UIView*cityView=[UIView new];
    cityView.frame=CGRectMake(sidding, sidding, SCREEN_WIDTH-2*sidding, 44);
    [cityView addSubview:self.cityBtn];
    
    _cityBtn=[UIButton new];
    [_cityBtn setTitle:@"所在地区" forState:0];
    _cityBtn.frame=CGRectMake(0, 0, SCREEN_WIDTH-2*sidding, 44);
    
    self.streetView=[[UITextView alloc]init];
    self.streetView.frame=CGRectMake(sidding, cityView.bottom+sidding, SCREEN_WIDTH-2*sidding, 60);
    [self.view addSubview:_streetView];
    _streetView.placeholder=@"请输入地址";
    
    
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
