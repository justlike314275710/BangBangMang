//
//  MineHeaderView.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/6/13.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "MineHeaderView.h"
#import "NickNameLbel.h"

@interface MineHeaderView()

@property(nonatomic, strong) UIImageView *bgImgView; //背景图
@property(nonatomic, strong) UIImageView *cerImg; //认证视图
@property(nonatomic, strong) UIImageView *cerIconImg;
@property(nonatomic, strong) UILabel *cerLab;


@end

@implementation MineHeaderView

-(void)setUserInfo:(UserInfo *)userInfo{
    _userInfo = userInfo;
    
    UIImage *bgImg = IMAGE_NAMED(@"个人信息底");
    [self.bgImgView setImage:bgImg];
    [self nickNameLab];
    [self phoneNuberLab];
    //已认证
    if (help_userManager.userStatus == CERTIFIED) {
        [self cerImg];
        [self cerIconImg];
        [self cerLab];
    }


//未登录状态展示
    if (userInfo) {
        if (help_userManager.avatarImage) {
            self.headImgView.image = help_userManager.avatarImage;
        } else {
            [self.headImgView sd_setImageWithURL:[NSURL URLWithString:userInfo.avatar] placeholderImage:[UIImage imageWithColor:KGrayColor]];
        }
    }else{
        [self.headImgView setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1503377311744&di=a784e64d1cce362c663f3480b8465961&imgtype=0&src=http%3A%2F%2Fww2.sinaimg.cn%2Flarge%2F85cccab3gw1etdit7s3nzg2074074twy.jpg"] placeholder:[UIImage imageWithColor:KGrayColor]];
    }
}
#pragma mark ————— 头像点击 —————
-(void)headViewClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerViewClick)]) {
        [self.delegate headerViewClick];
    }
}
#pragma mark ————— 昵称点击 —————
-(void)nickNameViewClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(nickNameViewClick)]) {
        [self.delegate nickNameViewClick];
    }
}

#pragma mark ————— 认证律师 ——————
-(void)clicLawView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cerLawViewClick)]) {
        [self.delegate cerLawViewClick];
    }
}

-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView = [UIImageView new];
        _bgImgView.userInteractionEnabled = YES;
        [self addSubview:_bgImgView];
        [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(13);
            make.right.mas_equalTo(-13);
            make.top.mas_equalTo(16);
            make.height.mas_equalTo(112);
            
        }];
    }
    return _bgImgView;
}

-(YYAnimatedImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [YYAnimatedImageView new];
        _headImgView.contentMode = UIViewContentModeScaleAspectFill;
        
        _headImgView.userInteractionEnabled = YES;
        [_headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewClick)]];
        
        ViewRadius(_headImgView, 25);
        [self.bgImgView addSubview:_headImgView];
        [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.centerY.mas_equalTo(self.bgImgView);
            make.left.mas_equalTo(17);
        }];
    }
    return _headImgView;
}

-(UILabel *)phoneNuberLab {
    if (!_phoneNuberLab) {
        _phoneNuberLab = [UILabel new];
        _phoneNuberLab.text = help_userManager.curUserInfo.username;
        _phoneNuberLab.font = FFont2;
        _phoneNuberLab.textAlignment = NSTextAlignmentLeft;
        _phoneNuberLab.textColor = CFontColor4;
        [self.bgImgView addSubview:_phoneNuberLab];
        [_phoneNuberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(22);
            make.left.mas_equalTo(self.headImgView.mas_right).offset(10);
            make.top.mas_equalTo(self.nickNameLab.mas_bottom).offset(5);
        }];
    }
    return _phoneNuberLab;
}

-(UILabel *)nickNameLab {
    if (!_nickNameLab) {
        _nickNameLab = [UILabel new];
        _nickNameLab.text = help_userManager.curUserInfo.nickname;
        _nickNameLab.font = FontOfSize(18);
        _nickNameLab.textAlignment = NSTextAlignmentLeft;
        _nickNameLab.textColor = CFontColor1;
        [self.bgImgView addSubview:_nickNameLab];
        [_nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(22);
            make.left.mas_equalTo(self.headImgView.mas_right).offset(10);
            make.top.mas_equalTo(self.headImgView);
        }];
    }
    return _nickNameLab;
}

- (UIImageView *)cerImg {
    if (!_cerImg) {
        _cerImg = [UIImageView new];
        _cerImg.userInteractionEnabled = YES;
        @weakify(self);
        [_cerImg bk_whenTapped:^{
            @strongify(self);
            [self clicLawView];
        }];
        _cerImg.image = IMAGE_NAMED(@"认证律师底");
         [self.bgImgView addSubview:_cerImg];
        [_cerImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(77);
            make.height.mas_equalTo(25);
            make.top.mas_equalTo(29);
            make.right.mas_equalTo(0);
        }];
        
        [_cerImg addSubview:self.cerIconImg];
        [_cerIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(12);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(_cerImg);
        }];
        
        [_cerImg addSubview:self.cerLab];
        [_cerLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(28);
            make.centerY.mas_equalTo(_cerImg);
        }];
        
    }
    return _cerImg;
}

-(UIImageView *)cerIconImg {
    if (!_cerIconImg) {
        _cerIconImg = [UIImageView new];
        _cerIconImg.image = IMAGE_NAMED(@"已认证icon");
    }
    return _cerIconImg;
}

-(UILabel *)cerLab {
    if (!_cerLab) {
        _cerLab = [UILabel new];
        _cerLab.font = SFFont;
        _cerLab.textColor = KWhiteColor;
        _cerLab.textAlignment = NSTextAlignmentLeft;
        _cerLab.text = @"认证律师";
    }
    return _cerLab;
}






@end
