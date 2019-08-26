//
//  HMGetCashResultViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMGetCashResultViewController.h"
#import "MineTableViewCell.h"
#import "NSString+Utils.h"

@interface HMGetCashResultViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataSource;
    NSString *_nowTime;
    NSString *_twoHourLateTime;
}
@property(nonatomic, strong) YYAnimatedImageView *headImgView; //头像
@property(nonatomic, strong) UILabel *stateLab; //头像

@end

@implementation HMGetCashResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提现详情";
    self.isShowLiftBack = YES;
    
    [self intData];
    [self setupUI];
}
- (void)intData{
    _nowTime = [NSString getCurrentTimes];
    
    _twoHourLateTime = [NSString getTimeFromTimestamp:[[NSString getNowTimeTimestamp] doubleValue] + 7200];
    
    NSLog(@"%@",_twoHourLateTime);
    
}

-(void)setupUI{
    
    [self.view addSubview:self.headImgView];
    if (self.getCashState == PSGetCashScuess) {
        self.headImgView.image = IMAGE_NAMED(@"已提交图");
        self.stateLab.text = @"提现申请已提交";
    } 
    [self.view addSubview:self.stateLab];
    self.stateLab.frame = CGRectMake((KScreenWidth-200)/2,self.headImgView.bottom+10, 200, 30);
    self.tableView.frame = CGRectMake(0,_headImgView.bottom+50, KScreenWidth, KScreenHeight - kTopHeight - kTabBarHeight-_headImgView.bottom-50);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"MineTableViewCell"];
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    NSDictionary *Modifydata = @{@"titleText":@"提现申请时间",@"detailText":_nowTime};
    NSDictionary *myMission = @{@"titleText":@"预计到账时间",@"detailText":_twoHourLateTime};
    NSDictionary *myFriends = @{@"titleText":@"支付宝姓名",@"detailText":help_userManager.lawUserInfo.nickName};
    NSDictionary *myLevel = @{@"titleText":@"支付宝账户",@"detailText":help_userManager.curUserInfo.username};
    NSDictionary *failReason = @{@"titleText":@"提现金额",@"detailText":self.cash};
    
    _dataSource = @[Modifydata,myMission,myFriends,myLevel,failReason];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellData = _dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self modifyNickName];
        }
            break;
        case 1:
        {
            [self modifyPhoneNumber];
        }
            break;
        case 2:
        {
            [self modifyAddress];
        }
            break;
        case 3:
        {
            [self modifyPostalcode];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 修改昵称
-(void)modifyNickName {
}
#pragma mark - 修改手机号码
-(void)modifyPhoneNumber{
}
#pragma mark - 修改家庭主址
-(void)modifyAddress{
    
}
#pragma mark - 修改邮政编码
-(void)modifyPostalcode{

}

-(YYAnimatedImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [YYAnimatedImageView new];
        _headImgView.contentMode = UIViewContentModeScaleAspectFill;
        //_headImgView.backgroundColor = [UIColor redColor];
        _headImgView.userInteractionEnabled = YES;
        [_headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewClick)]];
        _headImgView.frame = CGRectMake((self.view.width-90*Iphone6ScaleWidth)/2,35, 100*Iphone6ScaleWidth, 100*Iphone6ScaleWidth);
        ViewRadius(_headImgView, (100*Iphone6ScaleWidth)/2);
        [self.view addSubview:_headImgView];
        _headImgView.image = IMAGE_NAMED(@"提现失败图");
    }
    return _headImgView;
}

#pragma mark - TouchEvent
-(UILabel *)stateLab {
    if (!_stateLab) {
        _stateLab = [UILabel new];
        _stateLab.text=@"提现失败";
        _stateLab.textAlignment = NSTextAlignmentCenter;
        _stateLab.font=FontOfSize(16);
        _stateLab.textColor=KBlackColor;
    }
    return _stateLab;
}




@end
