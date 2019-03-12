//
//  UploadAvatarViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/2/22.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "UploadAvatarViewController.h"
#import "UIImage+WLCompress.h"
#import "LLActionSheetView.h"
#import "ReactiveObjC.h"
#import "WXZTipView.h"

@interface UploadAvatarViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate>
@property(nonatomic, strong) YYAnimatedImageView *headImgView; //头像
@property(nonatomic, strong) UITextField *nickField;  //昵称
@property(nonatomic, strong) UIButton *compleBtn; //完成
@property (nonatomic, assign) NSInteger code;


@end

@implementation UploadAvatarViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHidenNaviBar = YES;
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - PrivateMethods

-(void)setupUI {
    
    UIImageView *bgImage = [UIImageView new];
    bgImage.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    bgImage.image = IMAGE_NAMED(@"底图");
    [self.view addSubview:bgImage];
    
    [self headImgView];
    
    UILabel *uploadLabel = [[UILabel alloc] initWithFrame:CGRectMake((KScreenWidth-100)/2, self.headImgView.bottom+10, 100, KNormalLabeLHeight)];
    uploadLabel.text = @"上传头像";
    uploadLabel.textColor = CFontColor3;
    uploadLabel.font = FFont2;
    uploadLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:uploadLabel];
    
    
    UIView *FieldBgView = [[UIView alloc] initWithFrame:CGRectMake(40, uploadLabel.bottom+50, KScreenWidth-80, KNormalBBtnHeight)];
    ViewRadius(FieldBgView, KNormalBBtnHeight/2);
    FieldBgView.backgroundColor = KWhiteColor;
    FieldBgView.layer.borderColor = CLineColor.CGColor;
    [self.view addSubview:FieldBgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20,(FieldBgView.height-KNormalLabeLHeight)/2, 50, KNormalLabeLHeight)];
    label.text = @"昵称";
    label.font = FFont1;
    label.textColor = CFontColor2;
    [FieldBgView addSubview:label];
    
    self.nickField.frame = CGRectMake(label.right+100,(FieldBgView.height-KNormalLabeLHeight)/2,120, KNormalLabeLHeight);
    self.nickField.right = FieldBgView.right-15;
    [FieldBgView addSubview:self.nickField];
    self.compleBtn.frame = CGRectMake(50,KScreenHeight-280,KScreenWidth-100, KNormalBBtnHeight);
    [self.view addSubview:self.compleBtn];
    
}

#pragma mark - TouchEvent
-(void)headViewClick {
    [PSAuthorizationTool checkAndRedirectCameraAuthorizationWithBlock:^(BOOL result) {
        if (result) {
            LLActionSheetView *alert = [[LLActionSheetView alloc]initWithTitleArray:@[@"拍照",@"从相册中选取"] andShowCancel:YES];
            alert.ClickIndex = ^(NSInteger index) {
                if (index == 1){
                    [self openCamera];
                }else if (index == 2){
                    [self openAlbum];
                }
            };
            [alert show];
        }
    }];
}
//打开相册
-(void)openAlbum{
    
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.navigationBar.tintColor = [UIColor grayColor];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
    controller.mediaTypes = mediaTypes;
    controller.delegate = self;
    [self presentViewController:controller
                       animated:YES
                     completion:^(void){
                         NSLog(@"Picker View Controller is presented");
                     }];
}
//拍照
-(void)openCamera{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.navigationBar.tintColor = [UIColor grayColor];
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
    controller.mediaTypes = mediaTypes;
    controller.delegate = self;
    [self presentViewController:controller
                       animated:YES
                     completion:^(void){
                         NSLog(@"Picker View Controller is presented");
                     }];

}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self uploadImage:portraitImg];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark -- UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    NSString *toBeString = textField.text;
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > 6)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:6];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:6];
                [WXZTipView showTopWithText:@"请输入不超过6位数的昵称"];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 6 - 1 )];
                textField.text = [toBeString substringWithRange:rangeRange];
                [WXZTipView showTopWithText:@"请输入不超过6位数的昵称"];
            }
        }
    }
}

#pragma mark - UploadImage
#define boundary @"6o2knFse3p53ty9dmcQvWAIx1zInP11uCfbm"
- (void)uploadImage:(UIImage *)image {
    //1 创建请求
    //NSString*urlSting=[NSString stringWithFormat:@"%@/files?type=PUBLIC",EmallHostUrl];
    NSString*urlSting=[NSString stringWithFormat:@"%@%@",EmallHostUrl,URL_upload_avatar];
    NSURL *url = [NSURL URLWithString:urlSting];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //    request.HTTPMethod = @"post";
    request.HTTPMethod = @"put";
    request.allHTTPHeaderFields = @{
                                    @"Content-Type":[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary]
                                    };
    NSData *compressData = [image compressWithLengthLimit:500.0f * 1024.0f];
    request.HTTPBody = [self makeBody:@"file" fileName:@"fileName" data:compressData];
    //UIImageJPEGRepresentation(self.consultaionImage, 0.1)
    NSString*token=[NSString stringWithFormat:@"Bearer %@",help_userManager.oathInfo.access_token];
    
    [request addValue:token forHTTPHeaderField:@"Authorization"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        self.code=httpResponse.statusCode;
        NSLog(@"平台%ld",(long)self.code);
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        if (data) {
            if (self.code==201||self.code==204) {
                id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//                self.consultaionId=result[@"id"];
                self.headImgView.image = image;
                help_userManager.avatarImage = image;
                 [PSTipsView showTips:@"头像修改成功"];
            } else {
                [PSTipsView showTips:@"头像修改失败"];
            }
        }
        else{
             [PSTipsView showTips:@"头像修改失败"];
        }
    }];
}

#pragma mark - 修改用户昵称
- (void)modifyAccountNickname {
    
    if (self.nickField.text.length==0) {
        [PSTipsView showTips:@"请输入昵称！"];
        return;
    } else if(self.nickField.text.length>6) {
        [PSTipsView showTips:@"昵称不能超过6位数！"];
        return;
    }
    UserInfo *user = help_userManager.curUserInfo;
    NSLog(@"%@",user);
    NSString*url=[NSString stringWithFormat:@"%@%@",EmallHostUrl,URL_modify_nickname];
    NSDictionary*parmeters=@{
                             @"phoneNumber":help_userManager.curUserInfo.username,
                             @"nickname":self.nickField.text
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString*token=[NSString stringWithFormat:@"Bearer %@",help_userManager.oathInfo.access_token];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager PUT:url parameters:parmeters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode==204) {
            [PSTipsView showTips:@"昵称修改成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
             help_userManager.curUserInfo.nickname = self.nickField.text;
             [help_userManager saveUserInfo];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        [[PSLoadingView sharedInstance]dismiss];
        NSLog(@"%@",error);
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (ValidData(data)) {
            id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString*code=body[@"code"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

-(NSString *)base64EncodeString:(NSString *)string{
    //1、先转换成二进制数据
    NSData *data =[string dataUsingEncoding:NSUTF8StringEncoding];
    //2、对二进制数据进行base64编码，完成后返回字符串
    return [data base64EncodedStringWithOptions:0];
}

- (NSData *)makeBody:(NSString *)fieldName fileName:(NSString *)fileName data:(NSData *)fileData{
    NSMutableData *data = [NSMutableData data];
    NSMutableString *str = [NSMutableString string];
    [str appendFormat:@"--%@\r\n",boundary];
    [str appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",fieldName,fileName];
    [str appendString:@"Content-Type: image/jpeg\r\n\r\n"];
    [data appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:fileData];
    NSString *tail = [NSString stringWithFormat:@"\r\n--%@--",boundary];
    [data appendData:[tail dataUsingEncoding:NSUTF8StringEncoding]];
    return [data copy];
}


#pragma mark - Setting&Getting
-(YYAnimatedImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [YYAnimatedImageView new];
        _headImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headImgView.backgroundColor = [UIColor redColor];
        _headImgView.userInteractionEnabled = YES;
        [_headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewClick)]];
        _headImgView.frame = CGRectMake((self.view.width-90*Iphone6ScaleWidth)/2, 100, 100*Iphone6ScaleWidth, 100*Iphone6ScaleWidth);
        ViewRadius(_headImgView, (100*Iphone6ScaleWidth)/2);
        [self.view addSubview:_headImgView];
        [_headImgView setImageWithURL:[NSURL URLWithString:help_userManager.curUserInfo.avatar] placeholder:IMAGE_NAMED(@"登录－头像") options:YYWebImageOptionRefreshImageCache completion:nil];
    }
    return _headImgView;
}

- (UIButton *)compleBtn {
    if (!_compleBtn) {
        _compleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_compleBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_compleBtn setTitleColor:CFontColor_BtnTitle forState:UIControlStateNormal];
        [_compleBtn setBackgroundImage:IMAGE_NAMED(@"登录底") forState:UIControlStateNormal];
        @weakify(self)
        [_compleBtn addTapBlock:^(UIButton *btn) {
            @strongify(self)
            [self modifyAccountNickname];
        }];
    }
    return _compleBtn;
}

- (UITextField *)nickField {
    if (!_nickField) {
        _nickField = [[UITextField alloc] init];
        _nickField.placeholder = @"请输入昵称";
        _nickField.textAlignment = NSTextAlignmentLeft;
        _nickField.textColor = CFontColor2;
        _nickField.font = FFont1;
        _nickField.delegate = self;
        [_nickField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _nickField;
}

@end
