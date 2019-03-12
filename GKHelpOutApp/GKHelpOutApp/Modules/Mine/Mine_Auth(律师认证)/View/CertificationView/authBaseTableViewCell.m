//
//  authBaseTableViewCell.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/2/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "authBaseTableViewCell.h"

@implementation authBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self renderContents];
    }
    return self;
}

-(void)renderContents{
    [self addSubview:self.titleLbl];
    [self addSubview:self.detaileLbl];
    [self addSubview:self.arrowIcon];
}

- (void)setIsShow:(BOOL)isShow{
    if (isShow) {
        
    }
    else{
        self.detaileLbl.x=KNormalSpace+80+15;
    }
}


-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.font = SYSTEMFONT(12);
        _titleLbl.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _titleLbl.frame=CGRectMake(KNormalSpace, 11, 80, 20);

    }
    return _titleLbl;
}

-(UITextField *)detaileLbl{
    if (!_detaileLbl) {
        _detaileLbl = [UITextField new];
        _detaileLbl.font = SYSTEMFONT(12);
        _detaileLbl.textColor = KGrayColor;
        _detaileLbl.textAlignment =NSTextAlignmentRight;
        _detaileLbl.keyboardType = UIKeyboardTypeDefault;
        _detaileLbl.frame=CGRectMake(KNormalSpace+80, 11, SCREEN_WIDTH-80-22-2*KNormalSpace, 20);

    }
    return _detaileLbl;
}




-(UIImageView *)arrowIcon{
    if (!_arrowIcon) {
        _arrowIcon = [UIImageView new];
         [self.arrowIcon setImage:IMAGE_NAMED(@"arrow_icon")];
        _arrowIcon.frame=CGRectMake(SCREEN_WIDTH-KNormalSpace-18, 11, 22, 22);
    }
    return _arrowIcon;
}




@end
