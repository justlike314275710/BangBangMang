//
//  Mine_addressViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "Mine_addressViewController.h"
#import "BRPickerView.h"
#import "Mine_AuthLogic.h"
@interface Mine_addressViewController ()<UITextViewDelegate>
@property (nonatomic , strong) UIButton*cityBtn;
@property (nonatomic , strong) UITextView *streetView;
@property (nonatomic , strong) Mine_AuthLogic *authLogic;

//@property (nonatomic , strong) NSString *countyCode;
//@property (nonatomic , strong) NSString *countyName;//国家
@property (nonatomic , strong) NSString *countryCode;
@property (nonatomic , strong) NSString *countryName;//区 开福区
@property (nonatomic , strong) NSString *provinceCode;
@property (nonatomic , strong) NSString *provinceName;//省份
@property (nonatomic , strong) NSString *cityCode;
@property (nonatomic , strong) NSString *cityName;//市
@property (nonatomic , strong) NSString *streetDetail;//街道


@end

@implementation Mine_addressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.authLogic=[Mine_AuthLogic new];
    [self setUI];
    [self setIsShowLiftBack:YES];
    self.title=@"律师会所";
    // Do any additional setup after loading the view.
}

-(void)setUI{
    
    CGFloat sidding=15.0f;
    [self addNavigationItemWithTitles:@[@"保存"] isLeft:NO target:self action:@selector(SureAction) tags:nil];
    
    self.cityBtn=[UIButton new];
    [self.view addSubview:_cityBtn];
    [_cityBtn setBackgroundColor:[UIColor whiteColor]];
    [_cityBtn setTitle:@"  所在地区" forState:0];
    [_cityBtn setTitleColor:[UIColor blackColor] forState:0];
    _cityBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    _cityBtn .titleLabel.font=FontOfSize(12);
    _cityBtn.frame=CGRectMake(sidding, sidding, SCREEN_WIDTH-2*sidding, 40);
    [_cityBtn bk_whenTapped:^{
        NSArray *defaultSelArr = [self.cityBtn.titleLabel.text componentsSeparatedByString:@" "];
        // NSArray *dataSource = [weakSelf getAddressDataSource];  //从外部传入地区数据源
        NSArray *dataSource = nil; // dataSource 为空时，就默认使用框架内部提供的数据源（即 BRCity.plist）
        [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataSource defaultSelected:defaultSelArr isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {

            [self.cityBtn setTitle:[NSString stringWithFormat:@"  %@ %@ %@", province.name, city.name, area.name] forState:0];
            
            self.provinceCode=province.code;
            self.provinceName=province.name;
            self.cityCode=city.code;
            self.cityName=city.name;
            self.countryName=area.name;
            self.countryCode=area.code;
            
            NSLog(@"省[%@]：%@，%@", @(province.index), province.code, province.name);
            NSLog(@"市[%@]：%@，%@", @(city.index), city.code, city.name);
            NSLog(@"区[%@]：%@，%@", @(area.index), area.code, area.name);
            NSLog(@"--------------------");
        } cancelBlock:^{
            NSLog(@"点击了背景视图或取消按钮");
        }];
    }];
    
    
    UIImageView*arrow=[[UIImageView alloc]init];
    arrow.frame=CGRectMake(SCREEN_WIDTH-3*sidding, 14, 9, 12);
    [arrow setImage:[UIImage imageNamed:@"myarrow_icon"]];
    [_cityBtn addSubview:arrow];
    
    
    
    self.streetView=[[UITextView alloc]init];
    self.streetView.frame=CGRectMake(sidding, _cityBtn.bottom+sidding, SCREEN_WIDTH-2*sidding, 60);
    [self.view addSubview:_streetView];
    _streetView.placeholder=@"请输入地址";
    self.streetView.delegate=self;
  
    if ( ValidDict(self.authLogic.lawOfficeAddress)) {
      
    }
}

-(void)SureAction{
    if (self.cityName.length==0) {
        [PSTipsView showTips:@"请选择所在地区"];
        return;
    }
     if (self.streetDetail.length==0)
    {
        [PSTipsView showTips:@"请输入详细地址"];
        return;
    }
    NSDictionary*addressDic=[[NSDictionary alloc]init];
    addressDic=@{@"countyCode":@"86",@"countyName":@"中国",@"countryCode":self.countryCode,@"countryName":self.countryName,@"provinceCode":self.provinceCode,@"provinceName":self.provinceName,@"cityCode":self.cityCode,@"cityName":self.cityName,@"streetDetail":self.streetDetail};
    //self.authLogic.lawOfficeAddress=addressDic;

    __weak typeof(self) weakself = self;
    if (weakself.returnValueBlock) {
        weakself.returnValueBlock(addressDic);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.streetDetail=textView.text;
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
