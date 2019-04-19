//
//  PSMessageViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/4/15.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "PSMessageViewController.h"
#import "TLAddMenuView.h"
#import "NTESContactAddFriendViewController.h"
#import "PSPersonCardViewController.h"
@interface PSMessageViewController ()
@property (nonatomic, strong) TLAddMenuView *addMenuView;
@end

@implementation PSMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"消息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :CNavBgFontColor, NSFontAttributeName :[UIFont boldSystemFontOfSize:18]}];
    [self p_loadUI];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.addMenuView.isShow) {
        [self.addMenuView dismiss];
    }
}

- (void)p_loadUI{
    [self createRightBarButtonItemWithTarget:self action:@selector(showAddMemuView) normalImage:[UIImage imageNamed:@"添加"] highlightedImage:nil];
    
}

-(void)showAddMemuView{
    if (self.addMenuView.isShow) {
        [self.addMenuView dismiss];
    }
    else {
        [self.addMenuView showInView:self.navigationController.view];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (TLAddMenuView *)addMenuView
{
    if (!_addMenuView) {
        _addMenuView = [[TLAddMenuView alloc] init];
        @weakify(self);
        [_addMenuView setItemSelectedAction:^(TLAddMenuView *addMenuView, TLAddMenuItem *item) {
            @strongify(self);
            if (item.className.length > 0) {
//                id vc = [[NSClassFromString(item.className) alloc] init];
//                PushVC(vc);
               NTESContactAddFriendViewController*vc = [[NTESContactAddFriendViewController alloc] initWithNibName:nil bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
                
                
            }
            else {
                [PSAlertView showWithTitle:item.title message:@"功能暂未实现" messageAlignment:NSTextAlignmentCenter image:nil handler:^(PSAlertView *alertView, NSInteger buttonIndex) {
                    
                } buttonTitles:@"确定", nil];
               
            }
        }];
    }
    return _addMenuView;
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
