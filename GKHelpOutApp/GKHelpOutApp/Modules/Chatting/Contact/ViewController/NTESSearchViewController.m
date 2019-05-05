//
//  NTESSearchViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/5/5.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "NTESSearchViewController.h"

@interface NTESSearchViewController ()<UISearchBarDelegate>
@property(nonatomic,strong)UISearchBar *searchBar;
@end

@implementation NTESSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSearchBar];
    self.title=@"添加好友";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    // Do any additional setup after loading the view.
}
-(void)initSearchBar{
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width, 44)];
    _searchBar.keyboardType = UIKeyboardAppearanceDefault;
    _searchBar.placeholder = @"手机号";
    _searchBar.delegate = self;
    _searchBar.barTintColor = [UIColor whiteColor];
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.barStyle = UIBarStyleDefault;
    [self.view addSubview:_searchBar];
    
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
