//
//  LawyerAdviceTableViewCell.h
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawyerGrab.h"
@interface LawyerAdviceTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *noReadDotImg;   //未读
@property (nonatomic,strong) UIImageView *avatarImg;      //头像
@property (nonatomic,strong) UIImageView *stateImg;       //订单状态
@property (nonatomic,strong) UILabel *moneyLab;           //订单金钱
@property (nonatomic,strong) UILabel *timeLab;            //订单时间
@property (nonatomic,strong) UILabel *typeLab;            //订单类型
@property (nonatomic,strong) UILabel *detailLab;          //订单类型
@property (nonatomic,strong) UIButton *chatBtn;           //立即沟通
@property (nonatomic,assign)BOOL noRead;
@property (nonatomic , strong) UILabel *lawyerMoneyLab;
-(void)fillWithModel:(lawyerGrab*)model;
@end
