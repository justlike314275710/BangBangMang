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

#define NAVBAR_CHANGE_POINT 50

typedef NS_ENUM(NSInteger, TLMomentsVCSectionType) {
    TLMomentsVCSectionTypeHeader,
    TLMomentsVCSectionTypeItems,
};

typedef NS_ENUM(NSInteger, TLMomentsVCNewDataPosition) {
    TLMomentsVCNewDataPositionHead,
    TLMomentsVCNewDataPositionTail,
};

@interface LifeCircleViewController ()<TLMomentViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate>
@property (nonatomic,strong) NSArray *datalist;

@end

@implementation LifeCircleViewController


- (void)loadView
{
    [super loadView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self setTitle:@"朋友圈"];
    [self setIsShowLiftBack:YES];
    [self requestDataWithPageIndex:0];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar lt_reset];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

#pragma mark - # Request
- (void)requestDataWithPageIndex:(NSInteger)pageIndex
{
    NSArray *data = [NSMutableArray arrayWithArray:[self testData]];
    _datalist = data;
    [self addMomentsData:data postion:TLMomentsVCNewDataPositionTail];
}

- (NSArray *)testData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Moments" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSArray *arr = [TLMoment mj_objectArrayWithKeyValuesArray:jsonArray];
    return arr;
}

#pragma mark - # UI
- (void)loadUI
{
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.bottom.right.left.mas_equalTo(self.view);
    }];
    
    @weakify(self);
//    [self addRightBarButtonWithImage:TLImage(@"nav_camera") actionBlick:^{
//        @strongify(self);
//    }];
    // 头图
    self.addSection(TLMomentsVCSectionTypeHeader);
    UserInfo *user = help_userManager.curUserInfo;
    self.addCell(@"TLMomentHeaderCell").toSection(TLMomentsVCSectionTypeHeader).withDataModel(user);
    
    // 列表
    self.addSection(TLMomentsVCSectionTypeItems);
}

- (void)addMomentsData:(NSArray *)momentsData postion:(TLMomentsVCNewDataPosition)position
{
    if (position == TLMomentsVCSectionTypeHeader) {
        self.insertCells(@"TLMomentImagesCell").toIndex(0).toSection(TLMomentsVCSectionTypeItems).withDataModelArray(momentsData);
    }
    else {
        self.addCells(@"TLMomentImagesCell").toSection(TLMomentsVCSectionTypeItems).withDataModelArray(momentsData);
    }
}

#pragma mark - # Delegate
//MARK: TLMomentViewDelegate
- (void)momentViewWithModel:(TLMoment *)moment didClickUser:(UserInfo *)user
{
//    TLUserDetailViewController *userDatailVC = [[TLUserDetailViewController alloc] initWithUserModel:user];
//    PushVC(userDatailVC);
}

- (void)momentViewClickImage:(NSArray *)images atIndex:(NSInteger)index cell:(TLMomentImagesCell *)cell
{
    
    NSMutableArray *browserDataArr = [[NSMutableArray alloc] initWithCapacity:images.count];
    for (NSString *imageUrl in images) {
//        MWPhoto *photo = [MWPhoto photoWithURL:TLURL(imageUrl)];
//        [data addObject:photo];
        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
        data.url = TLURL(imageUrl);
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
//    TLWebViewController *webVC = [[TLWebViewController alloc] initWithUrl:url];
//    PushVC(webVC);
}

@end
