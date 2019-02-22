//
//  PSConsultationTableViewCell.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/10/29.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSConsultationTableViewCell.h"
#import "UITextView+Placeholder.h"
#import "PSConsultationViewModel.h"
@implementation PSConsultationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        CGFloat sidePidding=15;
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.image = [[UIImage imageNamed:@"serviceHallServiceBg"] stretchImage];
        [self addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(0);
        }];
        bgImageView.userInteractionEnabled=YES;
        
        UIButton*consulationButton=[[UIButton alloc]initWithFrame:CGRectMake(sidePidding, sidePidding, 100, 20)];
        [consulationButton setImage:[UIImage imageNamed:@"咨询分类"]forState:0];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"咨询类别"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,4)];
        [consulationButton setAttributedTitle:str forState:0];
        consulationButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        consulationButton.titleLabel.font=FontOfSize(12);
        [bgImageView addSubview:consulationButton];
        
        
        _choseButton=[[UIButton alloc]initWithFrame:CGRectMake(115, sidePidding, SCREEN_WIDTH-175, 20)];
        _choseButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [_choseButton setTitle:@"咨询类别▼" forState:0];
        [_choseButton setTitleColor:AppBaseTextColor1 forState:0];
        _choseButton.titleLabel.font=FontOfSize(11);
        [bgImageView addSubview:_choseButton];
        
       
        
        
        
    }
    return self;
}





@end
