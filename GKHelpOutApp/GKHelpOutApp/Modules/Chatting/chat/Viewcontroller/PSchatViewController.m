//
//  PSchatViewController.m
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/11/13.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSchatViewController.h"

#import "NIMKit.h"
@interface PSchatViewController ()

@end

@implementation PSchatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会话";
    UIButton*backButton=[[UIButton alloc]init];
    [backButton setFrame:CGRectMake(5, 5, 14, 14)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"universalBackIcon"] forState:UIControlStateNormal];
     [backButton addTarget:self action:@selector(p_popViewcontroller) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = barButton;
  
   
   // [self changeOrientation:UIInterfaceOrientationPortrait];


    // Do any additional setup after loading the view.
}

-(void)p_popViewcontroller{
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)onSelectedRecent:(NIMRecentSession *)recent
//             atIndexPath:(NSIndexPath *)indexPath
//{
//    NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:recent.session];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//- (void)addSession
//{
//    NTESContactViewController *vc = [[NTESContactViewController alloc] initWithNibName:nil bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
//}
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
