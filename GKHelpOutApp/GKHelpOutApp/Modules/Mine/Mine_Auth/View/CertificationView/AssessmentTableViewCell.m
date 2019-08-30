//
//  AssessmentTableViewCell.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/2/26.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "AssessmentTableViewCell.h"

@implementation AssessmentTableViewCell

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
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.cameraButton];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable=[[UILabel alloc]initWithFrame:CGRectMake(15, 45,self.contentView .frame.size.width , 20)];
        _titleLable.text=@"律师年度考核备案照片";
        _titleLable.font=[UIFont systemFontOfSize:12];
        _titleLable.textColor=[UIColor blackColor];
    }
    return _titleLable;
}

- (UIButton *)cameraButton{
    if (!_cameraButton) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setImage:[UIImage imageNamed:@"上传图片"] forState:UIControlStateNormal];
        _cameraButton.frame=CGRectMake(SCREEN_WIDTH-64-15, 15, 64, 64);
    }
    return _cameraButton;
}

@end
