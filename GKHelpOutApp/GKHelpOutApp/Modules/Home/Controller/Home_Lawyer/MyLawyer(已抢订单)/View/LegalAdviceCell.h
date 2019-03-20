//
//  LegalAdviceCell.h
//  GKHelpOutApp
//
//  Created by kky on 2019/2/26.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSConsultation.h"
@interface LegalAdviceCell : UITableViewCell


@property (nonatomic,strong) UIImageView *noReadDotImg;   //未读
@property (nonatomic,strong) UIImageView *avatarImg;      //头像
@property (nonatomic,strong) UIImageView *stateImg;       //订单状态
@property (nonatomic,strong) UILabel *moneyLab;           //订单金钱
@property (nonatomic,strong) UILabel *timeLab;            //订单时间
@property (nonatomic,strong) UILabel *typeLab;            //订单类型
@property (nonatomic,strong) UILabel *detailLab;          //订单类型
@property (nonatomic,strong) UIButton *chatBtn;           //立即沟通
@property (nonatomic,assign)BOOL noRead;

@property (nonatomic , strong) UILabel *lawyerMoneyLab;//样式作为律师端时的订单金钱
-(void)fillWithModel:(PSConsultation*)model;
@end


