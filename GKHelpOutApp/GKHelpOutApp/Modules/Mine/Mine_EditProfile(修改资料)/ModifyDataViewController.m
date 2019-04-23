//
//  ModifyDataViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/2/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "ModifyDataViewController.h"
#import "MineTableViewCell.h"
#import "ModifyoldPhoneNumberViewController.h"
#import "ModifyNicknameViewController.h"
#import "LLActionSheetView.h"
#import "UIImage+WLCompress.h"
#import "NSString+JsonString.h"
@interface ModifyDataViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate> {
     NSArray *_dataSource;
}
@property(nonatomic, strong) YYAnimatedImageView *headImgView; //头像

@end

@implementation ModifyDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人账户";
    self.isShowLiftBack = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupUI];
    [self intData];
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(intData)
                                                 name:KNotificationModifyDataChange
                                               object:nil];
    if (@available(iOS 11.0, *)) {
         [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }

    
}

- (void)intData{
    
    NSString *nickName = help_userManager.curUserInfo.nickname?help_userManager.curUserInfo.nickname:@"";
    NSDictionary *Modifydata = @{@"titleText":@"昵称",@"clickSelector":@"",@"detailText":nickName,@"arrow_icon":@"myarrow_icon"};
    
    NSString *phoneNumber = help_userManager.curUserInfo.username?help_userManager.curUserInfo.username:@"";
    if (phoneNumber.length>10) {
        phoneNumber = [NSString changeTelephone:phoneNumber];
    }
    NSDictionary *myMission = @{@"titleText":@"手机号码",@"clickSelector":@"",@"detailText":phoneNumber,@"arrow_icon":@"myarrow_icon"};
//    NSDictionary *myFriends = @{@"titleText":@"家庭住址",@"clickSelector":@"",@"arrow_icon":@"myarrow_icon",@"detailText":@"天安门广场"};
//    NSDictionary *myLevel = @{@"titleText":@"邮政编码",@"clickSelector":@"",@"detailText":@"410000",@"arrow_icon":@"myarrow_icon"};
    _dataSource = @[Modifydata,myMission];
    
    [self.tableView reloadData];
}

-(void)setupUI{
    
    [self.view addSubview:self.headImgView];
    self.tableView.frame = CGRectMake(0,_headImgView.bottom+50, KScreenWidth, KScreenHeight - kTopHeight - kTabBarHeight-_headImgView.bottom-50);
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"MineTableViewCell"];
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell" forIndexPath:indexPath];
    cell.cellData = _dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self modifyNickName];
        }
            break;
        case 1:
        {
            [self modifyPhoneNumber];
        }
            break;
        case 2:
        {
            [self modifyAddress];
        }
            break;
        case 3:
        {
            [self modifyPostalcode];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 修改昵称
-(void)modifyNickName {
    ModifyNicknameViewController *ModifyNickname = [[ModifyNicknameViewController alloc] init];
    ModifyNickname.modifyType=ModifyNickName;
    [self.navigationController pushViewController:ModifyNickname animated:nil];
}
#pragma mark - 修改手机号码
-(void)modifyPhoneNumber{
    ModifyoldPhoneNumberViewController *ModifyPhoneNumber = [[ModifyoldPhoneNumberViewController alloc] init];
    [self.navigationController pushViewController:ModifyPhoneNumber animated:YES];
}
#pragma mark - 修改家庭主址
-(void)modifyAddress{

}
#pragma mark - 修改邮政编码
-(void)modifyPostalcode{
    ModifyNicknameViewController *ModifyNickname = [[ModifyNicknameViewController alloc] init];
    ModifyNickname.modifyType=ModifyNickZipCode;
    [self.navigationController pushViewController:ModifyNickname animated:nil];
}

-(YYAnimatedImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [YYAnimatedImageView new];
        _headImgView.contentMode = UIViewContentModeScaleAspectFill;
        //_headImgView.backgroundColor = [UIColor redColor];
        _headImgView.userInteractionEnabled = YES;
        [_headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewClick)]];
        _headImgView.frame = CGRectMake((self.view.width-90*Iphone6ScaleWidth)/2,35, 100*Iphone6ScaleWidth, 100*Iphone6ScaleWidth);
        ViewRadius(_headImgView, (100*Iphone6ScaleWidth)/2);
        [self.view addSubview:_headImgView];
//        [_headImgView setImageWithURL:[NSURL URLWithString:help_userManager.curUserInfo.avatar] options:YYWebImageOptionRefreshImageCache];
        [_headImgView setImageWithURL:[NSURL URLWithString:help_userManager.curUserInfo.avatar] placeholder:[UIImage imageNamed:@"登录－头像"]];
    }
    return _headImgView;
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
    controller.edgesForExtendedLayout = UIRectEdgeNone;
    controller.navigationBar.tintColor = [UIColor grayColor];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.navigationBar.translucent = NO;
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

//拍照
-(void)openCamera{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.navigationBar.tintColor = [UIColor grayColor];
    controller.edgesForExtendedLayout = UIRectEdgeNone;
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
        NSInteger code =httpResponse.statusCode;
        NSLog(@"平台%ld",code);
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        if (data) {
            if (code==201||code==204) {
                id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                //                self.consultaionId=result[@"id"];
                self.headImgView.image = image;
                help_userManager.avatarImage = image;
                [PSTipsView showTips:@"头像修改成功"];
                KPostNotification(KNotificationMineDataChange, nil);
            } else {
                [PSTipsView showTips:@"头像修改失败"];
            }
        }
        else{
            [PSTipsView showTips:@"头像修改失败"];
        }
    }];
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




@end
