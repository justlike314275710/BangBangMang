//
//  MineViewController.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "Mine_AuthViewController.h"
#import "MineTableViewCell.h"
#import "MineHeaderView.h"
#import "ProfileViewController.h"
#import "SettingViewController.h"
#import "XYTransitionProtocol.h"
#import "UploadAvatarViewController.h"
#import "authBaseTableViewCell.h"
#import "DSSettingItem.h"
#import "PersonTableViewCell.h"
#import "AssessmentTableViewCell.h"
#import "IdCardTableViewCell.h"
#import "LawyerAuthenticationTableViewCell.h"
#import "UploadManager.h"
//#define KHeaderHeight ((260 * Iphone6ScaleWidth) + kStatusBarHeight)
#define KHeaderHeight 140

@interface Mine_AuthViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UINavigationControllerDelegate>

//    UILabel * lbl;
//    NSArray *_dataSource;
//    MineHeaderView *_headerView;//头部view
//    UIView *_NavView;//导航栏
//@property (nonatomic , strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation Mine_AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"专家入驻——法律咨询师";
    self.isHidenNaviBar = NO;
    self.StatusBarStyle = UIStatusBarStyleLightContent;
    self.isShowLiftBack = YES;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    _array = [[NSMutableArray alloc] init];
    [self createUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self getRequset];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}





#pragma mark ————— 设置tableview数据 —————
- (void)setData {
    {
        DSSettingGroup *group = [[DSSettingGroup alloc] init];
        
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeDetial title:@"真实姓名" icon:nil];
            item.details = @"请填入真实姓名";
            item.didSelectBlock = ^{
                
                
                
            };
            [group.items addObject:item];
            
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeDetial title:@"性别" icon:nil];
            item.details = @"性别";
            [group.items addObject:item];
            
        }
        {
            
            DSSettingItem*item=[DSSettingItem itemWithtype:DSSettingItemTypeTextView cellClassName:@"PersonTableViewCell"];
            item.isShowAccessory=NO;
            item.rowHeight=104.0f;
            [group.items addObject:item];
            
        }
        
        group.headTitle = @"  律师信息填写";
        
        [_array addObject:group];
    }
    
    {
        DSSettingGroup *group = [[DSSettingGroup alloc] init];
        
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeDetial title:@"执业机构" icon:nil];
            item.details=@"请输入职业机构";
            [group.items addObject:item];
            
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeDetial title:@"律师会所" icon:nil];
            item.details=@"请填写";
            [group.items addObject:item];
            
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeDetial title:@"专业领域" icon:nil];
            item.details = @"请选择";
            item.isForbidSelect = YES; //禁止点击
            [group.items addObject:item];
            
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeDetial title:@"律师等级" icon:nil];
            item.details = @"请选择";
            item.isForbidSelect = YES; //禁止点击
            [group.items addObject:item];
            
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeDetial title:@"律师年限" icon:nil];
            item.details = @"请填写职业年限";
            item.isForbidSelect = YES; //禁止点击
            [group.items addObject:item];
            
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeAlbum title:nil icon:nil];
            item.rowHeight=94.0f;
            item.isShowAccessory=NO;
            item.title=@"律师职业证书照片";
            [group.items addObject:item];
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeAlbum title:nil icon:nil];
            
            item.rowHeight=94.0f;
            item.isShowAccessory=NO;
            item.title=@"律师年度考核备案照片";
            [group.items addObject:item];
        }
        {
           DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeIDCard title:nil icon:nil];
            item.rowHeight=150.0f;
            item.isShowAccessory=NO;
            [group.items addObject:item];
        }
        
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeProtocol title:nil icon:nil];
            item.rowHeight=94.0f;
            item.isShowAccessory=NO;
            [group.items addObject:item];
        }
        group.headTitle= @"  执业信息填写";
        [_array addObject:group];
    }
    
    
    
}





#pragma mark ————— 创建页面 —————
-(void)createUI{
    
    self.tableView.height = KScreenHeight - kTabBarHeight;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    [self.tableView registerClass:[PersonTableViewCell class] forCellReuseIdentifier:@"PersonTableViewCell"];
    [self.tableView registerClass:[AssessmentTableViewCell class] forCellReuseIdentifier:@"AssessmentTableViewCell"];
    [self.tableView registerClass:[IdCardTableViewCell class] forCellReuseIdentifier:@"IdCardTableViewCell"];
    [self.tableView registerClass:[LawyerAuthenticationTableViewCell class] forCellReuseIdentifier:@"LawyerAuthenticationTableViewCell"];
    [self.tableView registerClass:[authBaseTableViewCell class] forCellReuseIdentifier:@"authBaseTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    UILabel *headView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    headView.backgroundColor = [UIColor colorWithRed:255/255.0 green:246/255.0 blue:233/255.0 alpha:1.0];
    headView.text = @"未认证，请填写资料申请认证.\n此认证信息仅用于平台审核，我们将对你填写对内容严格保密";
    headView.textColor=[UIColor colorWithRed:182/255.0 green:114/255.0 blue:52/255.0 alpha:1.0];
    headView.numberOfLines=0;
    headView.font = [UIFont boldSystemFontOfSize:11.0f];
    headView.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = headView;
    [self.view addSubview:self.tableView];
    
   [self setData];
  [self.tableView reloadData];
    

    

}


#pragma mark ————— tableview 代理 ————
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DSSettingGroup*group=self.array[section];
    return group.items.count;


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    DSSettingGroup*group=self.array[section];
    DSSettingItem*item=group.items[indexPath.row];
    return item.rowHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return [UIView new];
//}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view    forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor=[UIColor colorWithRed:81/255.0 green:89/255.0 blue:162/255.0 alpha:1.0];
    [header.textLabel setFont:[UIFont systemFontOfSize:11]];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   DSSettingGroup *group = self.array[section];
    return group.headTitle;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    DSSettingGroup*group=self.array[section];
    DSSettingItem*item=group.items[indexPath.row];

    UITableViewCell *cell=nil;
    switch (item.type) {
        case DSSettingItemTypeTextView:{
            cell=[tableView dequeueReusableCellWithIdentifier:@"PersonTableViewCell"];
            PersonTableViewCell*personCell=(PersonTableViewCell*)cell;
            [personCell.personText bk_whenTapped:^{
                
            }];
            
        }
            break;
            
        case  DSSettingItemTypeDetial:{
            cell=[tableView dequeueReusableCellWithIdentifier:@"authBaseTableViewCell"];
            authBaseTableViewCell*baseCell=(authBaseTableViewCell*)cell;
            baseCell.titleLbl.text=item.title;
            baseCell.detaileLbl.text=item.details;
            baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [baseCell setSeparatorInset:UIEdgeInsetsMake(0, 14, 0, 14)];
        }
            break;
            
            
        case DSSettingItemTypeAlbum:{
            cell=[tableView dequeueReusableCellWithIdentifier:@"AssessmentTableViewCell"];
            AssessmentTableViewCell*assessCell=(AssessmentTableViewCell*)cell;
            assessCell.titleLable.text=item.title;
            [assessCell.cameraButton bk_whenTapped:^{
                  [self ImagePickerClick];
            }];
        }
            break;
            
        case DSSettingItemTypeIDCard:{
            cell=[tableView dequeueReusableCellWithIdentifier:@"IdCardTableViewCell"];
            IdCardTableViewCell*IdcardCell=(IdCardTableViewCell*)cell;
            //assessCell.titleLable.text=item.title;
        }
            break;
            
        case DSSettingItemTypeProtocol:{
            cell=
            [tableView dequeueReusableCellWithIdentifier:@"LawyerAuthenticationTableViewCell"];
            LawyerAuthenticationTableViewCell*authCell
            =(LawyerAuthenticationTableViewCell*)cell;
            [authCell.SubmissionButton bk_whenTapped:^{
              
            }];
        }
            break;
        default:
            break;
    
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:
        {
            NSLog(@"点击了 修改资料");
        }
            break;
        case 1:
        {
            if (indexPath.row==0) {
                NSLog(@"点击了 账户余额");
            } else {
                NSLog(@"点击了 账单");
            }
        }
            break;
        case 2:
        {
            NSLog(@"点击了 专家入驻");
        }
            break;
        case 3:
        {
            if (indexPath.row==0) {
                NSLog(@"意见反馈");
            } else {
                NSLog(@"设置");
            }
        }
            break;
            
        default:
            break;
    }
    
    
}

#pragma mark ————— Event —————
-(void)ImagePickerClick {
    [PSAuthorizationTool checkAndRedirectCameraAuthorizationWithBlock:^(BOOL result) {
        if (result) {
            
            UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                     delegate:self
                                                            cancelButtonTitle:@"取消"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"拍照", @"从相册中选取", nil];
            [choiceSheet showInView:self.view];
        }
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex == 0) {
        // 拍照
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller
                           animated:YES
                         completion:^(void){
                             NSLog(@"Picker View Controller is presented");
                         }];
        
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.navigationBar.tintColor = [UIColor whiteColor];
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
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self uploadImage:portraitImg];
    }];
}
- (void)uploadImage:(UIImage *)image {
    [[UploadManager uploadManager]uploadConsultationImagesCompleted:^(BOOL successful, NSString *tips) {
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark ————— 切换账号 —————
-(void)changeUser{
    SettingViewController *settingVC = [SettingViewController new];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark ————— Setting —————


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
