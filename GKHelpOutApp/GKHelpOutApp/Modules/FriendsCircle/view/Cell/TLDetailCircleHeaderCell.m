//
//  TLDetailCircleHeaderCell.m
//  GKHelpOutApp
//
//  Created by kky on 2019/4/23.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "TLDetailCircleHeaderCell.h"
#import "TLMomentDetailImagesView.h"
@interface TLDetailCircleHeaderCell ()

@property(nonatomic,strong)UIButton *avatarView;
@property(nonatomic,strong)UIButton *nameView;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)TLMomentDetailImagesView *ImagesView;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UILabel *commentLabel;
@property(nonatomic,strong)UILabel *likeLabel;


@end

@implementation TLDetailCircleHeaderCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self stepUI];
    }
    return self;
}

- (void)stepUI{
    
    @weakify(self);
    // 头像
    self.avatarView = self.addButton(3001)
    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        @strongify(self);
        //        [self e_didClickUser];
    }).masonry(^ (MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.size.mas_equalTo(40);
    })
    .view;
    
    // 用户名
    self.nameView = self.addButton(1002)
    .backgroundColor([UIColor clearColor]).backgroundColorHL([UIColor lightGrayColor])
    .titleFont([UIFont boldSystemFontOfSize:16.0f]).titleColor(CFontColor1)
    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        @strongify(self);
        //        [self e_didClickUser];
    })
    .masonry(^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarView);
        make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(10);
        make.right.mas_lessThanOrEqualTo(-10);
        make.height.mas_equalTo(18.0f); 
    })
    .view;
    
    // 时间
    self.dateLabel = self.addLabel(3001)
    .font([UIFont systemFontOfSize:12.0f]).textColor(CFontColor4)
    .masonry(^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameView.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(10);
        make.right.mas_lessThanOrEqualTo(-15);
    })
    .view;
    
    // 正文
    self.titleLabel = self.addLabel(1011).textColor(CFontColor1)
    .font([UIFont systemFontOfSize:14.0f]).numberOfLines(0)
    .masonry (^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dateLabel.mas_bottom).mas_offset(6);
        make.left.mas_equalTo(self.dateLabel);
        make.right.mas_lessThanOrEqualTo(-15);
    })
    .view;
    
    self.ImagesView = [[TLMomentDetailImagesView alloc] initWithImageSelectedAction:^(NSArray *images, NSInteger index) {
        @strongify(self);
        //        if (self.delegate && [self.delegate respondsToSelector:@selector(momentViewClickImage:atIndex:cell:)]) {
        //            [self.delegate momentViewClickImage:images atIndex:index cell:self];
        //        }
    }];
    [self addSubview:self.ImagesView];


}

- (void)setMoment:(TLMoment *)moment
{
    //    _moment = moment;
    
    // 头像
    NSString*url=NSStringFormat(@"%@/files/%@",EmallHostUrl,moment.customer.id);
    
    //    [imageView tt_setImageWithURL:[NSURL URLWithString:url]  forState:UIControlStateNormal];
    
    [self.avatarView tt_setImageWithURL:TLURL(url) forState:UIControlStateNormal placeholderImage:TLImage(DEFAULT_AVATAR_PATH)];
    // 用户名
    self.nameView.zz_make.title(moment.customer.name);
    
    // 时间
    [self.dateLabel setText:moment.showDate];
    
    // 正文
    [self.titleLabel setText:moment.detail.text];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(moment.detail.detailFrame.heightText);
    }];
    
    self.ImagesView.images = moment.detail.images;
    [self.ImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(moment.detail.text.length > 0 ? 10.0f : 0);
        make.left.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(moment.detail.detailFrame.heightImages);
    }];
    
    self.lineView = self.addView(1012).backgroundColor(UIColorFromRGB(233, 233, 233))
    .masonry(^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ImagesView.mas_bottom).mas_offset(6);
        make.height.mas_equalTo(10);
        make.left.right.mas_equalTo(self);
    })
    .view;
    
    self.commentLabel = self.addLabel(1013).text(@"评论 76").textAlignment(NSTextAlignmentLeft)
    .font(FontOfSize(14)).textColor(CFontColor1)
    .masonry(^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(12);
        make.height.mas_equalTo(21);
        make.left.mas_equalTo(self.avatarView);
        make.width.mas_equalTo(120);
        
    })
    .view;
    
    self.likeLabel = self.addLabel(1014).text(@"点赞 16").textAlignment(NSTextAlignmentRight)
    .font(FontOfSize(14)).textColor(CFontColor1)
    .masonry(^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(12);
        make.height.mas_equalTo(21);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(120);
    })
    .view;
    
    
}

@end
