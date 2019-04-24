//
//  FeedLoadItemView.m
//  PrisonService
//
//  Created by kky on 2018/12/19.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "FeedLoadItemView.h"
#import "PSAuthorizationTool.h"
#import "PSResponse.h"
#import "PSLoadingView.h"
#import "PSImagePickerController.h"
#import "UploadManager.h"


#define loadImg_width  67
#define close_width  18

@interface FeedLoadItemView ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImageView *loadImg;
@property (nonatomic, strong) UIImageView*closeImg;
@property (nonatomic, strong) UIImageView*loadiconImg;
@property (nonatomic, strong) UILabel*titleLab;

@end

@implementation FeedLoadItemView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame type:(FeedLoadType)type {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.loadImg];
        [self addSubview:self.loadiconImg];
        [self addSubview:self.closeImg];
        [self addSubview:self.titleLab];
        if (type == FeedLoadSelect) {
            self.loadImg.hidden = NO;
            self.loadiconImg.hidden = NO;
            self.closeImg.hidden = YES;
            self.titleLab.hidden = NO;
        } else if (type== FeedLoadNone){
            self.loadImg.hidden = YES;
            self.loadiconImg.hidden = YES;
            self.closeImg.hidden = YES;
            self.titleLab.hidden = YES;
        } else {
            self.loadImg.hidden = NO;
            self.loadiconImg.hidden = YES;
            self.closeImg.hidden = YES;
            self.titleLab.hidden = YES;
        }
    }
    return self;
}

- (void)setType:(FeedLoadType)Type {
    _Type = Type;
    
    if (Type == FeedLoadSelect) {
        self.loadImg.hidden = NO;
        self.loadiconImg.hidden = NO;
        self.closeImg.hidden = YES;
        self.titleLab.hidden = NO;
        self.loadImg.image = [UIImage imageNamed:@"bottomLoad"];
    } else if (Type== FeedLoadNone){
        self.loadImg.hidden = YES;
        self.loadiconImg.hidden = YES;
        self.closeImg.hidden = YES;
        self.titleLab.hidden = YES;
    } else {
        self.loadImg.hidden = NO;
        self.loadiconImg.hidden = YES;
        self.closeImg.hidden = NO;
        self.titleLab.hidden = YES;
    }
    
}

- (void)setUpLoadimage:(UIImage *)upLoadimage {
    self.loadImg.image = upLoadimage;
}

#pragma mark - Setting&&Getting
-(UIImageView *)loadImg {
    if (!_loadImg) {
        _loadImg = [[UIImageView alloc] init];
        _loadImg.frame =  CGRectMake((self.width-loadImg_width)/2,(self.width-loadImg_width)/2,loadImg_width,loadImg_width);
        _loadImg.image = [UIImage imageNamed:@"bottomLoad"];
        _loadImg.userInteractionEnabled = YES;
        @weakify(self);
            [_loadImg bk_whenTapped:^{
                @strongify(self);
                if (self.Type == FeedLoadSelect) { //选择图片
                    [self selectImg:self->_loadImg];
                } else if (self.Type == FeedloadIng) { //浏览图片
                    if (self.browserBlock) {
                        self.browserBlock(self.loadImg, self.tag);
                    }
                }
                
            }];
        }
    return _loadImg;
}

-(UIImageView *)closeImg {
    if (!_closeImg) {
        _closeImg = [[UIImageView alloc] init];
        _closeImg.frame = CGRectMake(self.width-close_width,0,close_width, close_width);
        _closeImg.image = [UIImage imageNamed:@"closeimg"];
        _closeImg.userInteractionEnabled = YES;
        @weakify(self);
        [_closeImg bk_whenTapped:^{
            @strongify(self);
            [self cancelPickerImage];
        }];
    }
    return _closeImg;
}

-(UIImageView *)loadiconImg {
    if (!_loadiconImg) {
        _loadiconImg = [[UIImageView alloc] init];
        _loadiconImg.frame = CGRectMake((self.width-24)/2,self.loadImg.top+15,24, 21);
        _loadiconImg.image = [UIImage imageNamed:@"loadImg"];
        [self addSubview:_loadiconImg];
    }
    return _loadiconImg;
}

-(UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.frame = CGRectMake((self.width-60)/2,_loadiconImg.bottom+1, 60, 25);
        _titleLab.textAlignment  = NSTextAlignmentCenter;
        _titleLab.text =  @"上传凭证";
        _titleLab.font = FontOfSize(9);
        _titleLab.numberOfLines = 0;
        _titleLab.textColor = UIColorFromRGB(153, 153, 153);
    }
    return _titleLab;
}

#pragma mark - TouchEvent
- (void)selectImg:(UIImageView *)sender {
    
    NSString *cancel =  @"取消";
    NSString *Choose_from_album =  @"从相册选择";
    NSString *Take_a_photo = @"拍照";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:nil];
    @weakify(self)
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:Take_a_photo style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [PSAuthorizationTool checkAndRedirectCameraAuthorizationWithBlock:^(BOOL result) {
       
            PSImagePickerController *picker = [[PSImagePickerController alloc] initWithCropHeaderImageCallback:^(UIImage *cropImage) {
                @strongify(self)
                [self handlePickerImage:cropImage];
            }];
         
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            picker.delegate = self;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picker animated:YES completion:nil];
    

        }];
             
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:Choose_from_album style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [PSAuthorizationTool checkAndRedirectPhotoAuthorizationWithBlock:^(BOOL result) {
            PSImagePickerController *picker = [[PSImagePickerController alloc] initWithCropHeaderImageCallback:^(UIImage *cropImage) {
                @strongify(self)
                [self handlePickerImage:cropImage];
                //上传图片
                sender.image = cropImage;
            }];
            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            picker.delegate = self;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picker animated:YES completion:nil];
        }];
    }];
    [alert addAction:cancelAction];
    [alert addAction:takePhotoAction];
    [alert addAction:albumAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

-(void)cancelPickerImage {
    
    if (self.cancelBlock) {
        self.cancelBlock(self.tag);
    }
}

- (void)handlePickerImage:(UIImage *)image {

    @weakify(self)
    [[PSLoadingView sharedInstance] show];
    [[UploadManager uploadManager] uploadConsultationImages:image completed:^(BOOL successful, NSString *tips) {
        @strongify(self);
        [[PSLoadingView sharedInstance] dismiss];
        if (successful) {
            NSDictionary*CerImageDict=@{@"fileId":tips,@"thumbFileId":tips};
            NSMutableArray*array=[[NSMutableArray alloc]init];
            [array addObject:CerImageDict];
            self.loadImg.image = image;
            self.selectBlock(self.tag,image,tips);
        } else {
            self.loadImg.image = [UIImage imageNamed:@"bottomLoad"];
            [PSTipsView showTips:@"反馈图片上传失败"];
        }
    } isShowTip:NO];
    
    
}



@end
