//
//  PSConsultationOtherTableViewCell.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/10/29.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <YYText/YYText.h>
typedef void(^ButtonClick)(NSString * text);
@interface PSConsultationOtherTableViewCell : UICollectionViewCell
@property (nonatomic , strong) UITextField *moneyTextField;
@property (nonatomic, strong) YYLabel *protocolLabel;
@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,copy) ButtonClick buttonAction;

- (void)handlerButtonAction:(ButtonClick)block;
- (UIImage *)imageWithColor:(UIColor *)color;

@end
