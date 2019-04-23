//
//  DetailLifeCircleViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/4/23.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "DetailLifeCircleViewController.h"
#import "LifeCircleViewController.h"
#import "TLMoment.h"
#import "TLMomentImagesCell.h"
#import "TLMomentDetailImagesView.h"


@interface DetailLifeCircleViewController ()
@property(nonatomic,strong)UIButton *avatarView;
@property(nonatomic,strong)UIButton *nameView;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *detailContainer;
@property(nonatomic,strong)TLMomentDetailImagesView *ImagesView;
@end

@implementation DetailLifeCircleViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"朋友圈";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self stepUI];
    [self setMoment:self.datalist[0]];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

#pragma mark - Private Methods
- (void)stepUI{
    // 头像
    @weakify(self);
    self.avatarView = self.view.addButton(3001)
    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        @strongify(self);
//        [self e_didClickUser];
    }).backgroundColor([UIColor redColor])
    .masonry(^ (MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.size.mas_equalTo(40);
    })
    .view;
    
    // 用户名
    self.nameView = self.view.addButton(1002)
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
    self.dateLabel = self.view.addLabel(3001)
    .font([UIFont systemFontOfSize:12.0f]).textColor(CFontColor4)
    .masonry(^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameView.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(10);
        make.right.mas_lessThanOrEqualTo(-15);
    })
    .view;
    
    // 正文
    self.titleLabel = self.view.addLabel(1011).textColor(CFontColor1)
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
    [self.view addSubview:self.ImagesView];
    [self.ImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];

//    self.detailContainer = self.view.addView(1020)
//    .masonry(^ (MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.titleLabel.mas_bottom);
//        make.left.mas_equalTo(self.nameView);
//        make.right.mas_equalTo(-15);
//    })
//    .view;
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
    
    [self.ImagesView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(moment.detail.text.length > 0 ? 10.0f : 0);
    }];
}
    

@end
