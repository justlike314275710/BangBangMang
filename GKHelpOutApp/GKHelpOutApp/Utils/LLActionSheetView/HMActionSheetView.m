//
//  HMActionSheetView.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/12.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMActionSheetView.h"
@interface HMActionSheetView()

@property (nonatomic, strong) NSArray * titleArr;
@property (nonatomic, strong) UIView * btnBgView;
@property (nonatomic, assign,getter = isShow) BOOL show;

@end

@implementation HMActionSheetView

- (instancetype)initWithTitleArray:(NSArray *)titleArr andShowCancel:(BOOL)show{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.titleArr  = titleArr; self.show = show;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheet)];
        [self addGestureRecognizer:tap];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    CGFloat CellHeight = 54.f;
    CGFloat CellSpace = 15.0f;
    CGFloat CellBottomSpace = 30.0f;
    CGFloat CellSpacex = 15.0f;
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat bgHeight;
    if (self.isShow) {
        bgHeight =  CellHeight * self.titleArr.count + (CellHeight + CellSpace+CellBottomSpace);
    }else{
        bgHeight  = CellHeight * self.titleArr.count+CellBottomSpace;
    }
    self.btnBgView.frame = CGRectMake(0, size.height, size.width ,bgHeight);
    [self addSubview:self.btnBgView];
    
    CGFloat bgWidth = self.btnBgView.frame.size.width;
    UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:CFontColor3 forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 0;
    btn.frame = CGRectMake(0+CellSpacex, bgHeight - CellHeight-CellBottomSpace, bgWidth-2*CellSpacex, CellHeight);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 10.0f;
    UIImage * highLightImage = [self imageWithColor:[UIColor groupTableViewBackgroundColor] size:CGSizeMake(bgWidth, CellHeight)];
    [btn setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
    [self.btnBgView addSubview:btn];
    
    btn.hidden = !self.isShow;
    
    for (int i = 0 ; i < self.titleArr.count; i++) {
        CGFloat btnX = 0+CellSpacex;
        CGFloat btnY;
        if (self.isShow) {
            btnY = (bgHeight - CellHeight - CellSpace-CellBottomSpace)  - CellHeight*(i+1);
        }else{
            btnY = bgHeight - CellHeight*(i+1)-CellBottomSpace;
        }
        CGFloat btnW = bgWidth-2*CellSpacex;
        CGFloat btnH = CellHeight - 0.5f;
        
        UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:CFontColor3 forState:UIControlStateNormal];
        [btn setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10.0f;
        btn.tag   = i+1;
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnBgView addSubview:btn];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)show{
    CGSize size = [UIScreen mainScreen].bounds.size;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.btnBgView.frame;
        frame.origin.y =  size.height - frame.size.height;
        self.btnBgView.frame = frame;
    }];
}

- (void)btnClickAction:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hm_actionSheetView:clickButtonAtIndex:)]) {
        [self.delegate hm_actionSheetView:self clickButtonAtIndex:btn.tag];
    }
    if (self.ClickIndex) {
        self.ClickIndex(btn.tag);
    }
    [self hiddenSheet];
}

- (void)hiddenSheet {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.btnBgView.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.btnBgView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UIView *)btnBgView{
    if (!_btnBgView) {
        _btnBgView = [[UIView alloc]init];
        _btnBgView.backgroundColor = [UIColor colorWithRed:223.0f/255.0f green:226.0f/255.f blue:236.0f/255.0f alpha:1];
        _btnBgView.backgroundColor = KClearColor;
    }
    return _btnBgView;
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
