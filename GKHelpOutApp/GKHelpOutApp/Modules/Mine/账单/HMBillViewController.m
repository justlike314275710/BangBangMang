//
//  HMBillViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMBillViewController.h"
#import "HMBillCell.h"

@interface HMBillViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UILabel *headLab;


@end

@implementation HMBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单";
    [self setupUI];
}
#pragma mark - PrivateMethods

-(void)setupUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight-kTabBarHeight-kStatusBarHeight) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[HMBillCell class] forCellReuseIdentifier:@"HMBillCell"];
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - Delegate
//MARK:UITableViewDataSource&UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HMBillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HMBillCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 55)];
    UILabel *monthLab = [[UILabel alloc] initWithFrame:CGRectMake(15,10,200,20)];
    monthLab.text = @"本月";
    monthLab.font = FFont1;
    monthLab.textColor = CFontColor1;
    monthLab.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:monthLab];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15,monthLab.bottom+2,bgView.width-30,20)];
    lable.text = @"充值¥100.00 退款¥100.00 消费¥10.00";
    lable.font = FFont1;
    lable.textColor = CFontColor2;
    lable.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:lable];
    
    return bgView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}









@end
