//
//  STTipsView.m
//  Components
//
//  Created by calvin on 14-4-2.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "PSTipsView.h"

#define TIPSFONT 15      //提示信息字体大小
#define DISMISSTIME 2    //提示信息显示时间
#define SIDEPADDING 20   //字体与边缘的间距

@interface PSTipsView ()

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UILabel *tipsLabel;

@end

@implementation PSTipsView

+ (PSTipsView *)sharedInstance {
    static PSTipsView *tipsView = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken,^{
        if (!tipsView) {
            tipsView = [[self alloc] init];
        }
    });
    return tipsView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.7];
        _bgView.layer.cornerRadius = 10.0;
        _bgView.layer.masksToBounds = YES;
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.backgroundColor = [UIColor clearColor];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.font = [UIFont systemFontOfSize:TIPSFONT];
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.numberOfLines = 0;
        [_bgView addSubview:_tipsLabel];
        [self addSubview:_bgView];
    }
    return self;
}

- (void)dealloc {
    
}

+ (void)showTips:(NSString *)tips {
    [self showTips:tips dismissAfterDelay:DISMISSTIME];
}

+ (void)showTips:(NSString *)tips dismissAfterDelay:(NSTimeInterval)interval {
    if ([tips length] == 0) {
        return;
    }
    PSTipsView *tipsView = [self sharedInstance];
    [self cancelPreviousPerformRequestsWithTarget:tipsView selector:@selector(dismiss) object:nil];
    tipsView.tipsLabel.text = tips;
    CGSize textSize = [tipsView.tipsLabel sizeThatFits:CGSizeMake(KScreenWidth - 60, MAXFLOAT)];
    textSize.height = ceil(textSize.height);
    [tipsView.tipsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointZero);
        make.size.mas_equalTo(CGSizeMake(textSize.width + 5, textSize.height));
    }];
    textSize.width += SIDEPADDING;
    textSize.height += SIDEPADDING;
    [tipsView.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(textSize);
        make.center.mas_equalTo(CGPointZero);
    }];
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:tipsView];
    [tipsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [tipsView performSelector:@selector(dismiss) withObject:nil afterDelay:interval];
}

- (void)dismiss {
    [UIView animateWithDuration:1.1 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alpha = 1.0;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
