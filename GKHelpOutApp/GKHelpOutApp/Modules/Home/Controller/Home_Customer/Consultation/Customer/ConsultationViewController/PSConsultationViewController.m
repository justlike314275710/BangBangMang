//
//  PSConsultationViewController.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/10/29.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSConsultationViewController.h"
#import "PSServiceLinkView.h"
#import "PSConsultationTableViewCell.h"
#import "PSConsultationOtherTableViewCell.h"
#import "PSConsultationViewModel.h"
#import "Mine_CategoryViewController.h"
#import "PSConsultationViewModel.h"
#import <AFNetworking/AFNetworking.h>
#import "PSPayView.h"
#import "PSPhoneCardViewModel.h"
#import "MJExtension.h"
#import "PSConsultation.h"
#import "PSPayCenter.h"
#import "PSPayInfo.h"
#import "PSAdviceDetailsViewController.h"
#import "PSMyAdviceViewController.h"
#import "PSConsultationViewModel.h"
#import "PSMoreServiceViewController.h"
#import "MyConsultationViewController.h"


@interface PSConsultationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UICollectionView *serviceCollectionView;
@property (nonatomic , strong) NSMutableArray *selectArray;
@property (nonatomic , strong) NSMutableArray *images;
@property (nonatomic, strong) PSPayView *payView;
@property (nonatomic , assign) NSInteger index;

@end

@implementation PSConsultationViewController

#pragma mark  - life cycle
- (instancetype)initWithViewModel:(PSViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        self.title = @"我要咨询";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderContents];
    _images=[[NSMutableArray alloc]init];
    self.isShowLiftBack = YES;
    // Do any additional setup after loading the view.
}


#pragma mark  - action
- (void)handlePickerImage:(UIImage *)image {
    @weakify(self)
    PSConsultationViewModel *viewModel=(PSConsultationViewModel *)self.viewModel;
    viewModel.consultaionImage=image;
    [viewModel uploadConsultationImagesCompleted:^(BOOL successful, NSString *tips) {
        @strongify(self)
        if (successful) {
            NSString*base64=[self image2DataURL:image];
            NSDictionary*dict=@{@"fileId":tips,
                                @"thumb":base64
                                };
            [self.images addObject:dict];
            viewModel.attachments=self.images;
        }
    }];
    
}

-(void)checkDataIsEmpty{
    PSConsultationViewModel *viewModel=(PSConsultationViewModel *)self.viewModel;
    @weakify(self)
    //viewModel.categories=self.selectArray;
    [viewModel checkDataWithCallback:^(BOOL successful, NSString *tips) {
        @strongify(self)
        if (successful) {
            [self Submit_LegalAdvice];
        } else {
            [PSTipsView showTips:tips];
        }
    }];
}
#pragma mark -- 提交订单
-(void)Submit_LegalAdvice{
    PSConsultationViewModel *viewModel=(PSConsultationViewModel *)self.viewModel;
    //@weakify(self)
    [viewModel requestAddConsultationCompleted:^(PSResponse *response) {
        PSConsultation*model=[PSConsultation mj_objectWithKeyValues:response];
        [self buyCardAction:model.cid withReward:model.reward];
    } failed:^(NSError *error) {
        [self showInternetError];
    }];
}


- (void)buyCardAction:(NSString*)cid withReward:(NSString*)reward{
    PSPhoneCardViewModel*viewModel=[[PSPhoneCardViewModel alloc]init];
    PSPayView *payView = [PSPayView new];
    payView.payType = @"law";
    [payView setGetAmount:^CGFloat{
        return [reward floatValue];
    }];
    [payView setGetRows:^NSInteger{
        return viewModel.payments.count;
    }];
    [payView setGetSelectedIndex:^NSInteger{
        return viewModel.selectedPaymentIndex;
    }];
    [payView setGetIcon:^UIImage *(NSInteger index) {
        PSPayment *payment = viewModel.payments.count > index ? viewModel.payments[index] : nil;
        return payment ? [UIImage imageNamed:payment.iconName] : nil;
    }];
    [payView setGetName:^NSString *(NSInteger index) {
        PSPayment *payment = viewModel.payments.count > index ? viewModel.payments[index] : nil;
        return payment ? payment.name : nil;
    }];
    [payView setSeletedPayment:^(NSInteger index) {
        self.index=index;
        viewModel.selectedPaymentIndex = index;
    }];
    
    [payView setGoHomeAction:^{
        __block BOOL isBack = NO;
        [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[PSMoreServiceViewController class]]) {
                [self.navigationController popToViewController:obj animated:YES];
                *stop = YES;
                isBack= YES;
            }
        }];
        if (!isBack) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pushAction" object:nil];
        }
        
    }];
    
    [payView setGoZxActcion:^{
//        [self.navigationController pushViewController:[[PSMyAdviceViewController alloc] initWithViewModel:[[PSConsultationViewModel alloc] init]] animated:YES];
        [self.navigationController pushViewController:[[MyConsultationViewController alloc]init] animated:YES];
    }];
    
    @weakify(self)
    [payView setGoPay:^{
        @strongify(self)
        [self goPay:cid];
        
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [payView showAnimated:YES];
    });
    
    _payView = payView;
}

-(void)goPay:(NSString*)cid{
    PSPhoneCardViewModel*viewModel=[[PSPhoneCardViewModel alloc]init];
    PSPayInfo*payinfo=[PSPayInfo new];
    PSPayment *paymentInfo = viewModel.payments[_index];
    payinfo.productID=cid;
    payinfo.payment=paymentInfo.payment;
    [[PSLoadingView sharedInstance] show];
    @weakify(self)
    [[PSPayCenter payCenter] goPayWithPayInfo:payinfo type:PayTypeOrd callback:^(BOOL result, NSError *error) {
        @strongify(self)
        [[PSLoadingView sharedInstance] dismiss];
        if (error) {
            if (error.code != 106 && error.code != 206) {
                [PSTipsView showTips:error.domain];
            }
        }else{
            self.payView.status = PSPaySuccessful;
            PSConsultationViewModel *viewModel =(PSConsultationViewModel *)self.viewModel;
            viewModel.adviceId=cid;
            [self.navigationController pushViewController:[[PSAdviceDetailsViewController alloc]initWithViewModel:viewModel] animated:YES];
        }
    }];
    
}

#pragma mark  - UITableViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSIze = CGSizeZero;
    if (indexPath.section == 0) {
        itemSIze = CGSizeMake(SCREEN_WIDTH, 66);
    }else{
        itemSIze = CGSizeMake(SCREEN_WIDTH, 160);
    }
    return itemSIze;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize sectionSize = CGSizeZero;
    if (section != 0) {
        sectionSize = CGSizeMake(SCREEN_WIDTH, 5);
    }
    return sectionSize;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *header = nil;
    if (indexPath.section != 0) {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"PSServiceLinkView" forIndexPath:indexPath];
    }
    return header;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PSConsultationTableViewCell" forIndexPath:indexPath];
        //咨询类型选择
        PSConsultationViewModel *viewModel=(PSConsultationViewModel *)self.viewModel;
        [((PSConsultationTableViewCell *)cell).choseButton setTitle:viewModel.category forState:0];
        [self bulidSelectNSSting:viewModel.category];
        
        
//        //相册相机回调
//        [((PSConsultationTableViewCell *)cell).pickerV observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
//            for (int i=0; i<list.count; i++) {
//                if (i==list.count-1) {
//                    LLImagePickerModel*model=[list objectAtIndex:i];
//                    [self handlePickerImage:model.image];
//                }
//            }
//        }];
        
        ((PSConsultationTableViewCell *)cell).contentTextView.delegate=self;
        
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PSConsultationOtherTableViewCell" forIndexPath:indexPath];
        ((PSConsultationOtherTableViewCell*)cell).moneyTextField.delegate=self;
        [((PSConsultationOtherTableViewCell*)cell).moneyTextField setBk_didEndEditingBlock:^(UITextField *TextField) {
            PSConsultationViewModel *viewModel=(PSConsultationViewModel *)self.viewModel;
            viewModel.reward=TextField.text;
            //[TextField.text floatValue];
            
        }];
        @weakify(self)
        [self updateProtocolText:((PSConsultationOtherTableViewCell*)cell)];
        [((PSConsultationOtherTableViewCell*)cell).protocolLabel setTextTapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            @strongify(self)
            NSString*usageProtocol=NSLocalizedString(@"usageProtocol", nil);
            NSString *tapString = [text plainTextForRange:range];
            NSString *protocolString = usageProtocol;
            if (tapString) {
                if ([protocolString containsString:tapString]) {
                    [self openProtocol];
                }else{
                    [self updateProtocolStatus:((PSConsultationOtherTableViewCell*)cell)];
                }
            }
        }];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        
    }else if (indexPath.section == 2) {
        //[self honorOfYear];
    }
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    PSConsultationViewModel *viewModel=(PSConsultationViewModel *)self.viewModel;
    viewModel.describe = textView.text;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //    限制只能输入数字
    BOOL isHaveDian = YES;
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    if ([string length] > 0) {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            
            if([textField.text length] == 0){
                if(single == '.') {
                    NSString *tip = @"数据格式有误";
                    [PSTipsView showTips:tip];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian = YES;
                    return YES;
                    
                }else{
                    NSString *tip = @"数据格式有误";
                    [PSTipsView showTips:tip];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (isHaveDian) {//存在小数点
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= 2) {
                        return YES;
                    }else{
                        NSString *tip = @"最多两个小数";
                        [PSTipsView showTips:tip];
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
        }else{
            NSString *tip = @"数据格式有误";
            [PSTipsView showTips:tip];
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
}



#pragma mark  - UI
-(void)renderContents{
    self.view.backgroundColor = AppBaseBackgroundColor2;
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    self.serviceCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    self.serviceCollectionView.backgroundColor = [UIColor clearColor];
    self.serviceCollectionView.dataSource = self;
    self.serviceCollectionView.delegate = self;
    [self.serviceCollectionView registerClass:[PSConsultationTableViewCell class] forCellWithReuseIdentifier:@"PSConsultationTableViewCell"];
    [self.serviceCollectionView registerClass:[PSConsultationOtherTableViewCell class] forCellWithReuseIdentifier:@"PSConsultationOtherTableViewCell"];
    [self.serviceCollectionView registerClass:[PSServiceLinkView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PSServiceLinkView"];
    [self.view addSubview:self.serviceCollectionView];
    [self.serviceCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.serviceCollectionView.alwaysBounceVertical=YES;
    
    
    UIButton*releaseButton=[[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT-125, SCREEN_WIDTH-30, 44)];
    [releaseButton setBackgroundImage:[UIImage imageNamed:@"提交按钮底框"] forState:0];
    [releaseButton setTitle:@"发布抢单" forState:0];
    releaseButton.titleLabel.font=AppBaseTextFont3;
    [self.serviceCollectionView addSubview:releaseButton];
    
    [releaseButton bk_whenTapped:^{
        [self checkDataIsEmpty];
        //[self buyCardAction];
    }];
    
}
#pragma mark  - setter & getter
-(void)bulidSelectNSSting:(NSString*)cateory{
    PSConsultationViewModel *viewModel=(PSConsultationViewModel *)self.viewModel;
    if ([cateory isEqualToString:@"财产纠纷"]) {
        viewModel.category=@"PROPERTY_DISPUTES";
    }
    else if ([cateory isEqualToString:@"婚姻家庭"]){
        viewModel.category=@"MARRIAGE_FAMILY";
    }
    else if ([cateory isEqualToString:@"交通事故"]){
        viewModel.category=@"TRAFFIC_ACCIDENT";
    }
    else if ([cateory isEqualToString:@"工伤赔偿"]){
        viewModel.category=@"WORK_COMPENSATION";
    }
    else if ([cateory isEqualToString:@"合同纠纷"]){
        viewModel.category=@"CONTRACT_DISPUTE";
    }
    else if ([cateory isEqualToString:@"刑事辩护"]){
        viewModel.category=@"CRIMINAL_DEFENSE";
    }
    else if ([cateory isEqualToString:@"房产纠纷"]){
        viewModel.category=@"HOUSING_DISPUTES";
    }
    else if ([cateory isEqualToString:@"劳动就业"]){
        viewModel.category=@"LABOR_EMPLOYMENT";
    }
    else{
        
    }
    
}



#pragma mark -- toolsMethod
- (NSString *) image2DataURL: (UIImage *) image
{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    if ([self imageHasAlpha: image]) {
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(image, 0.3f);
        
        mimeType = @"image/jpeg";
    }
    
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions: 0]];
    
}

- (BOOL) imageHasAlpha: (UIImage *) image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 注册协议
- (void)openProtocol {
    
}



- (void)updateProtocolStatus :(PSConsultationOtherTableViewCell*)cell{
    PSConsultationViewModel *viewModel=(PSConsultationViewModel *)self.viewModel;
    viewModel.agreeProtocol = !viewModel.agreeProtocol;
    [self updateProtocolText:cell];
}

- (void)updateProtocolText:(PSConsultationOtherTableViewCell*)cell {
    //    NSString*read_agree=NSLocalizedString(@"read_agree", nil);
    NSString*usageProtocol=@"  法律咨询协议";
    NSMutableAttributedString *protocolText = [NSMutableAttributedString new];
    UIFont *textFont = FontOfSize(12);
    //    [protocolText appendAttributedString:[[NSAttributedString alloc] initWithString:read_agree attributes:@{NSFontAttributeName:textFont,NSForegroundColorAttributeName:AppBaseTextColor2}]];
    [protocolText appendAttributedString:[[NSAttributedString  alloc] initWithString: usageProtocol attributes:@{NSFontAttributeName:textFont,NSForegroundColorAttributeName:UIColorFromRGB(102, 102, 102)}]];
    [protocolText appendAttributedString:[[NSAttributedString  alloc] initWithString:@" " attributes:@{NSFontAttributeName:textFont,NSForegroundColorAttributeName:AppBaseTextColor3}]];
    PSConsultationViewModel *viewModel=(PSConsultationViewModel *)self.viewModel;
    UIImage *statusImage = viewModel.agreeProtocol ? [UIImage imageNamed:@"已勾选"] : [UIImage imageNamed:@"未勾选"];
    [protocolText insertAttributedString:[NSAttributedString attachmentStringWithContent:statusImage contentMode:UIViewContentModeCenter attachmentSize:statusImage.size alignToFont:textFont alignment:YYTextVerticalAlignmentCenter] atIndex:0];
    protocolText.alignment = NSTextAlignmentRight ;
    ((PSConsultationOtherTableViewCell*)cell).protocolLabel.attributedText = protocolText;
    ((PSConsultationOtherTableViewCell*)cell).protocolLabel.numberOfLines=0;
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
