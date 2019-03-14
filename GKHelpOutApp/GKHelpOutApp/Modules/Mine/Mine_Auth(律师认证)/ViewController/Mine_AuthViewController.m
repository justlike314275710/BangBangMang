//
//  MineViewController.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//
#import "Mine_StatusViewController.h"
#import "fileModel.h"
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
#import "CertificateTableViewCell.h"
#import "UploadManager.h"
#import "Mine_CategoryViewController.h"
#import "PSConsultationViewModel.h"
#import "BRInfoModel.h"
#import "BRPickerView.h"
#import "Mine_AuthLogic.h"
#import "Mine_addressViewController.h"

#import "Mine_AuthaginViewController.h"

//#define KHeaderHeight ((260 * Iphone6ScaleWidth) + kStatusBarHeight)
#define KHeaderHeight 140

@interface Mine_AuthViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate>

//    UILabel * lbl;
//    NSArray *_dataSource;
//    MineHeaderView *_headerView;//头部view
//    UIView *_NavView;//导航栏
//@property (nonatomic , strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic , strong) CertificateTableViewCell*cerCell ;
@property (nonatomic , strong) AssessmentTableViewCell*assessCell;
@property (nonatomic , strong) IdCardTableViewCell *idCardCell;
@property (nonatomic , strong) LawyerAuthenticationTableViewCell*authCell;
@property (nonatomic , assign) int Btntager;
@property (nonatomic , strong) Mine_AuthLogic *authLogic;

@property (nonatomic , strong) lawyerInfo *lawyerModel;
@property (nonatomic , strong) NSMutableArray *LawyerCategories;//提交后的类型数组
@property (nonatomic , strong) UIView *headView;
@property (nonatomic , strong) UILabel*headLable;
@property (nonatomic , assign) BOOL isUserEnabled;
@end

@implementation Mine_AuthViewController

#pragma mark ————— LifeCycle —————
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"专家入驻——法律咨询师";
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = YES;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    _array = [[NSMutableArray alloc] init];
    self.authLogic=[Mine_AuthLogic new];
   // [self createUI];
    [self loadLawyerInfo];
    [self SDWebImageAuth];
    
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

- (void)loadLawyerInfo {
    [[PSLoadingView sharedInstance]show];
    [self.authLogic GETCertificationData:^(id data) {
        YYCache *cache = [[YYCache alloc] initWithName:KLawyerModelCache];
        NSDictionary * lawyerInfoDic = (NSDictionary *)[cache objectForKey:KLawyerModelCache];
        [[PSLoadingView sharedInstance]dismiss];
        if (lawyerInfoDic) {
            self.lawyerModel = [lawyerInfo modelWithJSON:lawyerInfoDic];
            [self bulidLawyerModel];
            [self setData];
            [self createUI];
        }
        else{
            [self setData];
            [self createUI];
        }
    } failed:^(NSError *error) {
         [[PSLoadingView sharedInstance]dismiss];
        [self setData];
        [self createUI];
        //[PSTipsView showTips:@"获取律师认证详情失败"];
    }];
    
 
}
#pragma mark ————— 创建页面 —————
-(void)createUI{
    //self.view.userInteractionEnabled=NO;
    self.tableView.height = KScreenHeight - kTabBarHeight;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    [self.tableView registerClass:[PersonTableViewCell class] forCellReuseIdentifier:@"PersonTableViewCell"];
    [self.tableView registerClass:[AssessmentTableViewCell class] forCellReuseIdentifier:@"AssessmentTableViewCell"];
    [self.tableView registerClass:[CertificateTableViewCell class] forCellReuseIdentifier:@"CertificateTableViewCell"];
    [self.tableView registerClass:[IdCardTableViewCell class] forCellReuseIdentifier:@"IdCardTableViewCell"];
    [self.tableView registerClass:[LawyerAuthenticationTableViewCell class] forCellReuseIdentifier:@"LawyerAuthenticationTableViewCell"];
    [self.tableView registerClass:[authBaseTableViewCell class] forCellReuseIdentifier:@"authBaseTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSLog(@"%ld",(long)help_userManager.userStatus);
    switch (help_userManager.userStatus) {
        case PENDING_CERTIFIED:
            self.tableView.tableHeaderView =self.headLable ;
            self.isUserEnabled=YES;
            break;
        case CERTIFIED:
            self.tableView.tableHeaderView =self.headView;
             self.isUserEnabled=NO;
            break;
        default:
            self.tableView.tableHeaderView =self.headLable ;
            break;
    }
   [self.view addSubview:self.tableView];
   //[self setData];
   [self.tableView reloadData];
}



#pragma mark ————— tableview 代理 ————

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

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
            personCell.personText.delegate=self;
            if (item.Textdetails) {
                personCell.personText.text=item.Textdetails;
            }
            cell.userInteractionEnabled=self.isUserEnabled;
        }
            break;
        case  DSSettingItemTypeDetial:{
            cell=[tableView dequeueReusableCellWithIdentifier:@"authBaseTableViewCell"];
            authBaseTableViewCell*baseCell=(authBaseTableViewCell*)cell;
            
            if (section==0) {
                if (indexPath.row==0) {
                    baseCell.arrowIcon.hidden=YES;
                    baseCell.isShow=NO;
                }
            }
            else{
                if (indexPath.row==0) {
                    baseCell.arrowIcon.hidden=YES;
                     baseCell.isShow=NO;
                }
                else if (indexPath.row==4){
                    baseCell.arrowIcon.hidden=YES;
                     baseCell.isShow=NO;
                }
                else{
                    
                }
            }
            
            baseCell.titleLbl.text=item.title;
             cell.userInteractionEnabled=self.isUserEnabled;
            if (item.Textdetails) {
                baseCell.detaileLbl.text=item.Textdetails;
            }
            else{
                baseCell.detaileLbl.placeholder=item.details;
            }
            baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [baseCell setSeparatorInset:UIEdgeInsetsMake(0, 14, 0, 14)];
            baseCell.detaileLbl.delegate = self;
            baseCell.detaileLbl.tag = indexPath.row+section*100;
            
          
        }
            break;
            
            
        case DSSettingItemTypeCer:{
            cell=[tableView dequeueReusableCellWithIdentifier:@"CertificateTableViewCell"];
            self.cerCell=(CertificateTableViewCell*)cell;
            self.cerCell.titleLable.text=item.title;
            cell.userInteractionEnabled=self.isUserEnabled;
            [self.cerCell.cameraButton bk_whenTapped:^{
                  self.Btntager=defultTager+1;
                  [self ImagePickerClick];
            }];
            
            fileModel*filemodel=[fileModel modelWithJSON:self.lawyerModel.certificatePictures[0]];
            NSString*url=NSStringFormat(@"%@/files/%@",EmallHostUrl,filemodel.fileId);
            [self.cerCell.cameraButton sd_setImageWithURL:[NSURL URLWithString:url] forState:0 placeholderImage:[UIImage imageNamed:@"上传图片"]];
        }
            break;
            
            
        case DSSettingItemTypeAss:{
            cell=[tableView dequeueReusableCellWithIdentifier:@"AssessmentTableViewCell"];
            self.assessCell=(AssessmentTableViewCell*)cell;
             cell.userInteractionEnabled=self.isUserEnabled;
            self. assessCell.titleLable.text=item.title;
            [self.assessCell.cameraButton bk_whenTapped:^{
                self.Btntager=defultTager+2;
                [self ImagePickerClick];
            }];
        fileModel*filemodel=[fileModel modelWithJSON:self.lawyerModel.assessmentPictures[0]];
            NSString*url=NSStringFormat(@"%@/files/%@",EmallHostUrl,filemodel.fileId);
            [self.assessCell.cameraButton sd_setImageWithURL:[NSURL URLWithString:url] forState:0 placeholderImage:[UIImage imageNamed:@"上传图片"]];
        }
            break;
            
        case DSSettingItemTypeIDCard:{
            cell=[tableView dequeueReusableCellWithIdentifier:@"IdCardTableViewCell"];
            self.idCardCell=(IdCardTableViewCell*)cell;
             cell.userInteractionEnabled=self.isUserEnabled;
            [self.idCardCell.frontCardButton bk_whenTapped:^{
                self.Btntager=defultTager+3;
                [self ImagePickerClick];
            }];
            fileModel*filemodel=[fileModel modelWithJSON:self.lawyerModel.identificationPictures[0]];
            NSString*url=NSStringFormat(@"%@/files/%@",EmallHostUrl,filemodel.fileId);
            [self.idCardCell.frontCardButton sd_setImageWithURL:[NSURL URLWithString:url] forState:0 placeholderImage:[UIImage imageNamed:@"上传正面身份证底"]];
            
            [self.idCardCell.backCardButton bk_whenTapped:^{
                self.Btntager=defultTager+4;
                [self ImagePickerClick];
            }];
            
            fileModel*backmodel=[fileModel modelWithJSON:self.lawyerModel.identificationPictures[1]];
            NSString*backUrl=NSStringFormat(@"%@/files/%@",EmallHostUrl,backmodel.fileId);
            [self.idCardCell.backCardButton sd_setImageWithURL:[NSURL URLWithString:backUrl] forState:0 placeholderImage:[UIImage imageNamed:@"上传背面身份证底"]];
            //assessCell.titleLable.text=item.title;
        }
            break;
            
        case DSSettingItemTypeProtocol:{
            cell=
            [tableView dequeueReusableCellWithIdentifier:@"LawyerAuthenticationTableViewCell"];
            self.authCell
            =(LawyerAuthenticationTableViewCell*)cell;
//            [self.authCell.SubmissionButton bk_whenTapped:^{
//                [self checkLawyerBasicData];
//            }];
            switch (help_userManager.userStatus) {
                case CERTIFIED:{
                    [self.authCell.SubmissionButton setTitle:@"重新认证" forState:0];
                    [self.authCell.SubmissionButton bk_whenTapped:^{
                        [self.navigationController pushViewController:[[Mine_AuthaginViewController alloc]init] animated:YES];
                    }];
                    break;
                }
                default:{
                    [self.authCell.SubmissionButton bk_whenTapped:^{
                        [self checkLawyerBasicData];
                    }];
                }
                    break;
            }
            
        }
            break;
        default:
            break;
    
    }
  
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:
        {
           
        }
            break;
        case 1:
        {
            if (indexPath.row==0) {
               
            }
            else if (indexPath.row==1){
                
            }
            else if (indexPath.row==2){
                [self.navigationController pushViewController:[PSConsultingCategoryViewController new] animated:YES];
            }
            else if (indexPath.row==3){
                
            }
        }
            break;
       
            
        default:
            break;
    }
    */
    
}

#pragma mark ————— Event —————
-(void)checkLawyerBasicData{
    NSLog(@"%@",self.lawyerModel.identificationPictures[0]);
    if (self.authLogic.name.length == 0) {
        if (self.lawyerModel.name.length!=0) {
            self.authLogic.name=self.lawyerModel.name;
        } else {
            [PSTipsView showTips:@"请输入真实姓名"];
            return;
        }
    }
    
    if (self.authLogic.gender.length == 0) {
        if (self.lawyerModel.gender.length!=0) {
            self.authLogic.gender=self.lawyerModel.gender;
        } else {
            [PSTipsView showTips:@"请选择性别"];
            return;
        }
        
    }
    if (self.authLogic.lawDescription.length == 0) {
        if (self.lawyerModel.lawDescription.length!=0) {
            self.authLogic.lawDescription=self.lawyerModel.lawDescription;
        } else {
            [PSTipsView showTips:@"请输入个人简介"];
            return;
        }
       
    }
    if (self.authLogic.lawOffice.length == 0) {
        if (self.lawyerModel.lawOffice.length!=0) {
            self.authLogic.lawOffice=self.lawyerModel.lawOffice;
        } else {
            [PSTipsView showTips:@"请输入执业机构"];
            return;
        }
    }
    NSString*streetDetail=self.authLogic.lawOfficeAddress[@"streetDetail"];
    if (streetDetail.length==0) {
         NSString*streetDetail=self.lawyerModel.lawOfficeAddress[@"streetDetail"];
        if (streetDetail.length==0) {
            [PSTipsView showTips:@"请输入执业机构"];
            return;
        } else {
              self.authLogic.lawOfficeAddress=self.lawyerModel.lawOfficeAddress;
            NSLog(@"%@",self.lawyerModel.lawOfficeAddress);
        }
    }
    if (self.authLogic.categories.count==0) {
        if (self.lawyerModel.categories.count!=0) {
            self.authLogic.categories=self.LawyerCategories;
        } else {
            [PSTipsView showTips:@"请选择专业领域"];
            return;
        }
       
    }
    if (self.authLogic.level.length==0) {
        if (self.lawyerModel.level.length!=0) {
            self.authLogic.level=self.lawyerModel.level;
        } else {
            [PSTipsView showTips:@"请选择律师等级"];
            return;
        }
    }
    if (self.authLogic.workExperience==0) {
        if (self.lawyerModel.workExperience!=0) {
            self.authLogic.workExperience=self.lawyerModel.workExperience;
        } else {
            [PSTipsView showTips:@"请选择律师年限"];
            return;
        }
    }
    if (self.authLogic.certificatePictures.count==0) {
        if (self.lawyerModel.certificatePictures.count!=0) {
            self.authLogic.certificatePictures=self.lawyerModel.certificatePictures;
        } else {
            [PSTipsView showTips:@"请上传律师职业证书照片"];
            return;
        }
    }
    if (self.authLogic.assessmentPictures.count==0) {
        if (self.lawyerModel.assessmentPictures.count!=0) {
            self.authLogic.assessmentPictures=self.lawyerModel.assessmentPictures;
        } else {
            [PSTipsView showTips:@"请上传律师年度考核备案照片"];
            return;
        }
    }
    if (self.authLogic.fontCardPictures.count==0) {
        if (self.lawyerModel.identificationPictures.count!=0) {
            NSDictionary*dic=[[NSDictionary alloc]init];
            dic=self.lawyerModel.identificationPictures[0];
            NSMutableArray*fontCardPictures=[[NSMutableArray alloc]init];
            [fontCardPictures addObject:dic];
            self.authLogic.fontCardPictures=fontCardPictures;
        } else {
            [PSTipsView showTips:@"请上传身份证正面照片"];
            return;
        }
        
    }
    if (self.authLogic.backCardPictures.count==0) {
        if (self.lawyerModel.identificationPictures.count!=0) {
            NSDictionary*dic=[[NSDictionary alloc]init];
            dic=self.lawyerModel.identificationPictures[1];
            NSMutableArray*backCardPictures=[[NSMutableArray alloc]init];
            [backCardPictures addObject:dic];
            self.authLogic.backCardPictures=backCardPictures;
        } else {
            [PSTipsView showTips:@"请上传身份证反面照片"];
            return;
        }
       
    }
   [self postLawyerCertification];

}

-(void)postLawyerCertification{
    [self.authLogic postCertificationData:^(id data) {
        [PSTipsView showTips:@"提交律师认证成功!"];
        [self.navigationController pushViewController:[[Mine_StatusViewController alloc]init] animated:YES];
    } failed:^(NSError *error) {
        [PSTipsView showTips:@"提交律师认证失败!"];
    }];
}

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
        if (self.Btntager==defultTager+1) {
             [self uploadCerImage:portraitImg];
        }
        else if (self.Btntager==defultTager+2){
             [self uploadAssImage:portraitImg];
        }
        else if (self.Btntager==defultTager+3){
            [self uploadFrontCardImage:portraitImg];
        }
        else if (self.Btntager==defultTager+4){
            [self uploadBlackCardImageImage:portraitImg];
        }
        else {
           
        }
       
    }];
}

#pragma mark - UITextFieldDelegate 返回键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 0 || textField.tag == 4) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 0 || textField.tag == 100||textField.tag == 104) {
        [textField addTarget:self action:@selector(handlerTextFieldEndEdit:) forControlEvents:UIControlEventEditingDidEnd];
        return YES; // 当前 textField 可以编辑
    } else {
        [self.view endEditing:YES];
        [self handlerTextFieldSelect:textField];
        return NO; // 当前 textField 不可编辑，可以响应点击事件
    }
}
#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.authLogic.lawDescription=textView.text;
}

#pragma mark - 处理编辑事件
- (void)handlerTextFieldEndEdit:(UITextField *)textField {
    NSLog(@"结束编辑:%@", textField.text);
    switch (textField.tag) {
        case 0://姓名
        {
            self.authLogic.name=textField.text;
        }
            break;
        case 100://执业机构
        {
            self.authLogic.lawOffice=textField.text;
           
        }
            break;
            
        case 104://律师年限
        {
            self.authLogic.workExperience=[textField.text intValue];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 处理点击事件
- (void)handlerTextFieldSelect:(UITextField *)textField {
    switch (textField.tag) {
        case 1://性别
        {
            [BRStringPickerView showStringPickerWithTitle:@"请选择性别" dataSource:@[@"男", @"女", @"其他"] defaultSelValue:textField.text resultBlock:^(id selectValue) {
                textField.text = selectValue;
                self.authLogic.gender=selectValue;
            }];
        }
            break;
            
        case 101://律师会所
        {
            Mine_addressViewController*addressVc=[[Mine_addressViewController alloc]init];
            [self.navigationController pushViewController:addressVc animated:YES];
            [addressVc setReturnValueBlock:^(NSDictionary *dictionaryValue) {
                self.authLogic.lawOfficeAddress=dictionaryValue;
                 NSString*streetDetail=dictionaryValue[@"streetDetail"];
                 NSString*provinceName=dictionaryValue[@"provinceName"];
                 NSString*cityName=dictionaryValue[@"cityName"];
                 NSString*countyName=dictionaryValue[@"countyName"];
                 textField.text=streetDetail?
NSStringFormat(@"%@%@%@%@",provinceName,cityName,countyName,streetDetail):@"";
            }];

        }
            break;
        case 102:
        {
            Mine_CategoryViewController*consutingVc=[[Mine_CategoryViewController alloc]initWithViewModel:[PSConsultationViewModel new]];
             [self.navigationController pushViewController:consutingVc animated:YES];
            consutingVc.returnValueBlock = ^(NSArray *arrayValue) {
                NSString*category=[arrayValue componentsJoinedByString:@"、"];
                textField.text=category;
                self.authLogic.categories=arrayValue;
            };
            
        }
            break;
        case 103:
        {
             NSArray *dataSource = @[@"一级律师(高级律师)", @"二级律师(副高级律师)", @"三级律师(中级律师)", @"四级律师(初级律师)"];
            [BRStringPickerView showStringPickerWithTitle:@"选择律师等级" dataSource:dataSource defaultSelValue:textField.text isAutoSelect:YES themeColor:nil resultBlock:^(id selectValue) {
                textField.text = selectValue;
                self.authLogic.level=textField.text;
            } cancelBlock:^{
                NSLog(@"点击了背景视图或取消按钮");
            }];
        }
            break;
        case 5:
        {
            NSArray *defaultSelArr = [textField.text componentsSeparatedByString:@" "];
            NSArray *dataSource = nil;
            [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataSource defaultSelected:defaultSelArr isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                textField.text =  [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
                NSLog(@"省[%@]：%@，%@", @(province.index), province.code, province.name);
                NSLog(@"市[%@]：%@，%@", @(city.index), city.code, city.name);
                NSLog(@"区[%@]：%@，%@", @(area.index), area.code, area.name);
                NSLog(@"--------------------");
            } cancelBlock:^{

            }];
        }
            break;
        case 6:
        {
           
            NSString *dataSource = @"testData1.plist"; // 可以将数据源（上面的数组）放到plist文件中
            [BRStringPickerView showStringPickerWithTitle:@"学历" dataSource:dataSource defaultSelValue:textField.text isAutoSelect:YES themeColor:nil resultBlock:^(id selectValue) {
                textField.text = selectValue;
            } cancelBlock:^{

            }];
        }
            break;

            
        default:
            break;
    }
}

#pragma mark ————— 律师执业证书照片上传 —————
- (void)uploadCerImage:(UIImage *)image {
    [[UploadManager uploadManager]uploadConsultationImages:image completed:^(BOOL successful, NSString *tips) {
        [self.cerCell.cameraButton setImage:image forState:0];
        NSLog(@"%@",tips);
        NSDictionary*CerImageDict=@{@"fileId":tips,@"thumbFileId":tips};
        NSMutableArray*array=[[NSMutableArray alloc]init];
        [array addObject:CerImageDict];
        
        self.authLogic.certificatePictures=array;
    }];
}

#pragma mark ————— 律师年度考核备案照片上传 —————
- (void)uploadAssImage:(UIImage *)image {
    [[UploadManager uploadManager]uploadConsultationImages:image completed:^(BOOL successful, NSString *tips) {
        NSDictionary*AssImageDict=@{@"fileId":tips,@"thumbFileId":tips};
        NSMutableArray*array=[[NSMutableArray alloc]init];
        [array addObject:AssImageDict];
        self.authLogic.assessmentPictures=array;
        [self.assessCell.cameraButton setImage:image forState:0];
    }];
}

#pragma mark ————— 身份证照片正面上传 —————
- (void)uploadFrontCardImage:(UIImage *)image {
    [[UploadManager uploadManager]uploadConsultationImages:image completed:^(BOOL successful, NSString *tips) {
        [self.idCardCell.frontCardButton setImage:image forState:0];
         NSDictionary*FrontCardImageDict=@{@"fileId":tips,@"thumbFileId":tips};
        NSMutableArray*array=[[NSMutableArray alloc]init];
        [array addObject:FrontCardImageDict];
        self.authLogic.fontCardPictures=array;
    }];
}

#pragma mark ————— 身份证照片反面上传 —————
- (void)uploadBlackCardImageImage:(UIImage *)image {
    [[UploadManager uploadManager]uploadConsultationImages:image completed:^(BOOL successful, NSString *tips) {
        [self.idCardCell.backCardButton setImage:image forState:0];
        NSDictionary*FrontCardImageDict=@{@"fileId":tips,@"thumbFileId":tips};
        NSMutableArray*array=[[NSMutableArray alloc]init];
        [array addObject:FrontCardImageDict];
        self.authLogic.backCardPictures=array;
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

- (UIView *)headView{
    if (!_headView) {
        
        CGFloat width=71.0f;
        CGFloat height=63.0f;
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 125)];
        _headView.backgroundColor = [UIColor whiteColor];
        UIImageView*statusImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"已认证图"]];
        statusImage.frame=CGRectMake((SCREEN_WIDTH-width)/2, 19, width, height);
        [_headView addSubview:statusImage];
        
        UILabel*titleLable=[UILabel new];
        titleLable.text=@"您已经通过认证";
        titleLable.textAlignment=NSTextAlignmentCenter;
        titleLable.frame=CGRectMake(30, statusImage.bottom+15, SCREEN_WIDTH-60, 13);
        titleLable.font=FontOfSize(11);
        [_headView addSubview:titleLable];
    }
    return _headView;
}

- (UILabel *)headLable{
    if (!_headLable) {
        _headLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        _headLable.backgroundColor = [UIColor colorWithRed:255/255.0 green:246/255.0 blue:233/255.0 alpha:1.0];
        _headLable.text = @"未认证，请填写资料申请认证.\n此认证信息仅用于平台审核，我们将对你填写对内容严格保密";
        _headLable.textColor=[UIColor colorWithRed:182/255.0 green:114/255.0 blue:52/255.0 alpha:1.0];
        _headLable.numberOfLines=0;
        _headLable.font = [UIFont boldSystemFontOfSize:11.0f];
        _headLable.textAlignment = NSTextAlignmentCenter;
    }
    return _headLable;
}

- (void)bulidLawyerModel{
    if (_lawyerModel.level) {
        if ([_lawyerModel.level isEqualToString:@"FIRST"]) {
            _lawyerModel.level=@"一级律师(高级律师)";
        }
        else if ([_lawyerModel.level isEqualToString:@"SECOND"]){
            _lawyerModel.level=@"二级律师(副高级律师)";
        }
        else if ([_lawyerModel.level isEqualToString:@"THIRD"]){
            _lawyerModel.level=@"三级律师(中级律师)";
        }
        else if ([_lawyerModel.level isEqualToString:@"FOURTH"]){
            _lawyerModel.level=@"四级律师(初级律师)";
        }
    }
    if (_lawyerModel.gender) {
        if ([_lawyerModel.gender isEqualToString:@"MALE"]) {
            _lawyerModel.gender=@"男";
        }
        else{
            _lawyerModel.gender=@"女";
        }
    }
    if (_lawyerModel.categories) {
         self.LawyerCategories=[[NSMutableArray alloc]init];
        for (int i=0; i<_lawyerModel.categories.count; i++) {
            if ([_lawyerModel.categories[i] isEqualToString:@"PROPERTY_DISPUTES"]) {
                [self.LawyerCategories addObject:@"财产纠纷"];
            }
            else if ([_lawyerModel.categories[i] isEqualToString:@"MARRIAGE_FAMILY"]){
                [self.LawyerCategories addObject:@"婚姻家庭"];
            }
            else if ([_lawyerModel.categories[i] isEqualToString:@"TRAFFIC_ACCIDENT"]){
                 [self.LawyerCategories addObject:@"交通事故"];
            }
            else if ([_lawyerModel.categories[i] isEqualToString:@"WORK_COMPENSATION"]){
                 [self.LawyerCategories addObject:@"工伤赔偿"];
            }
            else if ([_lawyerModel.categories[i] isEqualToString:@"CONTRACT_DISPUTE"]){
                 [self.LawyerCategories addObject:@"合同纠纷"];
            }
            else if ([_lawyerModel.categories[i] isEqualToString:@"CRIMINAL_DEFENSE"]){
                 [self.LawyerCategories addObject:@"刑事辩护"];
            }
            else if ([_lawyerModel.categories[i] isEqualToString:@"HOUSING_DISPUTES"]){
                 [self.LawyerCategories addObject:@"房产纠纷"];
            }
            else if ([_lawyerModel.categories[i] isEqualToString:@"LABOR_EMPLOYMENT"]){
                 [self.LawyerCategories addObject:@"劳动就业"];
            }}
    }
}

#pragma mark ————— 设置tableview数据 —————
- (void)setData {
    {
        DSSettingGroup *group = [[DSSettingGroup alloc] init];
        
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeDetial title:@"真实姓名" icon:nil];
            item.details = @"请填入真实姓名";
            item.Textdetails=self.lawyerModel.name;
            [group.items addObject:item];
            
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeDetial title:@"性别" icon:nil];
            item.details = @"性别";
            item.Textdetails=self.lawyerModel.gender;
            [group.items addObject:item];
            
        }
        {
            
            DSSettingItem*item=[DSSettingItem itemWithtype:DSSettingItemTypeTextView cellClassName:@"PersonTableViewCell"];
            item.Textdetails=self.lawyerModel.lawDescription;
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
            item.details=@"请输入执业机构";
            item.Textdetails=self.lawyerModel.lawOffice;
            [group.items addObject:item];
            
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeDetial title:@"律师地址" icon:nil];
            item.details=@"请填写";
            NSString*streetDetail=self.lawyerModel.lawOfficeAddress[@"streetDetail"];
             NSString*provinceName=self.lawyerModel.lawOfficeAddress[@"provinceName"];
             NSString*cityName=self.lawyerModel.lawOfficeAddress[@"cityName"];
             NSString*countyName=self.lawyerModel.lawOfficeAddress[@"countryName"];
            item.Textdetails
            =streetDetail?
NSStringFormat(@"%@%@%@%@",provinceName,cityName,countyName,streetDetail):@"";
            [group.items addObject:item];
            
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeDetial title:@"专业领域" icon:nil];
            item.details = @"请选择";
             NSString*category=[self.LawyerCategories componentsJoinedByString:@"、"];
            item.Textdetails=category;
            item.isForbidSelect = YES; //禁止点击
            [group.items addObject:item];
            
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeDetial title:@"律师等级" icon:nil];
            item.details = @"请选择";
            item.Textdetails=self.lawyerModel.level;
            item.isForbidSelect = YES; //禁止点击
            [group.items addObject:item];
            
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeDetial title:@"职业年限" icon:nil];
            item.details = @"请填写职业年限";
            if (self.lawyerModel.workExperience!=0) {
                 item.Textdetails=[NSString stringWithFormat:@"%d年",self.lawyerModel.workExperience];
            }
            item.isForbidSelect = YES; //禁止点击
            [group.items addObject:item];
            
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeCer title:nil icon:nil];
            item.rowHeight=94.0f;
            item.isShowAccessory=NO;
            item.title=@"律师职业证书照片";
            [group.items addObject:item];
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeAss title:nil icon:nil];
            
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
            item.rowHeight=124.0f;
            item.isShowAccessory=NO;
            [group.items addObject:item];
        }
        group.headTitle= @"  执业信息填写";
        [_array addObject:group];
    }
    
    
    
}
#pragma mark ————— 设置SDWebImage认证token —————
-(void)SDWebImageAuth{
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    NSLog(@"%@",help_userManager.oathInfo.access_token);
    [SDWebImageManager.sharedManager.imageDownloader setValue:token forHTTPHeaderField:@"Authorization"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
