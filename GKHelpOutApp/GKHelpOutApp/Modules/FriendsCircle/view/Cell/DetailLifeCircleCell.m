//
//  DetailLifeCircleCell.m
//  GKHelpOutApp
//
//  Created by kky on 2019/4/23.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "DetailLifeCircleCell.h"
@interface DetailLifeCircleCell()

@property(nonatomic,strong)UIButton *avatarView;
@property(nonatomic,strong)UIButton *nameView;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation DetailLifeCircleCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
