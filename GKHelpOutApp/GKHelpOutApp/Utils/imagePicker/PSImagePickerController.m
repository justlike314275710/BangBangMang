//
//  STImagePickerController.m
//  Components
//
//  Created by calvin on 16/6/9.
//  Copyright © 2016年 calvin. All rights reserved.
//

#import "PSImagePickerController.h"
#import "PSIntercepter.h"
#import "UIImage+Crop.h"

#define DEFAULT_CROP_SIZE (CGSize){200,200}
#define MIN_ZOOM_SCALE 1.0
#define MAX_ZOOM_SCALE 3.0

@class PSCropViewController;

typedef void(^CropedImageCallBack)(UIImage *cropImage,PSCropViewController *viewController);

@interface PSCropViewController : UIViewController

@property (assign, nonatomic) CGSize cropSize;

- (instancetype)initWithOriginalImage:(UIImage *)originalImage callBack:(CropedImageCallBack)callBack;

@end

@interface PSCropViewController () <UIScrollViewDelegate>

@property (nonatomic, copy) CropedImageCallBack cropCallback;
@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIImageView *originalImageView;
@property (nonatomic, strong) UIView *cropView;
@property (nonatomic, strong) UIView *coverView;

@end

@implementation PSCropViewController

- (instancetype)initWithOriginalImage:(UIImage *)originalImage callBack:(CropedImageCallBack)callBack {
    NSAssert(originalImage, @"STCropViewController：传入的图片为空");
    self = [super init];
    if (self) {
        self.title = @"移动和缩放";
        self.cropCallback = callBack;
        self.originalImage = originalImage;
        self.cropSize = DEFAULT_CROP_SIZE;
    }
    return self;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([UIDevice currentDevice].systemVersion.floatValue < 11)
    {
        return;
    }
}

- (void)dealloc {
    _contentScrollView.delegate = nil;
}

- (CGRect)resizedFrameForAutorotatingImageView:(CGSize)imageSize {
    CGRect frame = self.view.bounds;
    CGFloat screenWidth = frame.size.width * self.contentScrollView.zoomScale;
    CGFloat screenHeight = frame.size.height * self.contentScrollView.zoomScale;
    CGFloat targetWidth = screenWidth;
    CGFloat targetHeight = screenHeight;
    CGFloat nativeHeight = screenHeight;
    CGFloat nativeWidth = screenWidth;
    if (imageSize.width > 0 && imageSize.height > 0) {
        nativeHeight = (imageSize.height > 0) ? imageSize.height : screenHeight;
        nativeWidth = (imageSize.width > 0) ? imageSize.width : screenWidth;
    }
    if (nativeHeight > nativeWidth) {
        if (screenHeight/screenWidth < nativeHeight/nativeWidth) {
            targetWidth = screenHeight / (nativeHeight / nativeWidth);
        } else {
            targetHeight = screenWidth / (nativeWidth / nativeHeight);
        }
    } else {
        if (screenWidth/screenHeight < nativeWidth/nativeHeight) {
            targetHeight = screenWidth / (nativeWidth / nativeHeight);
        } else {
            targetWidth = screenHeight / (nativeHeight / nativeWidth);
        }
    }
    frame.size = CGSizeMake(targetWidth, targetHeight);
    frame.origin = CGPointMake(0, 0);
    return frame;
}

- (UIEdgeInsets)contentInsetForScrollView:(CGFloat)targetZoomScale {
    UIEdgeInsets inset = UIEdgeInsetsZero;
    CGFloat boundsHeight = self.contentScrollView.bounds.size.height;
    CGFloat boundsWidth = self.contentScrollView.bounds.size.width;
    CGFloat contentHeight = (self.originalImage.size.height > 0) ? self.originalImage.size.height : boundsHeight;
    CGFloat contentWidth = (self.originalImage.size.width > 0) ? self.originalImage.size.width : boundsWidth;
    CGFloat minContentHeight;
    CGFloat minContentWidth;
    if (contentHeight > contentWidth) {
        if (boundsHeight/boundsWidth < contentHeight/contentWidth) {
            minContentHeight = boundsHeight;
            minContentWidth = contentWidth * (minContentHeight / contentHeight);
        } else {
            minContentWidth = boundsWidth;
            minContentHeight = contentHeight * (minContentWidth / contentWidth);
        }
    } else {
        if (boundsWidth/boundsHeight < contentWidth/contentHeight) {
            minContentWidth = boundsWidth;
            minContentHeight = contentHeight * (minContentWidth / contentWidth);
        } else {
            minContentHeight = boundsHeight;
            minContentWidth = contentWidth * (minContentHeight / contentHeight);
        }
    }
    CGFloat myHeight = self.view.bounds.size.height;
    CGFloat myWidth = self.view.bounds.size.width;
    minContentWidth *= targetZoomScale;
    minContentHeight *= targetZoomScale;
    if (minContentHeight > myHeight && minContentWidth > myWidth) {
        CGFloat verticalDiff = myHeight - self.cropSize.height;
        inset.top = verticalDiff / 2.0;
        inset.bottom = verticalDiff / 2.0;
    } else {
        CGFloat verticalDiff = boundsHeight - minContentHeight;
        CGFloat heightPadding = boundsHeight - self.cropSize.height;
        if (verticalDiff < heightPadding) {
            verticalDiff = heightPadding;
        }
        CGFloat horizontalDiff = boundsWidth - minContentWidth;
        verticalDiff = (verticalDiff > 0) ? verticalDiff : 0;
        horizontalDiff = (horizontalDiff > 0) ? horizontalDiff : 0;
        inset.top = verticalDiff/2.0f;
        inset.bottom = verticalDiff/2.0f;
        inset.left = horizontalDiff/2.0f;
        inset.right = horizontalDiff/2.0f;
    }
    return inset;
}

//生成圆形图片
- (UIImage *)roundImageWithImage:(UIImage *)image {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

- (IBAction)backgroundTapped:(id)sender {
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
}

- (IBAction)backAction {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//生成图片
- (IBAction)comfirm:(id)sender {
    self.coverView.hidden = YES;
    //计算图片裁剪区域的绝对位置
    CGPoint point = CGPointMake(_contentScrollView.contentOffset.x + (SCREEN_WIDTH - _cropSize.width)/2, _contentScrollView.contentOffset.y + (SCREEN_HEIGHT - _cropSize.height)/2);
    CGRect imageRect = CGRectMake(point.x * (self.originalImage.size.width / _originalImageView.frame.size.width), point.y * (self.originalImage.size.height / _originalImageView.frame.size.height), _cropSize.width * (self.originalImage.size.width / _originalImageView.frame.size.width), _cropSize.height * (self.originalImage.size.height / _originalImageView.frame.size.height));
    UIImage *cropImage = [UIImage getImageFromImage:[UIImage fixOrientation:self.originalImage] subImageRect:imageRect];
    
    if (self.cropCallback) {
        self.cropCallback(cropImage,self);
    }
}

//创建滤镜
- (void)addFilterInView:(UIView *)view inRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.frame cornerRadius:0];
    /*圆形滤镜
    CGFloat radius = rect.size.width / 2.0;
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
     */
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRect:rect];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule =kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor blackColor].CGColor;
    fillLayer.strokeColor = [UIColor whiteColor].CGColor;
    fillLayer.opacity = 0.5;
    [view.layer addSublayer:fillLayer];
}

- (void)viewDidLayoutSubviews {
    self.originalImageView.frame = [self resizedFrameForAutorotatingImageView:self.originalImage.size];
    self.contentScrollView.contentSize = self.originalImageView.frame.size;
    self.contentScrollView.contentInset = [self contentInsetForScrollView:self.contentScrollView.zoomScale];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.contentScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentScrollView.delegate = self;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.contentMode = UIViewContentModeCenter;
    self.contentScrollView.maximumZoomScale = MAX_ZOOM_SCALE;
    [self.view addSubview:self.contentScrollView];
    self.originalImageView = [[UIImageView alloc] initWithImage:self.originalImage];
    self.originalImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentScrollView addSubview:self.originalImageView];
    



    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 60, 44);
    backButton.backgroundColor = [UIColor redColor];
    backButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    

   
    
    
    
    UIButton *comfirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [comfirmButton addTarget:self action:@selector(comfirm:) forControlEvents:UIControlEventTouchUpInside];
    comfirmButton.frame = CGRectMake(0, 0, 60, 44);
    comfirmButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [comfirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [comfirmButton setTitle:@"确定" forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:comfirmButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    self.cropView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.cropSize.width, self.cropSize.height)];
    self.cropView.center = self.view.center;
    self.cropView.backgroundColor = [UIColor clearColor];
    self.cropView.userInteractionEnabled = NO;
    [self.view addSubview:self.cropView];
    
    self.coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.coverView.userInteractionEnabled = NO;
    self.coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addFilterInView:self.coverView inRect:self.cropView.frame];
    [self.view addSubview:self.coverView];
}

#pragma mark - 
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.originalImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    self.contentScrollView.contentInset = [self contentInsetForScrollView:scrollView.zoomScale];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    self.contentScrollView.contentInset = [self contentInsetForScrollView:scale];
}

@end

@interface PSImagePickerController ()

@property (nonatomic, strong) PSIntercepter *intercepter;
@property (nonatomic, copy) CropHeaderImageCallback cropCallback;

@end

@implementation PSImagePickerController

- (id)initWithCropHeaderImageCallback:(CropHeaderImageCallback)callback {
    self = [super init];
    if (self) {
        self.intercepter = [[PSIntercepter alloc] init];
        self.cropCallback = callback;
        CGFloat length = MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        self.cropSize = CGSizeMake(length - 2.0, length - 2.0);
        self.edgesForExtendedLayout = UIRectEdgeNone;// 推荐使用
   
    }
    return self;
}


- (void)setDelegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)delegate {
    if (delegate) {
        _intercepter.middleMan = self;
        _intercepter.receiver = delegate;
        super.delegate = (id)_intercepter;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if ([_intercepter.receiver
         respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)]) {
        [_intercepter.receiver imagePickerController:picker didFinishPickingMediaWithInfo:info];
    }
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    __weak PSImagePickerController *weakself = self;
    if (originalImage) {
        PSCropViewController *cropViewController = [[PSCropViewController alloc] initWithOriginalImage:originalImage callBack:^(UIImage *cropImage, PSCropViewController *viewController) {
            if (weakself.cropCallback) {
                weakself.cropCallback(cropImage);
            }
            [picker dismissViewControllerAnimated:NO completion:nil];
        }];
        cropViewController.cropSize = weakself.cropSize;
        [picker pushViewController:cropViewController animated:YES];
        [picker setNavigationBarHidden:NO animated:NO];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    if ([_intercepter.receiver
//         respondsToSelector:@selector(imagePickerControllerDidCancel)]) {
//        [_intercepter.receiver imagePickerControllerDidCancel:picker];
//    }
    [self imagePickerControllerDidCancel];
}

-(void)imagePickerControllerDidCancel{
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
