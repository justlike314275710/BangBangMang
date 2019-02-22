//
//  PSPayView.m
//  PrisonService
//
//  Created by calvin on 2018/4/23.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSPayView.h"
#import "PSPayOngoingViewController.h"
#import "PSPaySuccessViewController.h"

@interface PSPayView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UINavigationController *contentController;

@end

@implementation PSPayView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        [self renderContents];
    }
    return self;
}

- (void)renderContents {
    self.bgView = [UIView new];
    self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    @weakify(self)
    [self.bgView bk_whenTapped:^{
        @strongify(self)
        [self dismissAnimated:YES];
    }];
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    CGFloat verSidePadding = 15;
    CGFloat width = CGRectGetWidth(self.frame) - 2 * verSidePadding;
    CGFloat height = 290;
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(verSidePadding, 0, width, height)];
    [self addSubview:self.contentView];
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.image = [[UIImage imageNamed:@"serviceHallServiceBg"] stretchImage];
    [self.contentView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    PSPayOngoingViewController *ongoingViewController = [[PSPayOngoingViewController alloc] init];
    [ongoingViewController setGetAmount:^CGFloat{
        @strongify(self)
        CGFloat amount = 0;
        if (self.getAmount) {
            amount = self.getAmount();
        }
        return amount;
    }];
    [ongoingViewController setGetRows:^NSInteger{
        @strongify(self)
        NSInteger rows = 0;
        if (self.getRows) {
            rows = self.getRows();
        }
        return rows;
    }];
    [ongoingViewController setGetSelectedIndex:^NSInteger{
        @strongify(self)
        NSInteger index = 0;
        if (self.getSelectedIndex) {
            index = self.getSelectedIndex();
        }
        return index;
    }];
    [ongoingViewController setGetIcon:^UIImage *(NSInteger index) {
        @strongify(self)
        UIImage *image = nil;
        if (self.getIcon) {
            image = self.getIcon(index);
        }
        return image;
    }];
    [ongoingViewController setGetName:^NSString *(NSInteger index) {
        @strongify(self)
        NSString *name = nil;
        if (self.getName) {
            name = self.getName(index);
        }
        return name;
    }];
    [ongoingViewController setSeletedPayment:^(NSInteger index) {
        @strongify(self)
        if (self.seletedPayment) {
            self.seletedPayment(index);
        }
    }];
    [ongoingViewController setCloseAction:^{
        @strongify(self)
        [self dismissAnimated:YES];
    }];
    
    
    [ongoingViewController setGoPay:^{
        @strongify(self)
        if (self.goPay) {
            self.goPay();
        }
    }];
    self.contentController = [[UINavigationController alloc] initWithRootViewController:ongoingViewController];
    [self.contentView addSubview:self.contentController.view];
    [self.contentController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setStatus:(PSPayStatus)status {
    _status = status;
    if (status == PSPayOngoing) {
        [self.contentController popViewControllerAnimated:NO];
    }else if (status == PSPaySuccessful) {
        PSPaySuccessViewController *paySuccessViewController = [[PSPaySuccessViewController alloc]  init];
        paySuccessViewController.payType = self.payType;
        @weakify(self)
        [paySuccessViewController setCloseAction:^{
            @strongify(self)
            [self dismissAnimated:YES];
        }];
        
        [paySuccessViewController setGoHomeAction:^{
            @strongify(self)
            [self dismissAnimated:YES];
            if (self.goHomeAction) {
                self.goHomeAction();
            }
        }];
        
        [paySuccessViewController setGozxAction:^{
            @strongify(self)
            [self dismissAnimated:YES];
            if (self.goZxActcion) {
                self.goZxActcion();
            }
        }];
        [self.contentController pushViewController:paySuccessViewController animated:NO];
    }
}

- (void)showAnimated:(BOOL)animated {
    self.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    __block CGRect frame = self.contentView.frame;
    frame.origin.y = CGRectGetHeight(self.frame);
    self.contentView.frame = frame;
    frame.origin.y -= (CGRectGetHeight(frame) + 20);
    self.bgView.alpha = 0.f;
    [UIView animateWithDuration:animated ? 0.25 : 0 animations:^{
        self.contentView.frame = frame;
        self.bgView.alpha = 1.0f;
    }];
}

- (void)dismissAnimated:(BOOL)animated {
    __block CGRect frame = self.contentView.frame;
    frame.origin.y = CGRectGetHeight(self.frame);
    [UIView animateWithDuration:animated ? 0.25 : 0 animations:^{
        self.contentView.frame = frame;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
