//
//  TestResultTableViewController.m
//  SUNSearchController
//
//  Created by Michael on 16/6/14.
//  Copyright © 2016年 com.51fanxing.searchController. All rights reserved.
//

#import "TestResultTableViewController.h"
//#import "Product.h"
//#import "TestDetailViewController.h"

@implementation TestResultTableViewController

-(void)viewDidLoad）{
    [super viewDidLoad];
    self.tableView.separatorStyle=NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.01;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.01;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        // 设置选中样式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        
    }

    cell.textLabel.text = self.searchResults[0];
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
    
}

- (void)setSearchResults:(NSMutableArray *)searchResults
{
    _searchResults = searchResults;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
  //  TestDetailViewController *detail = [[TestDetailViewController alloc] init];
  //  [self.presentingViewController.navigationController pushViewController:detail animated:YES];
}


@end
