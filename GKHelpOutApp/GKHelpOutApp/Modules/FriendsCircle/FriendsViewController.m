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

@end

@implementation FriendsViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMenus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - PrivateMethods
//MARK: UI
-(void)loadMenus {
    @weakify(self);
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.mas_equalTo(self.view);
    }];
    self.clear();
    //朋友圈
    {
        NSInteger sectionTag = TLDiscoverSectionTagMoments;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        TLMenuItem *moments = createMenuItem(@"生活圈icon", LOCSTR(@"生活圈"));
        [moments setRightIconURL:@"http://pic1.nipic.com/2008-08-14/2008814183939909_2.jpg" withRightIconBadge:YES];
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(moments).selectedAction(^ (TLMenuItem *data) {
            @strongify(self);
                LifeCircleViewController *LifeCircleVC = [[LifeCircleViewController alloc] init];
                [self.navigationController pushViewController:LifeCircleVC animated:YES];
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
            LifeCircleViewController *LifeCircleVC = [[LifeCircleViewController alloc] init];
            [self.navigationController pushViewController:LifeCircleVC animated:YES];
        });
    }
    [self reloadView];
//    [self resetTabBarBadge];
    
}





@end
