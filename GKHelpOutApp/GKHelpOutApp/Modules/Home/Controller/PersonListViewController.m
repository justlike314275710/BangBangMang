//
//  PersonListViewController.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/7/14.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "PersonListViewController.h"
#import "UploadAvatarViewController.h"
#import "PersonListLogic.h"
#import "WaterFlowLayout.h"
#import "PersonListCollectionViewCell.h"
#import "XYTransitionProtocol.h"
#import "UICollectionView+IndexPath.h"
#import "HomeViewController.h"
#import "ProfileViewController.h"
#import "PersonModel.h"
#import "UploadAvatarViewController.h"
#import "SDCycleScrollView.h"

#import "PSMoreServiceViewController.h"
#import "PSMoreServiceViewModel.h"


#define itemWidthHeight ((kScreenWidth-30)/2)
#define homespaceX  16

@interface PersonListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFlowLayoutDelegate,XYTransitionProtocol,PersonListLogicDelegate,SDCycleScrollViewDelegate>

@property(nonatomic,strong) PersonListLogic *logic;//逻辑层
@property(nonatomic,strong) UIView *topView;//置顶View
@property(nonatomic,strong) UIScrollView *scrollview;
@property(nonatomic,strong) SDCycleScrollView *cycleScrollview; //轮播图
@property(nonatomic,strong) UIImageView *waveImageView; //轮播图
@property(nonatomic,strong) UIButton *appleTreeBtn; //苹果树
@property(nonatomic,strong) UIButton *legalAdviceBtn;  //法律咨询
@property(nonatomic,strong) UIButton *psyAdviceBtn;  //心理咨询
@property(nonatomic,strong) UIButton *eleCommerceBtn;  //电子商务
@property(nonatomic,strong) UIButton *sysMsgBtn; //系统消息

@end

@implementation PersonListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowLiftBack = NO;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    self.isHidenNaviBar = YES;
    
    //初始化逻辑类
    _logic = [PersonListLogic new];
    _logic.delegagte = self;
    
    [self setupUI];
    //开始第一次数据拉取
//    [self.collectionView.mj_header beginRefreshing];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    /*
    if (help_userManager.curUserInfo.avatar||!help_userManager.curUserInfo.nickname) {
        UploadAvatarViewController *UploadVC = [[UploadAvatarViewController alloc] init];
        UserInfo *info = help_userManager.curUserInfo;
        NSLog(@"%@",help_userManager.curUserInfo);
        [self presentViewController:UploadVC animated:YES completion:nil];
    }
     */
}
#pragma mark ————— 初始化页面 —————
-(void)setupUI{
    //添加导航栏按钮
    [self.view addSubview:self.scrollview];
    [self.scrollview addSubview:self.cycleScrollview];
    [self.scrollview addSubview:self.waveImageView];
    
    //系统消息
    [self.scrollview addSubview:self.sysMsgBtn];
    self.sysMsgBtn.frame = CGRectMake(kScreenWidth-homespaceX-14,20,14, 14);
    
    self.waveImageView.frame = CGRectMake(0, self.cycleScrollview.bottom-41, KScreenWidth,44);
    //苹果树
    [self.scrollview addSubview:self.appleTreeBtn];
    self.appleTreeBtn.frame = CGRectMake(homespaceX,self.waveImageView.bottom+14,KScreenWidth-2*homespaceX, 113);
    //法律咨询
    [self.scrollview addSubview:self.legalAdviceBtn];
    //心理咨询
    [self.scrollview addSubview:self.psyAdviceBtn];
    //电子商务
    [self.scrollview addSubview:self.eleCommerceBtn];
  
                                 
    
    /*
    [self addNavigationItemWithTitles
     :@[@"筛选"] isLeft:NO target:self action:@selector(naviBtnClick:) tags:@[@1000]];
    
    //设置瀑布流布局
    WaterFlowLayout *layout = [WaterFlowLayout new];
    layout.columnCount = 2;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);;
    layout.rowMargin = 10;
    layout.columnMargin = 10;
    layout.delegate = self;
    

    self.collectionView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTopHeight - kTabBarHeight);
    [self.collectionView setCollectionViewLayout:layout];
    self.collectionView.backgroundColor = CViewBgColor;
    [self.collectionView registerClass:[PersonListCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([PersonListCollectionViewCell class])];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
     
     */
    
}

#pragma mark ————— 下拉刷新 —————
-(void)headerRereshing{
    [_logic loadData];
}

#pragma mark ————— 上拉刷新 —————
-(void)footerRereshing{
    _logic.page+=1;
    [_logic loadData];
}

#pragma mark ————— 数据拉取完成 渲染页面 —————
-(void)requestDataCompleted{
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView.mj_header endRefreshing];
    
//    [UIView performWithoutAnimation:^{
        [self.collectionView reloadData];
//    }];

}

#pragma mark ————— collection代理方法 —————
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _logic.dataArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PersonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PersonListCollectionViewCell class]) forIndexPath:indexPath];
    cell.personModel = _logic.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark ————— layout 代理 —————
-(CGFloat)waterFlowLayout:(WaterFlowLayout *)WaterFlowLayout heightForWidth:(CGFloat)width andIndexPath:(NSIndexPath *)indexPath{
    PersonModel *personModel = _logic.dataArray[indexPath.row];
    if (personModel.hobbys && personModel.hobbysHeight == 0) {
        //计算hobby的高度 并缓存
        CGFloat hobbyH=[personModel.hobbys heightForFont:FFont1 width:(KScreenWidth-30)/2-20];
        if (hobbyH>43) {
            hobbyH=43;
        }
        personModel.hobbysHeight = hobbyH;
    }
    CGFloat imgH = personModel.height * itemWidthHeight / personModel.width;
    
    return imgH + 110 + personModel.hobbysHeight;
    
}

//*******重写的时候需要走一句话
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //标记cell
    [self.collectionView setCurrentIndexPath:indexPath];
    
    PersonListCollectionViewCell *cell =(PersonListCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    ProfileViewController *profileVC = [ProfileViewController new];
    profileVC.headerImage = cell.imgView.image;
    profileVC.isTransition = YES;
    [self.navigationController pushViewController:profileVC animated:YES];
    
}
#pragma mark ————— 转场动画起始View —————
-(UIView *)targetTransitionView{
    NSIndexPath * indexPath = [self.collectionView currentIndexPath];
    PersonListCollectionViewCell *cell =(PersonListCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    return cell.imgView;
}

-(BOOL)isNeedTransition{
    return YES;
}
#pragma mark - TouchEvent
//MARK:点击苹果树
- (void)clickAppleTree {
    [PSTipsView showTips:HMComingsoon];
}
//MARK:点击法律咨询
-(void)clickLegalAdvice {
    PSMoreServiceViewController *PSMoreServiceVC = [[PSMoreServiceViewController alloc] initWithViewModel:[PSMoreServiceViewModel new]];
    [self.navigationController pushViewController:PSMoreServiceVC animated:YES];
}
//MARK:点击心理咨询
-(void)clickPsyAdvice {
    [PSTipsView showTips:HMComingsoon];
}
//MARK:点击电子商务
-(void)clickEleCommerce {
    [PSTipsView showTips:HMComingsoon];
}
//MARK:点击系统消息
-(void)clickSysMessage {
    [PSTipsView showTips:HMComingsoon];
}

-(void)naviBtnClick:(UIButton *)btn{
    DLog(@"点击了筛选按钮");
    [self p_insertMoreServiceVC];
}

- (void)p_insertMoreServiceVC {
    PSMoreServiceViewController *PSMoreServiceVC = [[PSMoreServiceViewController alloc] initWithViewModel:[PSMoreServiceViewModel new]];
    [self.navigationController pushViewController:PSMoreServiceVC animated:YES];

//    UploadAvatarViewController *profileVC = [UploadAvatarViewController new];
//    [self.navigationController pushViewController:profileVC animated:YES];
}

#pragma mark -  上下滑动隐藏/显示导航栏

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
//    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
//    //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
//    CGFloat velocity = [pan velocityInView:scrollView].y;
//    NSLog(@"滑动速度 %.f",velocity);
//    if (velocity <- 50) {
//        //向上拖动，隐藏导航栏
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        [UIView animateWithDuration:0.2 animations:^{
//            self.topView.bottom = 0;
//        }];
//    }else if (velocity > 50) {
//        //向下拖动，显示导航栏
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        [UIView animateWithDuration:0.2 animations:^{
//            self.topView.top = 64+10;
//        }];
//    }else if(velocity == 0){
//        //停止拖拽
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setting&&Getting
- (UIScrollView *)scrollview {
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,kStatusBarHeight,KScreenWidth,KScreenHeight-kTabBarHeight-kStatusBarHeight)];
        _scrollview.backgroundColor = CViewBgColor;
    }
    return _scrollview;
}
//轮播图
-(SDCycleScrollView *)cycleScrollview {
    if (!_cycleScrollview) {
         _cycleScrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,KScreenWidth,200) delegate:self placeholderImage:IMAGE_NAMED(@"广告图")];
//        NSArray *imagesURLStrings = @[
//                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
//        _cycleScrollview.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
//        _cycleScrollview.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
//        _cycleScrollview.imageURLStringsGroup = imagesURLStrings;
    }
    return _cycleScrollview;
}
//水波
- (UIImageView *)waveImageView {
    if (!_waveImageView) {
        _waveImageView = [UIImageView new];
        _waveImageView.image = IMAGE_NAMED(@"水波");
        _waveImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _waveImageView;
}

- (UIButton *)appleTreeBtn {
    if (!_appleTreeBtn) {
        _appleTreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_appleTreeBtn setBackgroundImage:IMAGE_NAMED(@"我家有棵苹果树") forState:UIControlStateNormal];
        @weakify(self)
        [_appleTreeBtn addTapBlock:^(UIButton *btn) {
            @strongify(self)
            [self clickAppleTree];
        }];
    }
    return _appleTreeBtn;
}
- (UIButton *)legalAdviceBtn {
    if (!_legalAdviceBtn) {
        _legalAdviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_legalAdviceBtn setBackgroundImage:IMAGE_NAMED(@"法律咨询底") forState:UIControlStateNormal];
        _legalAdviceBtn.frame = CGRectMake(homespaceX,self.appleTreeBtn.bottom+5,(KScreenWidth-homespaceX*2-6)/2, 206);
        
        UIImageView *lawImg = [UIImageView new];
        lawImg.userInteractionEnabled = YES;
        lawImg.image = IMAGE_NAMED(@"法律咨询icon");
        lawImg.frame = CGRectMake((_legalAdviceBtn.width-60)/2,45,60,60);
        [_legalAdviceBtn addSubview:lawImg];
        
        UILabel *titleLab = [UILabel new];
        titleLab.frame = CGRectMake((_legalAdviceBtn.width-100)/2,lawImg.bottom+20,100, 22);
        titleLab.text = @"法律咨询";
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = CFontColor1;
        titleLab.font = FFont1;
        [_legalAdviceBtn addSubview:titleLab];
        
        UILabel *msglab = [UILabel new];
        msglab.frame = CGRectMake((_legalAdviceBtn.width-150)/2,titleLab.bottom+6,150, 22);
        msglab.text = @"律师即时通话，物超所值";
        msglab.textAlignment = NSTextAlignmentCenter;
        msglab.textColor = CFontColor2;
        msglab.font = FFont1;
        [_legalAdviceBtn addSubview:msglab];
        
        @weakify(self)
        [_legalAdviceBtn addTapBlock:^(UIButton *btn) {
            @strongify(self)
            [self clickLegalAdvice];
        }];
    }
    return _legalAdviceBtn;
}
- (UIButton *)psyAdviceBtn {
    if (!_psyAdviceBtn) {
        _psyAdviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_psyAdviceBtn setBackgroundImage:IMAGE_NAMED(@"心理咨询底") forState:UIControlStateNormal];
        _psyAdviceBtn.frame = CGRectMake(self.legalAdviceBtn.right+6,self.legalAdviceBtn.y,self.legalAdviceBtn.width, (self.legalAdviceBtn.height-6)/2);
        
        UIImageView *psyImg = [UIImageView new];
        psyImg.userInteractionEnabled = YES;
        psyImg.image = IMAGE_NAMED(@"心理咨询icon");
        psyImg.frame = CGRectMake(17,(_psyAdviceBtn.height-36)/2,36,36);
        [_psyAdviceBtn addSubview:psyImg];
        
        UILabel *titleLab = [UILabel new];
        titleLab.frame = CGRectMake(psyImg.right+8,psyImg.y,100,18);
        titleLab.text = @"心理咨询";
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab.textColor = CFontColor1;
        titleLab.font = FFont1;
        [_psyAdviceBtn addSubview:titleLab];
        
        UILabel *msglab = [UILabel new];
        msglab.frame = CGRectMake(titleLab.x,titleLab.bottom,150,18);
        msglab.text = @"优质服务资质保证";
        msglab.textAlignment = NSTextAlignmentLeft;
        msglab.textColor = CFontColor2;
        msglab.font = FFont1;
        [_psyAdviceBtn addSubview:msglab];
        
        @weakify(self)
        [_psyAdviceBtn addTapBlock:^(UIButton *btn) {
            @strongify(self)
            [self clickPsyAdvice];
        }];
    }
    return _psyAdviceBtn;
}

- (UIButton *)eleCommerceBtn {
    if (!_eleCommerceBtn) {
        _eleCommerceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eleCommerceBtn setBackgroundImage:IMAGE_NAMED(@"心理咨询底") forState:UIControlStateNormal];
        _eleCommerceBtn.frame = CGRectMake(_legalAdviceBtn.right+6,_psyAdviceBtn.bottom+6,_legalAdviceBtn.width, (_legalAdviceBtn.height-6)/2);
        
        UIImageView *psyImg = [UIImageView new];
        psyImg.userInteractionEnabled = YES;
        psyImg.image = IMAGE_NAMED(@"电子商务icon");
        psyImg.frame = CGRectMake(17,(_eleCommerceBtn.height-36)/2,36,36);
        [_eleCommerceBtn addSubview:psyImg];
        
        UILabel *titleLab = [UILabel new];
        titleLab.frame = CGRectMake(psyImg.right+8,psyImg.y,100,18);
        titleLab.text = @"电子商务";
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab.textColor = CFontColor1;
        titleLab.font = FFont1;
        [_eleCommerceBtn addSubview:titleLab];
        
        UILabel *msglab = [UILabel new];
        msglab.frame = CGRectMake(titleLab.x,titleLab.bottom,150,18);
        msglab.text = @"一站式购物平台";
        msglab.textAlignment = NSTextAlignmentLeft;
        msglab.textColor = CFontColor2;
        msglab.font = FFont1;
        [_eleCommerceBtn addSubview:msglab];
        
        @weakify(self)
        [_eleCommerceBtn addTapBlock:^(UIButton *btn) {
            @strongify(self)
            [self clickEleCommerce];
        }];
    }
    return _eleCommerceBtn;
}

- (UIButton *)sysMsgBtn {
    if (!_sysMsgBtn) {
        _sysMsgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sysMsgBtn setBackgroundImage:IMAGE_NAMED(@"消息icon") forState:UIControlStateNormal];
        @weakify(self)
        [ _sysMsgBtn addTapBlock:^(UIButton *btn) {
             @strongify(self)
            [self clickSysMessage];
        }];
    }
    return _sysMsgBtn;
}

@end
