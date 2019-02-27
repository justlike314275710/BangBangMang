//
//  LawyerAuthenticationCViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/2/27.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "LawyerAuthenticationCViewController.h"
#import "CertificateTableViewCell.h"
#import "AuthItem.h"
#import "AuthGroupItem.h"
@interface LawyerAuthenticationCViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)  UITableView* authenticationTab;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LawyerAuthenticationCViewController



#pragma mark  - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setData];
    // Do any additional setup after loading the view.
}
#pragma mark  - Notification

#pragma mark  - Event

#pragma mark  - Data
- (void)setData {
    [self.dataSource removeAllObjects];
    {
    AuthGroupItem*group=[[AuthGroupItem alloc]init];
        {
        AuthItem*item=[[AuthItem alloc]init];
        item.title=@"个人简介1";
        [group.items addObject:item];
            
        }
        {
            AuthItem*item=[[AuthItem alloc]init];
            item.title=@"个人简介2";
            [group.items addObject:item];
            
        }
        {
            AuthItem*item=[[AuthItem alloc]init];
            item.title=@"个人简介3";
            [group.items addObject:item];
            
        }
        {
            AuthItem*item=[[AuthItem alloc]init];
            item.title=@"个人简介4";
            [group.items addObject:item];
            
        }
        [self.dataSource addObject:group];
    }
    
    {
        AuthGroupItem*group=[[AuthGroupItem alloc]init];
        {
            AuthItem*item=[[AuthItem alloc]init];
            item.title=@"个人简介11";
            [group.items addObject:item];
            
        }
        {
            AuthItem*item=[[AuthItem alloc]init];
            item.title=@"个人简介22";
            [group.items addObject:item];
            
        }
        {
            AuthItem*item=[[AuthItem alloc]init];
            item.title=@"个人简介33";
            [group.items addObject:item];
            
        }
        {
            AuthItem*item=[[AuthItem alloc]init];
            item.title=@"个人简介44";
            [group.items addObject:item];
            
        }
        [self.dataSource addObject:group];
    }
    [self.authenticationTab reloadData];
}
#pragma mark  - UITableViewDelegate


#pragma mark  - UI
- (void)setupUI {
    
    //self.view.bounds
    CGRect frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60);
    self.authenticationTab = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    self.authenticationTab.dataSource = self;
    self.authenticationTab.delegate = self;
    self.authenticationTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.authenticationTab.sectionHeaderHeight=30.0f;
    self.authenticationTab.sectionFooterHeight=0.01f;
    [self.view addSubview:self.authenticationTab];
    
    [self.authenticationTab registerClass:[CertificateTableViewCell class] forCellReuseIdentifier:@"CertificateTableViewCell"];
    
    UILabel *headView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    headView.backgroundColor = [UIColor colorWithRed:255/255.0 green:246/255.0 blue:233/255.0 alpha:1.0];
    headView.text = @"未认证，请填写资料申请认证.\n此认证信息仅用于平台审核，我们将对你填写对内容严格保密";
    headView.textColor=[UIColor colorWithRed:182/255.0 green:114/255.0 blue:52/255.0 alpha:1.0];
    headView.numberOfLines=0;
    headView.font = [UIFont boldSystemFontOfSize:11.0f];
    headView.textAlignment = NSTextAlignmentCenter;
    self.authenticationTab.tableHeaderView = headView;
    
}


#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self itemCountAtIndexPath:section tableView:tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.style == UITableViewStyleGrouped) {
        return self.dataSource.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   

    CertificateTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"CertificateTableViewCell"];

    return cell;
}


#pragma mark --- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}



-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view    forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    //header.contentView.backgroundColor= [UIColor whiteColor];
    header.textLabel.textColor=[UIColor colorWithRed:81/255.0 green:89/255.0 blue:162/255.0 alpha:1.0];
    [header.textLabel setFont:[UIFont systemFontOfSize:11]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    AuthGroupItem*group=self.dataSource[indexPath.section];
    AuthItem*item=group.items[indexPath.row];
    return item.rowHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.style == UITableViewStyleGrouped) {
        AuthGroupItem*group=self.dataSource[section];
        return group.headTitle;
    }
    return nil;
}


//每个组里cell的数量
- (NSInteger)itemCountAtIndexPath:(NSInteger)section tableView:(UITableView *)tableView {
    if (tableView.style == UITableViewStyleGrouped) {
        AuthGroupItem*group=self.dataSource[section];
        return group.items.count;
    } else {
        return self.dataSource.count;
    }
}




#pragma mark  - setter & getter
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
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
