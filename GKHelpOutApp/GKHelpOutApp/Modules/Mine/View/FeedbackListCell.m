//
//  FeedbackListCell.m
//  PrisonService
//
//  Created by kky on 2018/12/24.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "FeedbackListCell.h"
//#import <HUPhotoBrowser/HUPhotoBrowser.h>
//#import "PSPhotoBrowser.h"
//#import "NSString+Date.h"


@interface FeedbackListCell ()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *dateLab;
@property(nonatomic,strong)UILabel *detailLab;
@property(nonatomic,strong)UIView  *contenView;


@end

@implementation FeedbackListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self renderContents];
    }
    return self;
}

- (void)renderContents {
    
    [self addSubview:self.bgView];
    
    self.titleLab.frame = CGRectMake(8, 8, 200, 35);
    [_bgView addSubview:self.titleLab];
    
    self.dateLab.frame = CGRectMake(SCREEN_WIDTH-120, 8,100 , 35);
    [_bgView addSubview:self.dateLab];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(8,self.titleLab.bottom+8,SCREEN_WIDTH-16, 1)];
    lineView.backgroundColor = UIColorFromRGB(234, 235, 238);
    [_bgView addSubview:lineView];
    
    self.detailLab.frame = CGRectMake(8,lineView.bottom+5, SCREEN_WIDTH-16, 40);
    [_bgView addSubview:self.detailLab];

}

- (void)setModel:(FeedbackTypeModel *)model {
    _model = model;
    
    NSString *title = model.desc.length>0?[NSString stringWithFormat:@"%@: %@",model.typeName,model.desc]:model.typeName;
    self.titleLab.text = title;
    if ([model.writefeedType integerValue]==0) {
//        NSString*repalyTime=[model.createdAt timestampToDateString];
//        self.dateLab.text = repalyTime;
        self.detailLab.text = model.content;
    } else {
        NSString*repalyTime=model.createdAt;
        repalyTime = repalyTime.length>10?[repalyTime substringToIndex:10]:repalyTime;
        self.dateLab.text = repalyTime;
        self.detailLab.text = model.contents;
      
    }
    
    int spaceWidth = (SCREEN_WIDTH-15*2-67*4)/3;
    NSMutableArray *imagesicon = [NSMutableArray array];
    
    NSArray *imageUrls = [NSArray array];
    if (model.imageUrls.length > 0) {
        if ([model.imageUrls hasSuffix:@";"]) {
            model.imageUrls = [model.imageUrls substringToIndex:model.imageUrls.length-1];
        }
        imageUrls = [model.imageUrls componentsSeparatedByString:@";"];
        self.bgView.height = 180;
    } else {
        self.bgView.height = 110;
    }
    for (int i = 0; i<imageUrls.count; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15+(67+spaceWidth)*i,self.detailLab.bottom+5, 67, 67)];
        /*
        NSString *url = imageUrls[i];
        [imageV sd_setImageWithURL:[NSURL URLWithString:PICURL(url)] placeholderImage:[UIImage R_imageNamed:@"DefalutImg"]];
        
        if (url)[imagesicon addObject:PICURL(url)];
        imageV.tag = i+100;
        imageV.userInteractionEnabled = YES;
        [imageV bk_whenTapped:^{
            [HUPhotoBrowser showFromImageView:imageV withURLStrings:imagesicon atIndex:i];
        }];
         */
        [_bgView addSubview:imageV];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Setting&&Getting
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0,5,SCREEN_WIDTH,180)];
        _bgView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        _bgView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _bgView.layer.shadowOffset = CGSizeMake(0,3);
        _bgView.layer.shadowOpacity = 1;
        _bgView.layer.shadowRadius = 4;
    }
    return _bgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = FontOfSize(12);
        _titleLab.textColor = UIColorFromRGB(51, 51, 51);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.numberOfLines = 0;
        _titleLab.text = @"功能异常：功能故障或不可使用";
    }
    return _titleLab;
}

- (UILabel *)dateLab {
    if (!_dateLab) {
        _dateLab = [UILabel new];
        _dateLab.font = FontOfSize(10);
        _dateLab.textColor = UIColorFromRGB(153, 153, 153);
        _dateLab.textAlignment = NSTextAlignmentRight;
        _dateLab.numberOfLines = 0;
        _dateLab.text = @"2018-11-20";
    }
    return _dateLab;
}

- (UILabel *)detailLab {
    if (!_detailLab) {
        _detailLab = [UILabel new];
        _detailLab.font = FontOfSize(11);
        _detailLab.textColor = UIColorFromRGB(102, 102, 102);
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.numberOfLines = 0;
        _detailLab.text = @"为什么我申请了好几次，总是申请不成功？我的信息没有填写错误， 到底是哪里出了问题？";
    }
    return _detailLab;
}


@end
