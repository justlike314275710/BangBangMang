//
//  PSServiceLinkView.m
//  PrisonService
//
//  Created by calvin on 2018/4/13.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSServiceLinkView.h"

@implementation PSServiceLinkView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        UIImageView *linkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"serviceHallLink"]];
        [self addSubview:linkImageView];
        [linkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(35);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(linkImageView.frame.size);
        }];
    }
    return self;
}

@end
