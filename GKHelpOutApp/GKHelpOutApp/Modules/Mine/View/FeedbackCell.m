//
//  FeedbackCell.m
//  PrisonService
//
//  Created by kky on 2018/12/18.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "FeedbackCell.h"

@implementation FeedbackCell

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
    
    _seleImg = [[UIImageView alloc] initWithFrame:CGRectMake(20,(self.contentView.height-14)/2, 14, 14)];
    _seleImg.image = [UIImage imageNamed:@"writeFeednosel"];
    [self.contentView addSubview:_seleImg];
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(_seleImg.right+10,(self.contentView.height-30)/2, 250, 30)];
    _titleLab.font = FontOfSize(12);
    _titleLab.numberOfLines = 0;
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.textColor = UIColorFromRGB(102, 102, 102);
    [self.contentView addSubview:_titleLab];
    
    _lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(25, self.contentView.height-3,SCREEN_WIDTH-50,2)];
    _lineImg.image = [UIImage imageNamed:@"lineicon"];
    [self.contentView addSubview:_lineImg];

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
