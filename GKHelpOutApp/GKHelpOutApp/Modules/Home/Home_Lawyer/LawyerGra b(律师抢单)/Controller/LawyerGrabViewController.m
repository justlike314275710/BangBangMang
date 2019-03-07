//
//  LawyerGrabViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "LawyerGrabViewController.h"
#import "PSLawyerView.h"
#import "LegalAdviceCell.h"
#import "lawyerGrab_Logic.h"
@interface LawyerGrabViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *LawyersTableview;
@property (nonatomic , strong) PSLawyerView *headerView;
@end

@implementation LawyerGrabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderContents];
    [self refreshData];
    // Do any additional setup after loading the view.
}
- (void)refreshData {
    lawyerGrab_Logic*logic=[[lawyerGrab_Logic alloc]init];
    [logic refreshLawyerAdviceCompleted:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
}


-(void)renderContents{
    self.view.backgroundColor=UIColorFromRGBA(248, 247, 254, 1);
    self.headerView=[PSLawyerView new];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(110);
    }];
    
    
    self.LawyersTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.LawyersTableview.showsVerticalScrollIndicator=NO;
    self.LawyersTableview.dataSource = self;
    self.LawyersTableview.delegate = self;
    self.LawyersTableview.tableFooterView = [UIView new];
    [self.LawyersTableview  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.LawyersTableview registerClass:[LegalAdviceCell class] forCellReuseIdentifier:@"LegalAdviceCell"];
    [self.view addSubview:self.LawyersTableview];
    [self.LawyersTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(140);
        make.height.mas_equalTo(400);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    LegalAdviceCell*cell=[tableView dequeueReusableCellWithIdentifier:@"LegalAdviceCell"];
    //    PSMyAdviceTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PSMyAdviceTableViewCell"];

    return cell;
    
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
