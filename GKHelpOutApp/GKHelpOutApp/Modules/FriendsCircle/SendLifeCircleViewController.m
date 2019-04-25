//
//  SendLifeCircleViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/4/19.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "SendLifeCircleViewController.h"
#import <TZImagePickerController.h>
#import <TZImagePickerController/TZImageManager.h>
#import "UINavigationBar+Awesome.h"
#import "imageItemView.h"
#import <Masonry.h>
#import "YBImageBrowser.h"
#define ROWCount 3 // 每一行放多少个
#define colorWithBackground   [UIColor colorWithHexString:@"#f8f8f8"]
#import "UploadManager.h"
#import "SendLifeCircleLogic.h"

typedef NS_ENUM(NSInteger, ZZFDRquestQueueVCSectionType) {
    ZZFDRquestQueueVCSectionType1 = 0,
    ZZFDRquestQueueVCSectionType2,
    ZZFDRquestQueueVCSectionType3,
    ZZFDRquestQueueVCSectionType4,
    ZZFDRquestQueueVCSectionType5,
    ZZFDRquestQueueVCSectionType6,
    ZZFDRquestQueueVCSectionType7,
    ZZFDRquestQueueVCSectionType8,
    ZZFDRquestQueueVCSectionType9,
};

@interface SendLifeCircleViewController ()<UITextViewDelegate,TZImagePickerControllerDelegate>
@property (nonatomic, copy) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextView *textViewContent;
@property (nonatomic, strong) UILabel    *labPolder;
@property (nonatomic, strong) UIButton   *btnAdd;
@property (nonatomic, strong) UIView *viewImages;
@property (nonatomic, assign) NSInteger imgCount;//标记选择了几个

@property (nonatomic, strong) NSMutableArray *dataArray;///数据数组
@property (nonatomic, strong) NSMutableArray *viewArray;///保存itemView
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) NSInteger statrIndex;////记录起始Index
@property (nonatomic, assign) CGPoint startCenter;//记录起始中心点

@property (nonatomic, strong) ZZFLEXRequestQueue *requestQueue;
@property (nonatomic, strong) NSMutableArray *loadImageDataArray;

@property (nonatomic, strong) SendLifeCircleLogic *Logic; //逻辑层

@end

@implementation SendLifeCircleViewController

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)loadImageDataArray {
    if (!_loadImageDataArray) {
        _loadImageDataArray = [NSMutableArray array];
    }
    return _loadImageDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发生活圈";
    self.requestQueue = [[ZZFLEXRequestQueue alloc] init];
    [self stepUI];
    [self addNavigationItemWithTitles:@[@"  取消"] isLeft:YES target:self action:@selector(backBtnClicked) tags:@[@100]];
    [self addNavigationItemWithTitles:@[@"发布"] isLeft:NO target:self action:@selector(releaseAction) tags:@[@200] titleColor:UIColorFromRGB(38, 76, 144)];
    _Logic = [[SendLifeCircleLogic alloc] init];

}
//发布朋友圈
-(void)releaseAction {
    
    if (self.dataArray.count<=0&&self.textViewContent.text.length<=0) {
        [PSTipsView showTips:@"请输入文字或者上传图片!"];
        return;
    }
    // 停止并清空请求队列
    if (self.requestQueue.isRuning) {
        [self.requestQueue cancelAllRequests];
    }
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = obj;
        UIImage *image = [dic valueForKey:@"content"];
        [self.requestQueue addRequestModel:[self createRequestModelWithType:idx image:image]];
    }];
    
    @weakify(self);
    [[PSLoadingView sharedInstance]show];
    [self.requestQueue runAllRequestsWithCompleteAction:^(NSArray *data, NSInteger successCount, NSInteger failureCount) {
        @strongify(self);
        [[PSLoadingView sharedInstance]dismiss];
        [self.loadImageDataArray removeAllObjects];
        self.Logic.content = self.textViewContent.text;
        for (ZZFLEXRequestModel *model in data) {
            [self.loadImageDataArray addObject:model.data];
        }
        self.Logic.circleoffriendsPicture = self.loadImageDataArray;
        
        [self.Logic postReleaseLifeCircleData:^(id data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [PSTipsView showTips:@"发布生活圈成功"];
                [self.navigationController popViewControllerAnimated:YES];
                KPostNotification(KNotificationRefreshCirCle, nil);
            });
        } failed:^(NSError *error) {
            [PSTipsView showTips:@"发布生活圈失败"];
        }];
    }];
}

#pragma mark - 发布生活圈

#pragma mark - # Private Methods
- (ZZFLEXRequestModel *)createRequestModelWithType:(ZZFDRquestQueueVCSectionType)type image:(UIImage *)image
{
    ZZFLEXRequestModel *requestModel = [ZZFLEXRequestModel requestModelWithTag:type requestAction:^(ZZFLEXRequestModel *requestModel) {
        
            [[UploadManager uploadManager]uploadConsultationImages:image completed:^(BOOL successful, NSString *tips)  {
            
                if (successful) {
                    NSDictionary*AssImageDict=@{@"fileId":tips};
                    [self->_loadImageDataArray addObject:AssImageDict];
                    //接口请求成功
                    [requestModel executeRequestCompleteMethodWithSuccess:YES data:AssImageDict];
                } else {
                    //接口请求失败
                    [requestModel executeRequestCompleteMethodWithSuccess:NO data:tips];
                }
                
            } isShowTip:NO];
        
    } requestCompleteAction:^(ZZFLEXRequestModel *requestModel) {
        //所以上传完了 刷新UI
    }];
    return  requestModel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.requestQueue cancelAllRequests];
}

- (void)stepUI{
    
    @weakify(self);
    UIView *viewTemp;
    _mainScrollView = [[UIScrollView alloc] init];
    //    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.alwaysBounceVertical = YES;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        int x = IS_IPHONEX?84:64;
        make.top.mas_equalTo(self.view).mas_offset(x);
    }];
    _contentView = [[UIView alloc]init];
    [_mainScrollView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weak_self.mainScrollView);
        make.width.equalTo(weak_self.mainScrollView);
        make.height.mas_equalTo(@(SCREEN_HEIGHT));//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    
    _textViewContent = [[UITextView alloc] init];
    _textViewContent.backgroundColor = [UIColor clearColor];
    _textViewContent.font = FontOfSize(15);
    _textViewContent.delegate = self;
    [_contentView addSubview:_textViewContent];
    [_textViewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.mas_offset(15);
        make.height.equalTo(@150);
    }];
    
    _labPolder = [[UILabel alloc] init];
    _labPolder.font = FontOfSize(15);
    _labPolder.textColor = CFontColor2;
    _labPolder.text = @"这一刻的想法...";
    [_textViewContent addSubview:_labPolder];
    [_labPolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_self.textViewContent).mas_offset(5);
        make.top.equalTo(weak_self.textViewContent).mas_offset(8);
        make.height.equalTo(@17);
    }];
    
    viewTemp = (UIView *)_textViewContent;
    
    _itemWidth = (SCREEN_WIDTH-30-5*(ROWCount+1))/ROWCount;
    //图片组view
    _viewImages = [[UIView alloc] init];
    _viewImages.backgroundColor = [UIColor clearColor];
    [_contentView addSubview:_viewImages];
    [_viewImages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.equalTo(viewTemp.mas_bottom).mas_offset(10);
        make.height.equalTo(@(weak_self.itemWidth+10));
    }];
    viewTemp = (UIView *)_viewImages;
    
    _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnAdd.backgroundColor = colorWithBackground;
//    [_btnAdd setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_btnAdd setBackgroundImage:IMAGE_NAMED(@"add") forState:UIControlStateNormal];
    [_viewImages addSubview:_btnAdd];
    [_btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-5));
        make.left.mas_offset(5);
        make.width.height.equalTo(@(weak_self.itemWidth));
    }];
    [_btnAdd addTarget:self action:@selector(choosePhoto:) forControlEvents:UIControlEventTouchUpInside];
    _imgCount = 1;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textViewContent resignFirstResponder];
}
#pragma mark - Actions
- (void)choosePhoto:(UIButton *)sender{
    
    NSInteger maxCount;
    if (_dataArray.count<9) {
        maxCount = 9- _dataArray.count;
    } else {
        [PSTipsView showTips:@"已选择9张图片!"];
        return;
    }
    [self.textViewContent resignFirstResponder];
    TZImagePickerController * imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount delegate:self];
    // 是否显示可选原图按钮
    imagePickerVc.navigationBar.tintColor = [UIColor grayColor];
    imagePickerVc.allowPickingOriginalPhoto = YES;
    // 是否允许显示视频
    imagePickerVc.allowPickingVideo = NO;
    // 是否允许显示图片
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.pickerDelegate = self;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark -TZImagePickerController
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    
}
// If user picking a video, this callback will be called.
// 如果用户选择了一个视频，下面的handle会被执行
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset{

    [[TZImageManager manager] getVideoWithAsset:asset completion:^(AVPlayerItem *playerItem, NSDictionary *info) {
        AVAsset *avasset = playerItem.asset;
        AVURLAsset *avurlSet = (AVURLAsset *)avasset;
        NSURL *fileUrl = avurlSet.URL;
        NSLog(@"%@",fileUrl);
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程中进行UI操作
            [self updateUI:@{@"cover":coverImage,@"dataURL":fileUrl}];
        });
    }];
}
// If user picking a gif image, this callback will be called.
// 如果用户选择了一个gif图片，下面的handle会被执行
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(PHAsset *)asset{
    
}
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    [self updateUI:photos];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    
}
#pragma mark 『 根据选择的图片或视频更新UI 』
- (void)updateUI:(id)obj{
    @weakify(self);
    /// 添加图片
    if([obj isKindOfClass:[NSArray class]]){
        _imgCount = self.dataArray.count;
        
        for (NSInteger i=_imgCount; i<(_imgCount+[obj count]); i++) {
            NSInteger j = i%ROWCount;//yu
            NSInteger k = i/ROWCount;//mo
            imageItemView *imageView = [[[NSBundle mainBundle] loadNibNamed:@"imageItemView" owner:nil options:nil] lastObject];
            [_viewImages addSubview:imageView];
            imageView.image = obj[i-_imgCount];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(5+j*(weak_self.itemWidth+5));
                make.top.mas_offset(5+k*(weak_self.itemWidth+5));
                make.width.height.mas_offset(weak_self.itemWidth);
            }];
            imageView.tag = i+100;
            imageView.imgBlock = ^(NSInteger index,NSInteger type) {
                [self clickImg:index type:type];
            };
            imageView.isVisible = NO;
            UIPanGestureRecognizer *longTouch = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveView:)];
            [imageView addGestureRecognizer:longTouch];
            longTouch.maximumNumberOfTouches = 1;
            longTouch.minimumNumberOfTouches = 1;
            NSDictionary *dic = @{@"content":obj[i-_imgCount],@"isHidden":@(0)};
            [self.dataArray addObject:dic];
        }
    }else{ // 添加视频
        _imgCount = self.dataArray.count;
        NSDictionary *dic = @{@"content":obj,@"isHidden":@(0)};
        [self.dataArray addObject:dic];
        NSInteger j = _imgCount%ROWCount;//yu
        NSInteger k = _imgCount/ROWCount;//mo
        NSDictionary *dataDic = dic;
        imageItemView *imageView = [[[NSBundle mainBundle] loadNibNamed:@"imageItemView" owner:nil options:nil] lastObject];
        [_viewImages addSubview:imageView];
        imageView.isVisible = NO;
        imageView.image = [dataDic objectForKey:@"cover"];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(5+j*(weak_self.itemWidth+5));
            make.top.mas_offset(5+k*(weak_self.itemWidth+5));
            make.width.height.mas_offset(weak_self.itemWidth);
        }];
        imageView.isVideo = YES;
        imageView.tag = _imgCount+100;
        imageView.imgBlock = ^(NSInteger index ,NSInteger type) {
            
            [self clickImg:index type:type];
        };
        UIPanGestureRecognizer *longTouch = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveView:)];
        longTouch.maximumNumberOfTouches = 1;
        longTouch.minimumNumberOfTouches = 1;
        [imageView addGestureRecognizer:longTouch];
    }
    [self adjustUI];
}
- (void)adjustUI{
    @weakify(self);
    /// 改变整体内容大小
    NSInteger ROW = self.dataArray.count/ROWCount+1;//还有个加号
    NSInteger column = self.dataArray.count%ROWCount;
    CGFloat height = 5+ROW*(_itemWidth+5);
    [_viewImages mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
    [_btnAdd mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5+column*(weak_self.itemWidth+5));
    }];
    height+=200;
    height = height>SCREEN_HEIGHT?height:SCREEN_HEIGHT;
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(height));
    }];
    
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void)moveView:(UIPanGestureRecognizer *)pan{
    if(self.dataArray.count<2){
        return;
    }
    
    UIView *tempView = pan.view;
    CGPoint newCenter;
    [_viewImages bringSubviewToFront:tempView];
    
    if(pan.state == UIGestureRecognizerStateBegan){
        self.statrIndex = tempView.tag;
        self.startCenter = tempView.center;
        
        /// 解决同时拖动多个itme问题
        for (UIView *views in _viewImages.subviews) {
            if(views !=tempView){
                views.userInteractionEnabled = NO;
            }
            
        }
        
        
    }else if (pan.state == UIGestureRecognizerStateChanged)
    {
        //偏移量
        CGPoint point = [pan translationInView:_viewImages];
        //改变中心点坐标
        newCenter = CGPointMake(tempView.center.x + point.x, tempView.center.y + point.y);
        //限制拖动范围
        newCenter.y = MAX(tempView.frame.size.height/2, newCenter.y);
        newCenter.y = MIN(_viewImages.frame.size.height - tempView.frame.size.height/2,newCenter.y);
        newCenter.x = MAX(tempView.frame.size.width/2, newCenter.x);
        newCenter.x = MIN(_viewImages.frame.size.width - tempView.frame.size.width/2, newCenter.x);
        tempView.center = newCenter;
        //重置手势的偏移量
        [pan setTranslation:CGPointZero inView:_viewImages];
    }else if(pan.state == UIGestureRecognizerStateEnded||pan.state == UIGestureRecognizerStateCancelled){
        [self optionView:tempView];
        /// 解决同时拖动多个itme问题
        for (UIView *views in _viewImages.subviews) {
            views.userInteractionEnabled = YES;
        }
    }
}
- (void)optionView:(UIView *)tempView{
    @weakify(self);
    //计算最后中心位置 属于那个区域 然后交换位置
    CGFloat x = tempView.center.x;
    CGFloat y = tempView.center.y;
    // 计算
    NSInteger j =  (x-5)/(_itemWidth+5) ;
    NSInteger k  = (y-5)/(_itemWidth+5) ;
    NSInteger index = ROWCount*k+j;
    if((self.statrIndex-100 == index)||index>=self.dataArray.count){
        /// 这里不能删除 。。。。删除了会出现问题
        [UIView animateWithDuration:0.3 animations:^{
            tempView.center =  self.startCenter;
        }];
    }
    else{
        UIView *tempView2 = [_viewImages viewWithTag:index+100];
        /// 视觉效果
        [_viewImages bringSubviewToFront:tempView2];
        [_viewImages bringSubviewToFront:tempView];
        [self.dataArray exchangeObjectAtIndex:index withObjectAtIndex:self.statrIndex-100];
        [tempView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(5+j*(weak_self.itemWidth+5));
            make.top.mas_offset(5+k*(weak_self.itemWidth+5));
            
        }];
        NSInteger j1  = (self.statrIndex-100)%ROWCount;
        NSInteger k1  = (self.statrIndex-100)/ROWCount;
        [tempView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(5+j1*(weak_self.itemWidth+5));
            make.top.mas_offset(5+k1*(weak_self.itemWidth+5));
        }];
        tempView2.tag = self.statrIndex;
        tempView.tag = index+100;
        
        // 告诉self.view约束需要更新
        [self.view setNeedsUpdateConstraints];
        // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
        [self.view updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}
#pragma mark 『 点击某个图片回调 』
- (void)clickImg:(NSInteger)index type:(NSInteger)type{
    @weakify(self);
    NSInteger tagIndex = index - 100;
    id obj1 = self.dataArray[tagIndex];
    id content = [obj1 objectForKey:@"content"];
    if(type == 3)
    {
        BOOL isHidden = [[obj1 objectForKey:@"isHidden"] boolValue];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:obj1];
        [tempDic setObject:@(!isHidden) forKey:@"isHidden"];
        [self.dataArray replaceObjectAtIndex:tagIndex withObject:tempDic];
    }
    else if(type == 1)
    {
        if([content isKindOfClass:[UIImage class]]){
            NSLog(@"点击图片");
        }else{
            NSLog(@"点击视频");
        }
        
        [self showBrowserForMixedCaseWithIndex:tagIndex];
        
    }else{
        
        NSLog(@"删除啊");
        /// 执行删除操作
        [self.dataArray removeObject:obj1];
        UIView *delView = [_viewImages viewWithTag:index];
        [delView removeFromSuperview];
        for (NSInteger i = tagIndex;i<self.dataArray.count;i++){
            
            UIView *tempView = [_viewImages viewWithTag:i+101];
            if(tempView){
                tempView.tag = i+100;
                NSInteger j = i%ROWCount;//yu
                NSInteger k = i/ROWCount;//mo
                [tempView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(5+j*(weak_self.itemWidth+5));
                    make.top.mas_offset(5+k*(weak_self.itemWidth+5));
                }];
                
            }
        }
        [self adjustUI];
    }
}
#pragma mark 『展示』
- (void)showBrowserForMixedCaseWithIndex:(NSInteger)index {
    @weakify(self);
    NSMutableArray *browserDataArr = [NSMutableArray array];
    [self.dataArray enumerateObjectsUsingBlock:^(id obj1, NSUInteger idx, BOOL * _Nonnull stop) {
        id content = [obj1 objectForKey:@"content"];
        
        if([content isKindOfClass:[UIImage class]]){
            YBImageBrowseCellData *dataModel = [YBImageBrowseCellData new];
            dataModel.imageBlock = ^YBImage *{
                return content;
            } ;
            dataModel.sourceObject = [(imageItemView *)[weak_self.viewImages viewWithTag:index+100] contentView];
            [browserDataArr addObject:dataModel];
        }else{
            // Type 2 : 本地视频 / Local video
            YBVideoBrowseCellData *dataModel = [YBVideoBrowseCellData new];
            dataModel.url = [content objectForKey:@"dataURL"];
            dataModel.sourceObject = [(imageItemView *)[weak_self.viewImages viewWithTag:index+100] contentView];
            [browserDataArr addObject:dataModel];
        }
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = index;
    [browser.defaultToolBar hideOperationButton];
    [browser show];
}

#pragma mark - textViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length) {
        self.labPolder.hidden = YES;
    }
    else{
        self.labPolder.hidden = NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
