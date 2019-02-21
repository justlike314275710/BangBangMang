//
//  PSAlertView.m
//  Start
//
//  Created by Glen on 16/6/15.
//  Copyright © 2016年 DingSNS. All rights reserved.
//

#import "PSAlertView.h"
#import "PSMacro.h"
#import <YYKit.h>
#import <NSAttributedString+YYText.h>
//#import "YYText.h"

#define GAlertWidth MIN(SCREEN_WIDTH, SCREEN_HEIGHT) * 0.75
#define GAlertHeightDefault 130.0
#define GAlertButtonHeight 44.0
#define GAlertImageHeight  40.0

@interface PSAlertView()

@property (nonatomic, strong) UIView *backColorView;
@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) YYLabel *messagelabel;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, copy) void (^didDismissBlock)(PSAlertView *alertView, NSInteger buttonIndex);

@end

@implementation PSAlertView

+ (instancetype)showWithTitle:(NSString *)title
                      message:(NSString *)message
             messageAlignment:(NSTextAlignment)alignment
                        image:(UIImage *)image
                      handler:(void (^)(PSAlertView *alertView, NSInteger buttonIndex))block
                 buttonTitles:(NSString *)buttonTitles ,...{
    
    NSMutableArray *buttonTitleArray = [[NSMutableArray alloc] init];
    
    va_list argList;
    id arg;
    if (buttonTitles) {
        [buttonTitleArray addObject:buttonTitles];
        va_start(argList, buttonTitles);
        while ((arg = va_arg(argList, id))) {
            [buttonTitleArray addObject:arg];
        }
        va_end(argList);
    }
    
    PSAlertView *alertView = [[PSAlertView alloc] initWithTitle:title message:message messageAlignment:alignment image:image buttonTitles:buttonTitleArray handler:block];
    alertView.tag = GAlertViewTage;
    [alertView show];
    return alertView;
}



- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
             messageAlignment:(NSTextAlignment)alignment
                        image:(UIImage *)image
                 buttonTitles:(NSArray *)buttonTitles
                      handler:(void (^)(PSAlertView *alertView, NSInteger buttonIndex))block {
    self = [super initWithFrame:CGRectMake(0, 0, GAlertWidth, GAlertHeightDefault)];
    if (self) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        
        self.didDismissBlock = block;
        CGFloat verSideSpace = 20.f;
        CGFloat verContentSpace = 10.0f;
        CGFloat horSideSpace = 15.0f;
        CGFloat startY = verSideSpace;
        UIFont *titleFont = AppBaseTextFont1;
        UIFont *contentFont = AppBaseTextFont2;
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat contentWidth = width - 2 * horSideSpace;
       // UIColor *titleColor = UIColorFromHexadecimalRGB(0x383838);
        UIColor *titleColor = [UIColor blackColor];
        UIColor *otherColor = UIColorFromHexadecimalRGB(0x383838);
        
        if (title.length > 0) {
            CGSize titleSize = [title boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleFont} context:nil].size;
            _alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(horSideSpace, startY, contentWidth, ceil(titleSize.height))];
            _alertTitleLabel.numberOfLines = 0;
            [_alertTitleLabel setTextAlignment:NSTextAlignmentCenter];
            [_alertTitleLabel setTextColor:titleColor];
            _alertTitleLabel.font = titleFont;
            [_alertTitleLabel setText:title];
            [self addSubview:_alertTitleLabel];
            startY += CGRectGetHeight(_alertTitleLabel.frame);
            startY += verContentSpace;
        }
        
        if (image) {
            CGFloat imageWidth = MIN(contentWidth, image.size.width);
            CGFloat imageHeight = image.size.height * imageWidth / image.size.width;
            _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(horSideSpace, startY, contentWidth, imageHeight)];
            _imageView.contentMode = UIViewContentModeScaleAspectFit;
            _imageView.image = image;
            [self addSubview:_imageView];
            startY += CGRectGetHeight(_imageView.frame);
            startY += verContentSpace;
        }
        
        if (message.length > 0) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:4];
            [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
            [paragraphStyle setAlignment:alignment];
            NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:contentFont,NSForegroundColorAttributeName:otherColor};
            NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:message attributes:attributes];
            #warning TODO 
            //contentString.yy_alignment = alignment;
            contentString.alignment = alignment;
            YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(contentWidth, MAXFLOAT) insets:UIEdgeInsetsZero];
            YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:contentString];
            _messagelabel = [[YYLabel alloc] initWithFrame:CGRectMake(horSideSpace, startY, contentWidth, textLayout.textBoundingSize.height)];
            _messagelabel.textLayout = textLayout;
            [_messagelabel setNumberOfLines:0];
            _messagelabel.attributedText = contentString;
            [self addSubview:_messagelabel];
            startY += CGRectGetHeight(_messagelabel.frame);
            startY += verContentSpace;
        }
        
        if ([buttonTitles count] == 0) {
            buttonTitles = @[@"确定"];
        }
        UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, startY, width, GAlertButtonHeight)];
        [self addSubview:buttonView];
        UIView *horiLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
        horiLine.backgroundColor = UIColorFromHexadecimalRGB(0xe4e4e4);
        [buttonView addSubview:horiLine];
        NSInteger bCount = buttonTitles.count;
        CGFloat buttonWidth = width / bCount;
        for (NSInteger i = 0; i < bCount; i ++) {
            NSString *titleStr = [buttonTitles objectAtIndex:i];
            UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, GAlertButtonHeight)];
            titleButton.tag = i + 1000;
            [titleButton setTitle:titleStr forState:UIControlStateNormal];
            [titleButton.titleLabel setFont:AppBaseTextFont2];
           // [titleButton setTitleColor:UIColorFromHexadecimalRGB(0x383838) forState:UIControlStateNormal];
            [titleButton setTitleColor:AppBaseTextColor3 forState:UIControlStateNormal];
            [titleButton addTarget:self action:@selector(titleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [buttonView addSubview:titleButton];
            if (i > 0) {
                CGFloat vSpace = 8;
                UIView *verLine = [[UIView alloc] initWithFrame:CGRectMake(i * buttonWidth, vSpace, 1, GAlertButtonHeight - vSpace * 2)];
                verLine.backgroundColor = UIColorFromHexadecimalRGB(0xe4e4e4);
                [buttonView addSubview:verLine];
            }
        }
        startY += CGRectGetHeight(buttonView.frame);
        
        CGRect frame = self.frame;
        frame.size.height = startY;
        self.frame = frame;
    }
    return self;
}

-(void)titleButtonPressed:(id)sender{
    NSInteger tag = ((UIButton*)sender).tag - 1000;
    self.didDismissBlock(self,tag);
    [self dismissAnimated:YES];
}

- (void)didDismiss{
    [self dismissAnimated:NO];
}

- (void)dismissAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.15 animations:^{
            self.alpha = 0.0;
        }];
        [UIView animateWithDuration:0.3 animations:^{
            self.backColorView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self.backColorView removeFromSuperview];
            [self removeFromSuperview];
        }];
    }else {
        [self.backColorView removeFromSuperview];
        [self removeFromSuperview];
    }
}




- (void)show{
    PSAlertView *alertView = (PSAlertView*)[[UIApplication sharedApplication].keyWindow viewWithTag:GAlertViewTage];
    if ([alertView isKindOfClass:[PSAlertView class]] && alertView != nil) {
        [alertView didDismiss];
    }
    
    if (!_backColorView) {
        _backColorView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _backColorView.backgroundColor = [UIColor blackColor];
        _backColorView.alpha = 0.4;
        _backColorView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:_backColorView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.center = [UIApplication sharedApplication].keyWindow.center;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.8],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .3;
    
    [self.layer addAnimation:animation forKey:@"popup"];
    
}


-(void)dealloc{
    //NSLog(@"%@ dealloc",self.class);
}

@end

