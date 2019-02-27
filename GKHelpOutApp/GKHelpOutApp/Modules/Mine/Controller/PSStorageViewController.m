//
//  PSStorageViewController.m
//  PrisonService
//
//  Created by kky on 2018/12/18.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSStorageViewController.h"
#import "PSSorageViewModel.h"
#import "PSAlertView.h"
#import <SDWebImage/SDImageCache.h>
#import "PSTipsView.h"

@interface PSStorageViewController ()
@property(nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property(nonatomic, strong) UILabel  *calcuLab;
@property(nonatomic, strong) UIButton *clearBtn;
@property(nonatomic, strong) UILabel  *allStorage;


@end

@implementation PSStorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = AppBaseBackgroundColor2;
    
    self.title = @"存储空间";
    
    self.isShowLiftBack = YES;
    
    [self p_setUI];
    
    [self p_refreshUI];

    
}

- (void)p_refreshUI {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.indicatorView stopAnimating];
        self.indicatorView.hidden = YES;
        self.clearBtn.hidden = NO;
        PSSorageViewModel *viewModel = [PSSorageViewModel new];
        self.allStorage.hidden = NO;
        self.allStorage.text = viewModel.allStorage;
        self.calcuLab.text = viewModel.usedStorage;
    
    });
    
}
- (void)p_setUI {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 20,SCREEN_WIDTH-30, 182)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    bgView.layer.shadowOffset = CGSizeMake(0,3);
    bgView.layer.shadowOpacity = 1;
    bgView.layer.shadowRadius = 4;
    [self.view addSubview:bgView];
    
    UILabel *hasUserLab = [[UILabel alloc] initWithFrame:CGRectMake((bgView.width-200)/2,15, 200,30)];
    hasUserLab.textColor = UIColorFromRGB(102, 102,102);
    hasUserLab.textAlignment = NSTextAlignmentCenter;
    hasUserLab.font = FontOfSize(10);
    hasUserLab.numberOfLines = 0;
    NSString *userLabStr =  @"帮帮忙已用空间";
    [hasUserLab setText:userLabStr];
    [bgView addSubview:hasUserLab];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake((bgView.width-24)/2,hasUserLab.bottom+2,24, 1)];
    line.backgroundColor = UIColorFromRGB(194, 194, 194);
    [bgView addSubview:line];
    
    self.indicatorView.frame = CGRectMake((bgView.width-17)/2, line.bottom+20, 17, 17);
    [bgView addSubview:self.indicatorView];
    
    self.allStorage.frame = CGRectMake((bgView.width-150)/2, line.bottom+15, 150, 30);
    [bgView addSubview:self.allStorage];
    
    self.calcuLab.frame = CGRectMake((bgView.width-200)/2,_indicatorView.bottom+5, 200, 30);
    [bgView addSubview:self.calcuLab];
    
    self.clearBtn.frame = CGRectMake((bgView.width-155)/2,self.calcuLab.bottom+5,155,30);
    [bgView addSubview:self.clearBtn];
    
    
}
- (void)showTips {
    
    NSString*determine= @"确定";
    NSString*cancel= @"取消";
    NSString *msg = @"清理帮帮忙缓存可能需要一点时间，清理过程请耐心等候";
    
    [PSAlertView showWithTitle:nil message:msg messageAlignment:NSTextAlignmentCenter image:nil handler:^(PSAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self p_clearStorage];
        }
    } buttonTitles:cancel,determine, nil];
}

-(void)p_clearStorage {
    self.allStorage.hidden = YES;
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
    self.clearBtn.hidden = YES;
    NSString *text = @"正在清理缓存....";
    self.calcuLab.text = text;
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [self p_refreshUI];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [PSTipsView showTips:@"缓存清理成功"];
        });
        if (self.clearScuessBlock) {
            self.clearScuessBlock();
        }
    }];
}


#pragma mark - Setting&&Getting
-(UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //设置小菊花颜色
        _indicatorView.color = [UIColor grayColor];
        //设置背景颜色
        _indicatorView.backgroundColor = [UIColor whiteColor];
        //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
        
        [_indicatorView startAnimating];
    }
    return _indicatorView;
}

- (UILabel *)calcuLab {
    if (!_calcuLab) {
        NSString *text = @"正在计算已使用空间";
        _calcuLab = [UILabel new];
        [_calcuLab setText:text];
        _calcuLab.textAlignment = NSTextAlignmentCenter;
        _calcuLab.textColor = UIColorFromRGB(102, 102, 102);
        _calcuLab.font = FontOfSize(10);
        _calcuLab.numberOfLines = 0;
    }
    return _calcuLab;
}

- (UIButton *)clearBtn {
    if (!_clearBtn) {
        NSString *title = @"清理帮帮忙缓存";
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearBtn setTitle:title forState:UIControlStateNormal];
        [_clearBtn setBackgroundColor:UIColorFromRGB(38, 76, 144)];
        [_clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _clearBtn.layer.masksToBounds = YES;
        _clearBtn.layer.cornerRadius = 2.0;
        _clearBtn.titleLabel.font = FontOfSize(12);
        _clearBtn.hidden = YES;
        _clearBtn.titleLabel.numberOfLines = 0;
        @weakify(self);
        [_clearBtn bk_whenTapped:^{
            @strongify(self);
            [self showTips];
        }];
    }
    return _clearBtn;
}


- (UILabel *)allStorage {
    if (!_allStorage) {
        _allStorage = [UILabel new];
        [_allStorage setText:@"1.9GB"];
        _allStorage.textAlignment = NSTextAlignmentCenter;
        _allStorage.textColor = UIColorFromRGB(51,51,51);
        _allStorage.font = [UIFont boldSystemFontOfSize:30];
        _allStorage.numberOfLines = 0;
        _allStorage.hidden = YES;
    }
    return _allStorage;
}






@end
