//
//  DetailLifeCircleViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/4/23.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "DetailLifeCircleViewController.h"
#import "LifeCircleViewController.h"
#import "TLMoment.h"
#import "DetailLifeCircleCell.h"
#import "TLDetailCircleHeaderCell.h"


@interface DetailLifeCircleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIButton *shareButton;
@property(nonatomic,strong)UIButton *commentButton;
@property(nonatomic,strong)UIButton *likeButton;


@end

@implementation DetailLifeCircleViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"朋友圈";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self stepUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
#pragma mark - Delegate
//MARK:UITableViewDelegate&UITableViewSources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailLifeCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailLifeCircleCell"];
    cell.moment = _datalist[0];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TLDetailCircleHeaderCell *headView = [[TLDetailCircleHeaderCell alloc] init];
    headView.moment = _datalist[0];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    TLMoment *monent = _datalist[0];
    return monent.detail.detailFrame.height+120; //84
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TLMoment *monent = _datalist[0];
    return monent.detail.detailFrame.heightText+75;
}

#pragma mark - Private Methods
- (void)stepUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-14);
        make.top.mas_equalTo(-20);
    }];
    [self.tableView registerClass:[DetailLifeCircleCell class] forCellReuseIdentifier:@"DetailLifeCircleCell"];
    
    self.bottomView = self.view.addView(100).backgroundColor(UIColorFromRGB(233, 233, 233)).masonry(^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.bottom.right.mas_equalTo(self.view);
    })
    .view;
    
    UIView *line1 = self.bottomView.addView(101).backgroundColor(UIColorFromRGB(153, 153, 153))
    .masonry(^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(KScreenWidth/3);
    })
    .view;
    
    UIView *line2 = self.bottomView.addView(101).backgroundColor(UIColorFromRGB(153, 153, 153))
    .masonry(^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(15);
        make.left.mas_equalTo((KScreenWidth/3)*2);
    })
    .view;
    
    self.shareButton = self.bottomView.addButton(102).image(IMAGE_NAMED(@"分享icon")).title(@"分享")
    .titleColor(CFontColor4).titleFont(FontOfSize(12)).titleEdgeInsets(UIEdgeInsetsMake(0,10, 0, 0))
    .masonry(^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(18);
        make.left.mas_equalTo(((KScreenWidth/3)-60)/2);
    })
    .view;
    
    self.commentButton = self.bottomView.addButton(103).image(IMAGE_NAMED(@"评论icon")).title(@"评论")
    .titleColor(CFontColor4).titleFont(FontOfSize(12)).titleEdgeInsets(UIEdgeInsetsMake(0,10, 0, 0))
    .masonry(^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(18);
        make.centerX.mas_equalTo(self.bottomView);

    })
    .view;
    
    self.likeButton = self.bottomView.addButton(104)
    .image(IMAGE_NAMED(@"未点赞icon"))
    .title(@"23")
    .titleColor(CFontColor4)
    .titleFont(FontOfSize(12))
    .titleEdgeInsets(UIEdgeInsetsMake(0,10, 0, 0))
    .masonry(^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(18);
        make.right.mas_equalTo(-((KScreenWidth/3)-60)/2);
    })
    .view;
}

#pragma mark - Setting&Getting
- (UITableView *)tableView {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.tableFooterView = [UIView new];
        _tableview.backgroundColor = [UIColor clearColor];
        _tableview.dataSource = self;
        _tableview.delegate = self;
    }
    return _tableview;
}
    

@end
