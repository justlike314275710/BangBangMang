//
//  LifeCircleViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/4/15.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "LifeCircleViewController.h"
#import "TLMoment.h"
#import "TLMomentViewDelegate.h"
#import "YBImageBrowser.h"
#import "TLMomentImagesCell.h"
#import "UINavigationBar+Awesome.h"
#import "SendLifeCircleViewController.h"
#import "LifeCircleLogic.h"
#import "DetailLifeCircleViewController.h"
#import "TLMomentHeaderCell.h"

#define NAVBAR_CHANGE_POINT 50

@interface LifeCircleViewController ()<TLMomentViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *datalist;
@property (nonatomic,strong) LifeCircleLogic *logic;
@property (nonatomic,strong) UITableView *tableview;

@end

@implementation LifeCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _logic = [[LifeCircleLogic alloc] init];
    _logic.lifeCircleStyle = self.lifeCircleStyle;
    [self loadUI];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setIsShowLiftBack:YES];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [UIApplication sharedApplication].statusBarHidden=YES;
    //刷新朋友圈
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshData)
                                                 name:KNotificationRefreshCirCle
                                               object:nil];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        [self addNavigationItemWithImageNames:@[@"返回"] isLeft:YES target:self action:@selector(backBtnClicked) tags:@[@2001]];
        [self addNavigationItemWithImageNames:@[@"black拍照"] isLeft:NO target:self action:@selector(sendFriendCircle) tags:@[@3001]];
    } else {

        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        [self addNavigationItemWithImageNames:@[@"white返回"] isLeft:YES target:self action:@selector(backBtnClicked) tags:@[@2001]];
        [self addNavigationItemWithImageNames:@[@"white拍照"] isLeft:NO target:self action:@selector(sendFriendCircle) tags:@[@3001]];
    }
}
//MARKL:发朋友圈
- (void)sendFriendCircle{
    SendLifeCircleViewController *sendLifeCircleVC = [SendLifeCircleViewController new];
    [self.navigationController pushViewController:sendLifeCircleVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.collectionView.delegate = self;
    [self scrollViewDidScroll:self.collectionView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.collectionView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

#pragma mark - # UI
- (void)loadUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, KScreenWidth, KScreenHeight - kTopHeight -kTabBarHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.top.mas_equalTo(self.view);
    }];
    [self.tableView registerClass:[TLMomentImagesCell class] forCellReuseIdentifier:@"TLMomentImagesCell"];
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self refreshData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    [self setTableleUI];
    
}
-(void)setTableleUI {
    @weakify(self);
    if (_logic.hasNextPage) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMore];
        }];
    }else{
        self.tableView.mj_footer = nil;
    }
}
-(void)loadMore {
    [[PSLoadingView sharedInstance] show];
    [_logic loadMyLifeCircleListCompleted:^(id data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[PSLoadingView sharedInstance] dismiss];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            [self setTableleUI];
        });
    } failed:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[PSLoadingView sharedInstance] dismiss];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            [self setTableleUI];
        });
    }];

}

-(void)refreshData {
    [[PSLoadingView sharedInstance] show];
    [_logic refreshLifeCirclelistCompleted:^(id data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            [self setTableleUI];
            [[PSLoadingView sharedInstance] dismiss];
        });
    } failed:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            [self setTableleUI];
            [[PSLoadingView sharedInstance] dismiss];
        });
    }];
}

#pragma mark -   Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.logic.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLMomentImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLMomentImagesCell"];
    cell.delegate = self;
    TLMoment *monet = self.logic.datalist[indexPath.row];
    cell.moment = monet;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLMoment *monet = self.logic.datalist[indexPath.row];
    return monet.momentFrame.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TLMomentHeaderCell *headView = [[TLMomentHeaderCell alloc] init];
    headView.user = help_userManager.curUserInfo;
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 260;
}



#pragma mark - # Delegate
//MARK: TLMomentViewDelegate
- (void)momentViewWithModel:(TLMoment *)moment didClickUser:(UserInfo *)user
{
}
- (void)momentViewClickImage:(NSArray *)images atIndex:(NSInteger)index cell:(TLMomentImagesCell *)cell
{
    
    NSMutableArray *browserDataArr = [[NSMutableArray alloc] initWithCapacity:images.count];
    for (NSString *imageUrl in images) {
//        MWPhoto *photo = [MWPhoto photoWithURL:TLURL(imageUrl)];
//        [data addObject:photo];
        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
        NSString*url=NSStringFormat(@"%@/files/%@",EmallHostUrl,imageUrl);
        data.url = TLURL(url);
        data.sourceObject = [self sourceObjAtIdx:index cell:cell];
        [browserDataArr addObject:data];
        
    }
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = index;
    [browser show];
}

- (id)sourceObjAtIdx:(NSInteger)idx cell:(TLMomentImagesCell *)cell {
    UIButton *button = (UIButton *)cell.imagesView.imageViews[idx];
    return button.imageView? button.imageView: nil;
}
- (void)momentViewWithModel:(TLMoment *)moment jumpToUrl:(NSString *)url
{
    
}
//分享
- (void)momentViewWithModel:(TLMoment *)moment didClickShare:(NSString *)url {
    DetailLifeCircleViewController *detailLifeCircleVC = [[DetailLifeCircleViewController alloc] init];
    detailLifeCircleVC.datalist = @[moment];
    PushVC(detailLifeCircleVC);
}
//评论
- (void)momentViewWithModel:(TLMoment *)moment didClickComment:(NSString *)url{
    DetailLifeCircleViewController *detailLifeCircleVC = [[DetailLifeCircleViewController alloc] init];
    detailLifeCircleVC.datalist = @[moment];
    PushVC(detailLifeCircleVC);
}
//点赞
- (void)momentViewWithModel:(TLMoment *)moment didClickLike:(NSString *)url{
    
}

@end
