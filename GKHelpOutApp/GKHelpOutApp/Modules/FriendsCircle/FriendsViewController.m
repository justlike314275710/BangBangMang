//
//  FriendsViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/4/15.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "FriendsViewController.h"
#import "TLMenuItem.h"
#import "LifeCircleViewController.h"
#import "UINavigationBar+Awesome.h"
#import "UITabBar+CustomBadge.h"

typedef NS_ENUM(NSInteger, TLDiscoverSectionTag) {
    TLDiscoverSectionTagMoments,
    TLDiscoverSectionTagFounction,
    TLDiscoverSectionTagStudy,
    TLDiscoverSectionTagSocial,
    TLDiscoverSectionTagLife,
    TLDiscoverSectionTagProgram,
};

typedef NS_ENUM(NSInteger, TLDiscoverCellTag) {
    TLDiscoverCellTagMoments,       // 好友圈
    TLDiscoverCellTagScaner,        // 扫一扫
    TLDiscoverCellTagShake,         // 摇一摇
    TLDiscoverCellTagRead,          // 看一看
    TLDiscoverCellTagSearch,        // 搜一搜
    TLDiscoverCellTagNearby,        // 附近的人
    TLDiscoverCellTagBottle,        // 漂流瓶
    TLDiscoverCellTagShopping,      // 购物
    TLDiscoverCellTagGame,          // 游戏
    TLDiscoverCellTagProgram,       // 小程序
};

@interface FriendsViewController ()
@property (nonatomic,copy) NSString *username;

@end

@implementation FriendsViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CViewBgColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.mycollectionView.hidden = YES;
    self.tableView.hidden = YES;
    self.username = @"";
    
}
-(void)loadView {
    [super loadView];
    [self loadMenus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self refreshLifeTabbar];
    
}

#pragma mark ————— 生活圈底部tabbar —————
-(void)refreshLifeTabbar {
    [[LifeCircleManager sharedInstance] requestLifeCircleNewDatacompleted:^(BOOL successful, NSString *tips) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (successful) {
                [self.tabBarController.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:1 atIndex:2];
                self.username = tips;
            } else {
                [self.tabBarController.tabBar setBadgeStyle:kCustomBadgeStyleNone value:0 atIndex:2];
                self.username = tips;
            }
            [self loadMenus];
        });
    }];
}

#pragma mark - PrivateMethods
//MARK: UI
-(void)loadMenus {
    @weakify(self);
    
    BOOL isBadge = self.username.length>0?YES:NO;
    NSString *url = AvaterImageWithUsername(self.username);

    self.clear();
    //朋友圈
    {
        NSInteger sectionTag = TLDiscoverSectionTagMoments;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        TLMenuItem *moments = createMenuItem(@"生活圈icon", LOCSTR(@"生活圈"));
        if (isBadge) {
            [moments setRightIconURL:url withRightIconBadge:isBadge];
        }
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(moments).selectedAction(^ (TLMenuItem *data) {
            @strongify(self);
            LifeCircleViewController *LifeCircleVC = [[LifeCircleViewController alloc] init];
            LifeCircleVC.lifeCircleStyle = self.lifeCircleStyle;
            PushVC(LifeCircleVC);
        });
    }
    
    // 功能
    {
        NSInteger sectionTag = TLDiscoverSectionTagFounction;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        // 扫一扫
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(createMenuItem(@"扫一扫icon", LOCSTR(@"扫一扫"))).selectedAction(^ (TLMenuItem *data) {
            @strongify(self);
//            TLScanningViewController *scannerVC = [[TLScanningViewController alloc] init];
//            PushVC(scannerVC);
//            LifeCircleViewController *LifeCircleVC = [[LifeCircleViewController alloc] init];
//            [self.navigationController pushViewController:LifeCircleVC animated:YES];
            [PSTipsView showTips:Hmsg_Comingsoon];
        });
    }
    [self reloadView];
    
}


@end
