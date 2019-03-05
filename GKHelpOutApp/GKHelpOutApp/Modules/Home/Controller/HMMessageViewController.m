//
//  HMMessageViewController.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/4.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "HMMessageViewController.h"
#import "HMMessageCellTableViewCell.h"

@interface HMMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    [self setupUI];
}
#pragma mark - PrivateMethods
-(void)setupUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight-kTabBarHeight-kStatusBarHeight) style:UITableViewStylePlain];
    [self.tableView registerClass:[HMMessageCellTableViewCell class] forCellReuseIdentifier:@"HMMessageCellTableViewCell"];
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - Delegate
//MARK:UITableViewDataSource&UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HMMessageCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HMMessageCellTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}



@end
