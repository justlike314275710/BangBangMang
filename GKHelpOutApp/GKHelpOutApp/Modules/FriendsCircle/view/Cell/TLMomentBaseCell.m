//
//  TLMomentBaseCell.m
//  TLChat
//
//  Created by libokun on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentBaseCell.h"
#import "TLMomentExtensionView.h"
#import "DGThumbUpButton.h"

@interface TLMomentBaseCell ()

/// 头像
@property (nonatomic, strong) UIButton *avatarView;
/// 用户名
@property (nonatomic, strong) UIButton *nameView;
/// 正文
@property (nonatomic, strong) UILabel *titleLabel;

/// 点赞&评论
@property (nonatomic, strong) TLMomentExtensionView *extensionView;

/// 链接
//@property (nonatomic, strong) UIButton *linkButton;
/// 时间
@property (nonatomic, strong) UILabel *dateLabel;
/// 来源
//@property (nonatomic, strong) UILabel *originLabel;
/// 更多按钮
//@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) UILabel *shareLabel;

@property (nonatomic, strong) UIButton *commentButton;

@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) DGThumbUpButton *LikeButton;

@property (nonatomic, strong) UILabel *LikeLabel;

@end

@implementation TLMomentBaseCell

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(TLMoment *)dataModel
{
    CGFloat height = dataModel.momentFrame.height;
    return height;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setMoment:dataModel];
}

- (void)setViewDelegate:(id)delegate
{
    self.delegate = delegate;
}

#pragma mark - # Cell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self SDWebImageAuth];
        [self p_initSubviews];
    }
    return self;
}
-(void)SDWebImageAuth{
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [SDWebImageManager.sharedManager.imageDownloader setValue:token forHTTPHeaderField:@"Authorization"];
    [SDWebImageManager sharedManager].imageCache.config.maxCacheAge=5*60.0;
    
}

- (void)setMoment:(TLMoment *)moment
{
    _moment = moment;
    
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
    [self.detailContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(moment.detail.text.length > 0 ? 10.0f : 0);
    }];
    
    
    /*
    // 点赞&评论
    [self.extensionView setHidden:!moment.hasExtension];
    [self.extensionView setExtension:moment.extension];
    [self.extensionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(moment.momentFrame.heightExtension);
        make.bottom.mas_equalTo(moment.hasExtension ? -15 : -10);
    }];
    [self.moreButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.extensionView.mas_top).mas_offset(moment.hasExtension ? -3 : 0);
    }];
     
     */

    // 来源
//    [self.originLabel setText:moment.source];
    // 链接
//    self.linkButton.zz_make.title(moment.link.title).hidden(moment.link.title.length == 0);
}

#pragma mark - # UI
- (void)p_initSubviews
{
    @weakify(self);
    
    // 头像
    self.avatarView = self.contentView.addButton(1001)
    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        @strongify(self);
        [self e_didClickUser];
    })
    .masonry(^ (MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.size.mas_equalTo(40);
    })
    .view;
    
    // 用户名
    self.nameView = self.contentView.addButton(1002)
    .backgroundColor([UIColor clearColor]).backgroundColorHL([UIColor lightGrayColor])
    .titleFont([UIFont boldSystemFontOfSize:16.0f]).titleColor(CFontColor1)
    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        @strongify(self);
        [self e_didClickUser];
    })
    .masonry(^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarView);
        make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(10);
        make.right.mas_lessThanOrEqualTo(-10);
        make.height.mas_equalTo(18.0f);
    })
    .view;
    
    // 时间
    self.dateLabel = self.contentView.addLabel(3001)
    .font([UIFont systemFontOfSize:12.0f]).textColor(CFontColor4)
    .masonry(^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameView.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(10);
        make.right.mas_lessThanOrEqualTo(-15);
    })
    .view;
    
    // 正文
    self.titleLabel = self.contentView.addLabel(1011).textColor(CFontColor1)
    .font([UIFont systemFontOfSize:14.0f]).numberOfLines(0)
    .masonry (^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dateLabel.mas_bottom).mas_offset(6);
        make.left.mas_equalTo(self.dateLabel);
        make.right.mas_lessThanOrEqualTo(-15);
    })
    .view;
    
    self.detailContainer = self.contentView.addView(1020)
    .masonry(^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.left.mas_equalTo(self.nameView);
        make.right.mas_equalTo(-15);
    })
    .view;
    
    //分享
    self.shareButton = self.contentView.addButton(1040).backgroundImage(IMAGE_NAMED(@"分享icon")).eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        @strongify(self);
        [self didClicKShare];
    }).masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameView);
        make.width.height.mas_equalTo(16);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
    })
    .view;
    
    self.shareLabel = self.contentView.addLabel(1041).backgroundColor([UIColor clearColor]).textColor(CFontColor4).font(FontOfSize(12)).text(@"分享")
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shareButton.mas_right).mas_offset(3);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(self.shareButton);
    })
    .view;
    
    //评论
    self.commentButton = self.contentView.addButton(1042).backgroundImage(IMAGE_NAMED(@"评论icon")).eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        @strongify(self);
        [self didClicKComment];
    }).masonry(^ (MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.detailContainer.mas_centerX).mas_offset(-15);
        make.width.height.mas_equalTo(16);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
    })
    .view;
    
    self.commentLabel = self.contentView.addLabel(1043).backgroundColor([UIColor clearColor]).textColor(CFontColor4).font(FontOfSize(12)).text(@"评论")
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commentButton.mas_right).mas_offset(3);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(self.commentButton);
    })
    .view;
    
    //点赞
    self.LikeButton = [[DGThumbUpButton alloc] init];
    [self.contentView addSubview:self.LikeButton];
    [self.LikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.detailContainer).mas_offset(-33);
        make.width.height.mas_equalTo(16);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
    }];
    [self.LikeButton addTapBlock:^(UIButton *btn) {
        @strongify(self);
        [self didClicKLike];
    }];
    
//    self.LikeButton = self.contentView.addButton(1044).backgroundImage(IMAGE_NAMED(@"未点赞icon"))
//    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
//        @strongify(self);
////        if (self.delegate && [self.delegate respondsToSelector:@selector(momentViewWithModel:jumpToUrl:)]) {
////            [self.delegate momentViewWithModel:self.moment jumpToUrl:self.moment.link.jumpUrl];
////
////        }
//    })
//    .masonry(^ (MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.detailContainer).mas_offset(-33);
//        make.width.height.mas_equalTo(16);
//        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
//    })
//    .view;
    
    self.LikeLabel = self.contentView.addLabel(1045).backgroundColor([UIColor clearColor]).textColor(CFontColor4).font(FontOfSize(12)).text(@"23")
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(self.LikeButton.mas_right).mas_offset(3);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(self.LikeButton);
    })
    .view;
    
    
    /*
    // 点赞&评论
    [self.contentView addSubview:self.extensionView];
    [self.extensionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameView);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-15);
    }];

     
    // 更多按钮
    self.moreButton = self.contentView.addButton(3003)
    .image(TLImage(@"moments_more")).imageHL(TLImage(@"moments_moreHL"))
    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        
    })
    .masonry(^ (MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.bottom.mas_equalTo(self.extensionView.mas_top);
    })
    .view;

    // 来源
    self.originLabel = self.contentView.addLabel(3002)
    .font([UIFont systemFontOfSize:12.0f]).textColor([UIColor grayColor])
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dateLabel.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.dateLabel);
    })
    .view;
    
    // 链接
    self.linkButton = self.contentView.addButton(3010)
    .backgroundColor([UIColor clearColor]).backgroundColorHL([UIColor lightGrayColor])
    .titleFont([UIFont systemFontOfSize:13.0f]).titleColor([UIColor colorBlueMoment])
    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        @strongify(self);
        if (self.delegate && [self.delegate respondsToSelector:@selector(momentViewWithModel:jumpToUrl:)]) {
            [self.delegate momentViewWithModel:self.moment jumpToUrl:self.moment.link.jumpUrl];
        }
    })
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameView);
        make.right.mas_lessThanOrEqualTo(-10);
        make.bottom.mas_equalTo(self.dateLabel.mas_top).mas_offset(-6);
        make.height.mas_equalTo(20);
    })
    .view;
     */
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.addSeparator(ZZSeparatorPositionBottom);
}

#pragma mark - # Event
- (void)e_didClickUser
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(momentViewWithModel:didClickUser:)]) {
        [self.delegate momentViewWithModel:self.moment didClickUser:self.moment.user];
    }
}
//分享
-(void)didClicKShare{
    if (self.delegate && [self.delegate respondsToSelector:@selector(momentViewWithModel:didClickShare:)]) {
        [self.delegate momentViewWithModel:self.moment didClickShare:nil];
    }
}
//点赞
-(void)didClicKLike{
    if (self.delegate && [self.delegate respondsToSelector:@selector(momentViewWithModel:didClickLike:)]) {
        [self.delegate momentViewWithModel:self.moment didClickLike:nil];
    }
}
//评论
-(void)didClicKComment{
    if (self.delegate && [self.delegate respondsToSelector:@selector(momentViewWithModel:didClickComment:)]) {
        [self.delegate momentViewWithModel:self.moment didClickComment:nil];
    }
}

#pragma mark - # Getters
- (TLMomentExtensionView *)extensionView
{
    if (!_extensionView) {
        _extensionView = [[TLMomentExtensionView alloc] init];
        [_extensionView setHidden:YES];
    }
    return _extensionView;
}

//-(DGThumbUpButton *)LikeButton {
//    if (!_LikeButton) {
//        _LikeButton = [[DGThumbUpButton alloc] init];
//    }
//    return _LikeButton;
//}

@end
