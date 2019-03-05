//
//  HMAccountBalanceViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMAccountBalanceViewController.h"
#import "MineTableViewCell.h"
#import "LLActionSheetView.h"
#import "HMGetCashViewController.h"

@interface HMAccountBalanceViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>{
    NSArray *_dataSource;
}
@property(nonatomic, strong) UIView *headView;
@property(nonatomic, strong) UIImageView *HeadBgImg;
@property(nonatomic, strong) UILabel *balanceLab;
@property(nonatomic, strong) UILabel *k_balanceLab;

@end

@implementation HMAccountBalanceViewController

#pragma mark -lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户余额";
    [self setupData];
    [self setupUI];
}

#pragma mark -PravateMethods
-(void)setupData{
    
}
-(void)setupUI{
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, KScreenWidth, KScreenHeight - kTabBarHeight) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"MineTableViewCell"];
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    NSDictionary *Modifydata = @{@"titleText":@"支付宝账户",@"title_icon":@"支付宝账号icon",@"clickSelector":@"",@"detailText":@"未绑定",@"arrow_icon":@"myarrow_icon"};
    
    NSDictionary *myMission = @{@"titleText":@"申请提现",@"title_icon":@"申请提现icon",@"clickSelector":@"",@"arrow_icon":@"myarrow_icon"};
    
    _dataSource = @[Modifydata,myMission];
    [self.tableView reloadData];
    
}

#pragma mark - TouchEvent

#pragma mark - Delegate&Datalist
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell" forIndexPath:indexPath];
    cell.cellData = _dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.headView.frame = CGRectMake(0,0,KScreenWidth,200);
    self.HeadBgImg.frame = CGRectMake(24,30,KScreenWidth-48,154);
    self.k_balanceLab.frame = CGRectMake((self.HeadBgImg.width-200)/2,28,200, 20);
    self.balanceLab.frame = CGRectMake((self.HeadBgImg.width-200)/2,self.k_balanceLab.bottom+5,200,40);
    return self.headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            LLActionSheetView *alert = [[LLActionSheetView alloc]initWithTitleArray:@[@"解绑"] andShowCancel:YES];
            alert.ClickIndex = ^(NSInteger index) {
                if (index == 1){
//                    [weakSelf openAlbum];
                }else if (index == 2){
//                    [weakSelf openCamera];
                }
            };
            [alert show];
        }
            break;
        case 1:
        {
            HMGetCashViewController *GCashVC = [[HMGetCashViewController alloc] init];
            [self.navigationController pushViewController:GCashVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 修改昵称
#pragma mark -Setting&Getting
-(UIView*)headView{
    if (!_headView) {
        _headView = [UIView new];
        _headView.backgroundColor = KWhiteColor;
       [ _headView addSubview:self.HeadBgImg];
    }
    return _headView;
}
-(UIImageView*)HeadBgImg{
    if (!_HeadBgImg) {
        _HeadBgImg = [UIImageView new];
        _HeadBgImg.image = IMAGE_NAMED(@"矩形45");
        [_HeadBgImg addSubview:self.k_balanceLab];
        [_HeadBgImg addSubview:self.balanceLab];
    }
    return _HeadBgImg;
}
-(UILabel*)balanceLab{
    if (!_balanceLab) {
        _balanceLab=[UILabel new];
        _balanceLab.text = @"666.00";
        _balanceLab.textAlignment = NSTextAlignmentCenter;
        _balanceLab.font = FontOfSize(38);
        _balanceLab.textColor=KWhiteColor;
    }
    return _balanceLab;
}
-(UILabel*)k_balanceLab{
    if (!_k_balanceLab) {
        _k_balanceLab=[UILabel new];
        _k_balanceLab.text = @"当前余额";
        _k_balanceLab.textAlignment = NSTextAlignmentCenter;
        _k_balanceLab.font = FFont1;
        _k_balanceLab.textColor=UIColorFromRGB(228,227,227);
    }
    return _k_balanceLab;
}





@end
