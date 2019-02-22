//
//  UploadAvatarViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/2/22.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "UploadAvatarViewController.h"

@interface UploadAvatarViewController ()
@property(nonatomic, strong) YYAnimatedImageView *headImgView; //头像
@property(nonatomic, strong) UITextField *nickField;  //昵称
@property(nonatomic, strong) UIButton *compleBtn; //完成


@end

@implementation UploadAvatarViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHidenNaviBar = YES;
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - PrivateMethods

-(void)setupUI {
    
    [self headImgView];
    
    UILabel *uploadLabel = [[UILabel alloc] initWithFrame:CGRectMake((KScreenWidth-100)/2, self.headImgView.bottom+4, 100, KNormalLabeLHeight)];
    uploadLabel.text = @"上传头像";
    uploadLabel.textColor = CFontColor3;
    uploadLabel.font = FFont2;
    uploadLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:uploadLabel];
    
    
    UIView *FieldBgView = [[UIView alloc] initWithFrame:CGRectMake(45, uploadLabel.bottom+50, KScreenWidth-90, KNormalBBtnHeight)];
    ViewRadius(FieldBgView, KNormalBBtnHeight/2);
    FieldBgView.layer.borderWidth = 1;
    FieldBgView.layer.borderColor = CLineColor.CGColor;
    [self.view addSubview:FieldBgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20,(FieldBgView.height-KNormalLabeLHeight)/2, 50, KNormalLabeLHeight)];
    label.text = @"昵称";
    label.font = FFont1;
    label.textColor = CFontColor2;
    [FieldBgView addSubview:label];
    
    self.nickField.frame = CGRectMake(label.right+120,(FieldBgView.height-KNormalLabeLHeight)/2,100, KNormalLabeLHeight);
    [FieldBgView addSubview:self.nickField];
    
    self.compleBtn.frame = CGRectMake(KNormalBBtnHeight,KScreenHeight-200,KScreenWidth-KNormalBBtnHeight*2, KNormalBBtnHeight);
    [self.view addSubview:self.compleBtn];

    
}

#pragma mark - TouchEvent
-(void)headViewClick {
    
}

#pragma mark - Setting&Getting
-(YYAnimatedImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [YYAnimatedImageView new];
        _headImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headImgView.backgroundColor = [UIColor redColor];
        _headImgView.userInteractionEnabled = YES;
        [_headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewClick)]];
        _headImgView.frame = CGRectMake((self.view.width-90*Iphone6ScaleWidth)/2, 100, 100*Iphone6ScaleWidth, 100*Iphone6ScaleWidth);
        ViewRadius(_headImgView, (100*Iphone6ScaleWidth)/2);
        [self.view addSubview:_headImgView];
    }
    return _headImgView;
}

- (UIButton *)compleBtn {
    
    if (!_compleBtn) {
        _compleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_compleBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_compleBtn setTitleColor:CFontColor_BtnTitle forState:UIControlStateNormal];
        [_compleBtn setBackgroundImage:IMAGE_NAMED(@"loginbtnbgicon") forState:UIControlStateNormal];
    }
    return _compleBtn;
}

- (UITextField *)nickField {
    if (!_nickField) {
        _nickField = [[UITextField alloc] init];
        _nickField.placeholder = @"请输入昵称";
        _nickField.textAlignment = NSTextAlignmentLeft;
        _nickField.textColor = CFontColor2;
        _nickField.font = FFont1;
    }
    return _nickField;
}






@end
