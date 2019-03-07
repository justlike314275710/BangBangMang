//
//  LawyerCertificationViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/2/25.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "LawyerCertificationViewController.h"
#import "DSSettingDataSource.h"

@interface LawyerCertificationViewController ()<DSSettingCellProtocol>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) DSSettingDataSource *dataSource;

@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation LawyerCertificationViewController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  - LifeCycle
- (void)viewDidLoad {
    self.title=@"专家入驻——法律咨询师";
    [super viewDidLoad];
    _array = [[NSMutableArray alloc] init];
    //[self setData];
    [self setupUI];
    // Do any additional setup after loading the view.
}
#pragma mark  - Notification

#pragma mark  - Event

#pragma mark  - Data
/*
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
            
            DSSettingItem*item=[DSSettingItem itemWithtype:DSSettingItemTypeCustom cellClassName:@"PersonTableViewCell"];
            item.isShowAccessory=NO;
            item.rowHeight=104.0f;
            [group.items addObject:item];
            
        }
        
        group.headTitle = @"律师信息填写";
        
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
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeCustom cellClassName:@"CertificateTableViewCell"];
            item.rowHeight=94.0f;
            item.isShowAccessory=NO;
            [group.items addObject:item];
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeCustom cellClassName:@"AssessmentTableViewCell"];
            
            item.rowHeight=94.0f;
            item.isShowAccessory=NO;
            [group.items addObject:item];
        }
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeCustom cellClassName:@"IdCardTableViewCell"];
            item.rowHeight=150.0f;
            item.isShowAccessory=NO;
            [group.items addObject:item];
        }
        
        {
            DSSettingItem *item = [DSSettingItem itemWithtype:DSSettingItemTypeCustom cellClassName:@"LawyerAuthenticationTableViewCell"];
            item.rowHeight=94.0f;
            item.isShowAccessory=NO;
            [group.items addObject:item];
        }
        group.headTitle= @"执业信息填写";
        [_array addObject:group];
    }
    
    
    self.dataSource = [[DSSettingDataSource alloc] initWithItems:_array];
    
    
}
 */
#pragma mark  - UITableViewDelegate


#pragma mark  - UI
- (void)setupUI {
    
    //self.view.bounds
    CGRect frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight=30.0f;
    self.tableView.sectionFooterHeight=0.01f;
    [self.view addSubview:self.tableView];
    
    UILabel *headView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    headView.backgroundColor = [UIColor colorWithRed:255/255.0 green:246/255.0 blue:233/255.0 alpha:1.0];
    headView.text = @"未认证，请填写资料申请认证.\n此认证信息仅用于平台审核，我们将对你填写对内容严格保密";
    headView.textColor=[UIColor colorWithRed:182/255.0 green:114/255.0 blue:52/255.0 alpha:1.0];
    headView.numberOfLines=0;
    headView.font = [UIFont boldSystemFontOfSize:11.0f];
    headView.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = headView;
    
}



- (void)refreshData:(DSSettingItem *)item tableView:(UITableView *)tableView{
    
}



#pragma mark  - setter & getter

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
