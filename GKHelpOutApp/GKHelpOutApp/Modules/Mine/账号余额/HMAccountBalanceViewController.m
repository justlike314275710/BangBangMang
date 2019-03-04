//
//  HMAccountBalanceViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMAccountBalanceViewController.h"
#import "MineTableViewCell.h"

@interface HMAccountBalanceViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *_dataSource;
}
@property(nonatomic, strong) YYAnimatedImageView *headImgView; //头像
@property(nonatomic, strong) UIView *headView;

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
    
    [self.view addSubview:self.headImgView];
    self.tableView.frame = CGRectMake(0,_headImgView.bottom+50, KScreenWidth, KScreenHeight - kTopHeight - kTabBarHeight-_headImgView.bottom-50);
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"MineTableViewCell"];
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    NSDictionary *Modifydata = @{@"titleText":@"昵称",@"clickSelector":@"",@"detailText":@"张三三",@"arrow_icon":@"myarrow_icon"};
    
    NSDictionary *myMission = @{@"titleText":@"手机号码",@"clickSelector":@"",@"detailText":@"1378726999",@"arrow_icon":@"myarrow_icon"};
    
    NSDictionary *myFriends = @{@"titleText":@"家庭住址",@"clickSelector":@"",@"arrow_icon":@"myarrow_icon",@"detailText":@"天安门广场"};
    NSDictionary *myLevel = @{@"titleText":@"邮政编码",@"clickSelector":@"",@"detailText":@"410000",@"arrow_icon":@"myarrow_icon"};
    
    _dataSource = @[Modifydata,myMission,myFriends,myLevel];
    [self.tableView reloadData];
    
}

#pragma mark - Delegate&Datalist
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
////    self.headView.frame = CGRectMake(0, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
////    return self.headView;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell" forIndexPath:indexPath];
    cell.cellData = _dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
        }
            break;
        case 1:
        {
        }
            break;
        case 2:
        {
        }
            break;
        case 3:
        {
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 修改昵称
#pragma mark -Setting&Getting
-(YYAnimatedImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [YYAnimatedImageView new];
        _headImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headImgView.backgroundColor = [UIColor redColor];
        _headImgView.userInteractionEnabled = YES;
        [_headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewClick)]];
        _headImgView.frame = CGRectMake((self.view.width-90*Iphone6ScaleWidth)/2,35, 100*Iphone6ScaleWidth, 100*Iphone6ScaleWidth);
        ViewRadius(_headImgView, (100*Iphone6ScaleWidth)/2);
        [self.view addSubview:_headImgView];
        [_headImgView setImageWithURL:[NSURL URLWithString:help_userManager.curUserInfo.avatar] options:YYWebImageOptionRefreshImageCache];
    }
    return _headImgView;
}

#pragma mark - TouchEvent
-(UIView*)headView{
    if (!_headView) {
        _headView = [UIView new];
    }
    return _headView;
}
-(void)headViewClick {
    
}



@end
