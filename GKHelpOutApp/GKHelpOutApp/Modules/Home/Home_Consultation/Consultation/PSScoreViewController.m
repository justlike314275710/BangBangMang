//
//  PSScoreViewController.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/9.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSScoreViewController.h"
#import "CDZStarsControl.h"
#import "UITextView+Placeholder.h"
#import "PSEvaluateViewmodel.h"
#import <AFNetworking/AFNetworking.h>
@interface PSScoreViewController ()<CDZStarsControlDelegate,UITextViewDelegate>
@property (nonatomic , strong) CDZStarsControl *starsControl;
@property (nonatomic , strong) UIButton *noButton;
@property (nonatomic , strong) UIButton *yesButton;
@end

@implementation PSScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderContents];
    
    // Do any additional setup after loading the view.
}

-(void)checkDataIsEmpty{
    PSEvaluateViewmodel *viewModel =(PSEvaluateViewmodel *)self.viewModel;
    @weakify(self)
    [viewModel checkDataWithCallback:^(BOOL successful, NSString *tips) {
        @strongify(self)
        if (successful) {
            [self refreshData];
        } else {
            [PSTipsView showTips:tips];
        }
    }];
}

- (void)refreshData {
     PSEvaluateViewmodel *viewModel =(PSEvaluateViewmodel *)self.viewModel;
    viewModel.cid=self.cid;
    [viewModel requestAddEvaluateCompleted:^(PSResponse *response) {
        [PSTipsView showTips:@"评价提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSError *error) {
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (data) {
            id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString*code=body[@"message"];
            [PSTipsView showTips:code?code:@"评价提交失败"];
            
        }
    }];
}

#pragma mark -- delegate

- (void)textViewDidEndEditing:(UITextView *)textView {
   PSEvaluateViewmodel *viewModel =(PSEvaluateViewmodel *)self.viewModel;
    viewModel.content = textView.text;
}

- (void)starsControl:(CDZStarsControl *)starsControl didChangeScore:(CGFloat)score{

     PSEvaluateViewmodel *viewModel =(PSEvaluateViewmodel *)self.viewModel;
    viewModel.rate=[NSString stringWithFormat:@"%.2f", score];
    
}

#pragma mark -- UI
-(void)renderContents{
    self.view.backgroundColor=UIColorFromRGBA(248, 247, 254, 1);
    UIView*bgView=[UIView new];
    [self.view addSubview:bgView];
    bgView.backgroundColor=AppBaseTextColor3;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
  
    
    UIButton*backButton=[[UIButton alloc]init];
     [bgView addSubview:backButton];
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:0];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(14);
    }];
    [backButton bk_whenTapped:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
   
    
    self.starsControl=[CDZStarsControl.alloc initWithFrame:CGRectMake((SCREEN_WIDTH-140)/2, 45, 140 , 20) stars:5 starSize:CGSizeMake(22, 22) noramlStarImage:[UIImage imageNamed:@"灰星星"] highlightedStarImage:[UIImage imageNamed:@"黄星星"]];
    _starsControl.delegate = self;
    _starsControl.allowFraction = YES;
    [bgView addSubview:self.starsControl];
    
    UIView*contentView=[UIView new];
    [self.view addSubview:contentView];
    contentView.backgroundColor=[UIColor whiteColor];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(190);
    }];
    
    UITextView*textView=[[UITextView alloc]init];
    textView.delegate=self;
    [contentView addSubview:textView];
    textView.placeholder=@"请填写本次服务评价，两百字以内！";
    textView.layer.backgroundColor = [[UIColor clearColor] CGColor];
    textView.layer.borderColor = [AppBaseLineColor CGColor];
    textView.layer.borderWidth = 1.0;
    textView.layer.cornerRadius = 4.0f;
    [textView.layer setMasksToBounds:YES];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-46);
    }];
    
    UILabel*titleLable=[UILabel new];
    [contentView addSubview:titleLable];
    titleLable.text=@"是否解决问题";
    titleLable.font=FontOfSize(12);
    titleLable.textColor=AppBaseTextColor1;
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(textView.mas_bottom).offset(10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(14);
    }];
    
    
    _noButton=[UIButton new];
    [contentView addSubview:_noButton];
    _noButton.selected=NO;
    [_noButton setImage:[UIImage imageNamed:@"未选中"] forState:0];
    [_noButton setImage:[UIImage imageNamed:@"勾选-已选中"] forState:UIControlStateSelected];
    [_noButton setTitle:@"否" forState:0];
    _noButton.titleLabel.font=FontOfSize(12);
    [_noButton setTitleColor:[UIColor blackColor] forState:0];
    [_noButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(textView.mas_bottom).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(14);
    }];
    [_noButton bk_whenTapped:^{
        [self noAction:self.noButton];
    }];
    
    _yesButton=[UIButton new];
    [contentView addSubview:_yesButton];
    _yesButton.selected=NO;
    [_yesButton setImage:[UIImage imageNamed:@"未选中"] forState:0];
    [_yesButton setImage:[UIImage imageNamed:@"勾选-已选中"] forState:UIControlStateSelected];
    [_yesButton setTitle:@"是" forState:0];
    _yesButton.titleLabel.font=FontOfSize(12);
    [_yesButton setTitleColor:[UIColor blackColor] forState:0];
    [_yesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_noButton.mas_left).offset(-5);
        make.top.mas_equalTo(textView.mas_bottom).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(14);
    }];
    [_yesButton bk_whenTapped:^{
          [self yesAction:self.yesButton];
    }];
    
    
    UIButton*postButton=[UIButton new];
    [postButton setTitle:@"提交" forState:0];
    postButton.titleLabel.font=FontOfSize(14);
    [self.view addSubview:postButton];
    [postButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-44);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
    [postButton setBackgroundColor:AppBaseTextColor3];
    [postButton bk_whenTapped:^{
        [self checkDataIsEmpty];
    }];
    
}


#pragma mark -- action
-(void)yesAction:(UIButton*)sender{
   BOOL select= !sender.selected;
    _yesButton.selected=select;
    _noButton.selected=!select;
     PSEvaluateViewmodel *viewModel =(PSEvaluateViewmodel *)self.viewModel;
    viewModel.isResolved=@"true";
}

-(void)noAction:(UIButton*)sender{
    BOOL select= !sender.selected;
    _yesButton.selected=!select;
    _noButton.selected=select;
    PSEvaluateViewmodel *viewModel =(PSEvaluateViewmodel *)self.viewModel;
    viewModel.isResolved=@"false";
}
- (BOOL)hiddenNavigationBar{
    return YES;
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
