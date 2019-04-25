//
//  NTESContactUtilCell.m
//  NIM
//
//  Created by chris on 15/2/26.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NTESContactUtilCell.h"
#import "UIView+NTES.h"
#import "NTESBadgeView.h"

@interface NTESContactUtilCell()

@property (nonatomic,strong) NTESBadgeView *badgeView;
@property (nonatomic,strong) UIView *redView;

@property (nonatomic,strong) id<NTESContactItem> data;

@end

@implementation NTESContactUtilCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //_badgeView = [NTESBadgeView viewWithBadgeTip:@""];
        //[self addSubview:_badgeView];
    }
    return self;
}

- (void)refreshWithContactItem:(id<NTESContactItem>)item{
    self.data = item;
    self.textLabel.text = item.nick;
    self.imageView.image = item.icon;
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPressUtilImage:)];
    [self.imageView addGestureRecognizer: recognizer];
    [self.textLabel sizeToFit];
    
    NSString *badge  = [item badge];
    self.badgeView.hidden = badge.integerValue == 0;
    self.badgeView.badgeValue = badge;
    
   
    [self addSubview:self.redView];
     self.redView.hidden=badge.integerValue == 0;
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)onPressUtilImage:(id)sender{
    if ([self.delegate respondsToSelector:@selector(onPressUtilImage:)]) {
        [self.delegate onPressUtilImage:self.data.nick];
    }
}

- (void)addDelegate:(id)delegate{
    self.delegate = delegate;
}

#define BadgeValueRight 50
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.left = NTESContactAvatarLeft;
    self.imageView.centerY = self.height * .5f;
    self.badgeView.right = self.width - BadgeValueRight;
    self.badgeView.centerY = self.height * .5f;
    
    _redView.left =  self.imageView.right+95;

}

- (UIView *)redView{
    if (!_redView) {
        _redView=[UIView new];
        _redView.backgroundColor=[UIColor redColor];
        _redView.centerY = self.height * .6f;
        _redView.size=CGSizeMake(7, 7);
        _redView.layer.cornerRadius=3.5;
        

    }
    return _redView;
}

@end
