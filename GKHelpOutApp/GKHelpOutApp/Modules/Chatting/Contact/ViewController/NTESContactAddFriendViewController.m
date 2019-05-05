//
//  NTESContactAddFriendViewController.m
//  NIM
//
//  Created by chris on 15/8/18.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NTESContactAddFriendViewController.h"
#import "NIMCommonTableDelegate.h"
#import "NIMCommonTableData.h"
#import "UIView+Toast.h"

#import "NTESPersonalCardViewController.h"
#import "NTESAddFriendsMessageViewController.h"
#import "PSPersonCardViewController.h"
#import "TestResultTableViewController.h"

@interface NTESContactAddFriendViewController ()<UISearchBarDelegate,UISearchResultsUpdating>

@property (nonatomic,strong) NIMCommonTableDelegate *delegator;

@property (nonatomic,copy  ) NSArray                 *data;

@property (nonatomic,assign) NSInteger               inputLimit;

@property (nonatomic, strong) UISearchController *searchController;


@end

@implementation NTESContactAddFriendViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加好友";
   
    __weak typeof(self) wself = self;
    //[self buildData];
    self.delegator = [[NIMCommonTableDelegate alloc] initWithTableData:^NSArray *{
        return wself.data;
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor =[UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate   = self.delegator;
    self.tableView.dataSource = self.delegator;
    self.tableView.separatorStyle=NO;
    
    
  
    TestResultTableViewController *result = [[TestResultTableViewController alloc] init];
    result.view.frame = CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:result];

    self.searchController.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.placeholder = @"手机号";
    //self.searchController.searchBar.barTintColor=[UIColor groupTableViewBackgroundColor];
    self.searchController.searchBar.barTintColor = [UIColor groupTableViewBackgroundColor];
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleDefault;
    self.searchController.searchBar.barStyle = UIBarStyleDefault;
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y+15, self.searchController.searchBar.frame.size.width, 44.0);

    self.searchController.searchBar.backgroundImage=[UIImage new];
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    self.searchController.searchBar.delegate=self;
   
    
  
    
}
#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchController];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    NSString *phone = [[self.searchController.searchBar text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (phone.length) {
        phone= [phone lowercaseString];
        if ([self deptNumInputShouldNumber:phone]) {
            [self IMaddFriend:phone];
        }
        else{
            [PSTipsView showTips:@"请输入正确手机号码!"];
        }
        
    }
    
}

#pragma mark - UISearchControllerDelegate代理



- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"updateSearchResultsForSearchController");

   
    
}

- (void)buildData{
    NSArray *data = @[
                      @{
                          HeaderTitle:@"",
                          RowContent :@[
                                  @{
                                      Title         : @"请输入手机号码",
                                      CellClass     : @"NTESTextSettingCell",
                                      RowHeight     : @(44),
                                      },
                                  ],
                          FooterTitle:@""
                          },
                      ];
    self.data = [NIMCommonTableSection sectionsWithData:data];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *phone = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (phone.length) {
        phone= [phone lowercaseString];
       // [self IMaddFriend:phone];
        
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *phone = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (phone.length) {
        phone= [phone lowercaseString];
        if ([self deptNumInputShouldNumber:phone]) {
             [self IMaddFriend:phone];
        }
        else{
            [PSTipsView showTips:@"请输入正确手机号码"];
        }
       
    }
}

- (BOOL) deptNumInputShouldNumber:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}



-(void)IMaddFriend:(NSString*)phone{
    NSString*url=[NSString stringWithFormat:@"%@%@?phoneNumber=%@",ChatServerUrl,URL_get_customerFriend,phone];
    NSString *access_token =help_userManager.oathInfo.access_token;
    NSString *token = NSStringFormat(@"Bearer %@",access_token);
    [PPNetworkHelper setValue:token forHTTPHeaderField:@"Authorization"];
    [PPNetworkHelper GET:url parameters:nil success:^(id responseObject) {
        if (ValidDict(responseObject)) {
            NSString *userId = [responseObject[@"account"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString*nickName=responseObject[@"name"];
            NSString*avatar=responseObject[@"username"];
            NSString*curUserName=responseObject[@"curUsername"];
            NSString*friendinfo=responseObject[@"friendinfo"];
            NSArray*circleoffriendsPicture=responseObject[@"circleoffriendsPicture"];
            if (userId.length) {
                userId = [userId lowercaseString];
                [self addFriendWithUserID:userId
                                withPhone:phone
                                withNickName:nickName
                                withAvatar:avatar
                                withCurUserName:curUserName
                                withFriendinfo:friendinfo
               withCircleoffriendsPicture:circleoffriendsPicture];
            }
        } else {
           // [PSTipsView showTips:@"该用户不存在"];
            if (self.searchController.searchResultsController) {
                
                TestResultTableViewController *vc = (TestResultTableViewController *)self.searchController.searchResultsController;
                vc.searchResults = @[@"该用户不存在"];
                vc.tableView.separatorStyle=NO;
                vc.tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
                [vc.tableView reloadData];
            }
            
        }
    } failure:^(NSError *error) {
       // [PSTipsView showTips:@"该用户不存在"];
        if (self.searchController.searchResultsController) {
            
            TestResultTableViewController *vc = (TestResultTableViewController *)self.searchController.searchResultsController;
            vc.searchResults = @[@"该用户不存在"];
            vc.tableView.separatorStyle=NO;
             vc.tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
            [vc.tableView reloadData];
        }

    }];
}



#pragma mark - Private
- (void)addFriendWithUserID:(NSString *)userId withPhone:(NSString*)phone withNickName:(NSString*)nickName withAvatar:(NSString*)avatar withCurUserName:(NSString*)curUserName withFriendinfo:(NSString*)friendinfo withCircleoffriendsPicture:(NSArray*)CircleoffriendsPicture{
    __weak typeof(self) wself = self;
    [[PSLoadingView sharedInstance] show];
    [[NIMSDK sharedSDK].userManager fetchUserInfos:@[userId] completion:^(NSArray *users, NSError *error) {
        [[PSLoadingView sharedInstance]dismiss];
        if (users.count) {
            PSPersonCardViewController*vc=[[PSPersonCardViewController alloc]initWithUserId:userId withPhone:phone withNickName:nickName withAvatar:avatar withCurUserName:curUserName withFriendinfo:friendinfo withCircleoffriendsPicture:CircleoffriendsPicture];
            [wself.navigationController pushViewController:vc animated:YES];

        }else{
            if (wself) {
                 [PSTipsView showTips:@"该用户不存在"];
            }
        }
    }];
}



@end
