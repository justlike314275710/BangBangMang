//
//  LawyerCertificationViewController.m
//  GKHelpOutApp
//
//  Created by 狂生烈徒 on 2019/2/25.
//  Copyright © 2019年 kky. All rights reserved.
//

#import "LawyerCertificationViewController.h"

@interface LawyerCertificationViewController ()
@property (nonatomic , strong) UIScrollView *scrollView;
@end

@implementation LawyerCertificationViewController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}
#pragma mark  - Notification

#pragma mark  - Event

#pragma mark  - Data

#pragma mark  - UITableViewDelegate


#pragma mark  - UI
-(void)setupUI{
    [self.view addSubview:self.scrollView];
}
#pragma mark  - setter & getter
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, KScreenWidth, KScreenHeight*2)];
        _scrollView.backgroundColor = CViewBgColor;
    }
    return _scrollView;}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
