//
//  STViewController.m
//  BuBuGao
//
//  Created by calvin on 14-4-2.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//
#define UIColorFromHexadecimalRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define AppBaseTextColor1 (UIColorFromHexadecimalRGB(0x666666))//灰色
#define FontOfSize(size) [UIFont systemFontOfSize:size]

#import "PSViewController.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
#import "PSTipsView.h"
//#import "UIImage+Color.h"
#import "PSAlertView.h"

#define TITLEFONT 17 //导航栏标题文字大小
#define DEFAULT_ITEM_SIZE CGSizeMake(40,44)

@interface PSViewController ()

@end

@implementation PSViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.hidesBottomBarWhenPushed = YES;
        self.orientationMask = UIInterfaceOrientationMaskPortrait;

    }
    return self;
}

- (void)dealloc {
    //PSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

//返回
- (IBAction)actionOfLeftItem:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImage *)navgationBarImage {
    return [UIImage imageWithColor:[UIColor whiteColor] size:self.navigationController.navigationBar.frame.size];
}

- (UIImage *)leftItemImage {
    return nil;
}

- (UIColor *)titleColor {
    return AppBaseTextColor1;
}

- (UIColor *)rightItemTitleColor {
    return AppBaseTextColor1;
}

- (void)createRightBarButtonItemWithTarget:(id)target action:(SEL)action normalImage:(UIImage *)nImage highlightedImage:(UIImage *)hImage {
    UIButton *rButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rButton.exclusiveTouch = YES;
    CGSize defaultSize = CGSizeMake(40, 44);
    if (nImage.size.width > defaultSize.width) {
        defaultSize.width = nImage.size.width;
    }
    if (hImage.size.width > defaultSize.width) {
        defaultSize.width = hImage.size.width;
    }
    rButton.frame = CGRectMake(0, 0, defaultSize.width, defaultSize.height);
    rButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rButton setImage:nImage forState:UIControlStateNormal];
    [rButton setImage:hImage forState:UIControlStateHighlighted];
    [rButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rButton];
    self.navigationItem.rightBarButtonItem =  rightItem;
}

- (void)createRightBarButtonItemWithTarget:(id)target action:(SEL)action title:(NSString *)title {
    UIFont *font = FontOfSize(15);
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 44.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    titleSize.width = titleSize.width < DEFAULT_ITEM_SIZE.width ? DEFAULT_ITEM_SIZE.width : titleSize.width + 10;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, titleSize.width, titleSize.height);
    button.titleLabel.font = font;
    [button setTitleColor:[self rightItemTitleColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    //偏移量调整
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    flexSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[flexSpacer,rightItem];
}

- (void)showNetError {
    NSString*NetError=NSLocalizedString(@"NetError", @"服务器异常");
    [PSTipsView showTips:NetError];
}
- (void)showInternetError {
   // [PSTipsView showTips:@"无法连接到服务器，请检查网络"];
    NSString*Tips=@"提示";
   // NSLocalizedString(@"Tips", @"提示");
    NSString*InternetError=@"无法连接到服务器，请检查网络";
    //NSLocalizedString(@"InternetError", @"无法连接到服务器，请检查网络");
    NSString*determine=@"确定";
    //NSLocalizedString(@"determine", @"确定");
    [PSAlertView showWithTitle:Tips message:InternetError messageAlignment:NSTextAlignmentCenter image:nil handler:^(PSAlertView *alertView, NSInteger buttonIndex) {
        
    } buttonTitles:determine, nil];
}

#pragma mark - 更换屏幕方向
- (void)changeOrientation:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationLandscapeRight) {
        UIInterfaceOrientationMask targetMask = orientation == UIInterfaceOrientationPortrait ? UIInterfaceOrientationMaskPortrait : UIInterfaceOrientationMaskLandscapeRight;
        if (_orientationMask != targetMask) {
            _orientationMask = targetMask;
            [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationUnknown) forKey:@"orientation"];
            [[UIDevice currentDevice] setValue:@(orientation) forKey:@"orientation"];
        }
    }
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    UIViewController *presentingViewController = self.presentingViewController;
    UIInterfaceOrientation presentingOrientation = presentingViewController.preferredInterfaceOrientationForPresentation;
    _orientationMask = presentingOrientation == UIInterfaceOrientationPortrait ? UIInterfaceOrientationMaskPortrait : UIInterfaceOrientationMaskLandscapeRight;
    [super dismissViewControllerAnimated:flag completion:completion];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self navgationBarImage]) {
        [self.navigationController.navigationBar setBackgroundImage:[self navgationBarImage] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:TITLEFONT],NSForegroundColorAttributeName:[self titleColor]};
    UIButton *lButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect leftFrame = CGRectMake(0, 0, DEFAULT_ITEM_SIZE.width, DEFAULT_ITEM_SIZE.height);
    UIImage *leftImage = [self leftItemImage];
    if (CGRectGetWidth(leftFrame) < leftImage.size.width) {
        leftFrame.size.width = leftImage.size.width;
    }
    if (CGRectGetHeight(leftFrame) < leftImage.size.height) {
        leftFrame.size.height = leftImage.size.height;
    }
    [lButton setImage:leftImage forState:UIControlStateNormal];
    lButton.frame = leftFrame;
    lButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [lButton addTarget:self action:@selector(actionOfLeftItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:lButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (BOOL)hiddenNavigationBar {
    return NO;
}

- (BOOL)fd_prefersNavigationBarHidden {
    return [self hiddenNavigationBar];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return _orientationMask != UIInterfaceOrientationMaskPortrait;
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return _orientationMask;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
