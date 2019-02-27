//
//  LegaladviceViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/2/26.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "LegaladviceViewController.h"
#import "LegalAdviceCell.h"

@interface LegaladviceViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LegaladviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"法律咨询";
    [self setupUI];
}

#pragma mark - PrivateMethosd
- (void)setupUI {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LegalAdviceCell class] forCellReuseIdentifier:@"LegalAdviceCellID"];
}

#pragma mark - Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LegalAdviceCell *cell = [[LegalAdviceCell alloc] init];
    if (indexPath.row== 0) {
        cell.noRead = YES;
    } else {
        cell.noRead = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
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
