//
//  serciceIiem.m
//  PrisonService
//
//  Created by kky on 2018/10/25.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "serciceIiem.h"

@implementation serciceIiem

- (id)initWithFrame:(CGRect)frame
          logoImage:(NSString *)logoImage
              title:(NSString *)title
            message:(NSString *)message  {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self renderContents:logoImage title:title message:message];
    }
    return self;
}

- (void)renderContents:(NSString *)logoImage
                 title:(NSString *)title
               message:(NSString *)message {
    
    UIImage *bgImage = [UIImage imageNamed:logoImage];
    UIImageView *logoImageV = [UIImageView new];
    logoImageV.contentMode = UIViewContentModeScaleAspectFill;
    logoImageV.image = bgImage;
    [self addSubview:logoImageV];
    [logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(20);
        make.width.mas_equalTo(84);
        make.height.mas_equalTo(64);
    }];
    
    UILabel *titleLab = [UILabel new];
    titleLab.text = title;
    titleLab.font = FontOfSize(12);
    titleLab.textColor = UIColorFromRGBA(38, 76, 144, 1);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoImageV.mas_bottom).offset(5);
        make.width.left.mas_equalTo(logoImageV);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *messageLab = [UILabel new];
    messageLab.text = message;
    messageLab.font = FontOfSize(10);
    messageLab.textColor = UIColorFromRGBA(102,102,102, 1);
    messageLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:messageLab];
    [messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLab.mas_bottom);
        make.width.left.mas_equalTo(self);
        make.height.mas_equalTo(15);
    }];
    
}




@end
