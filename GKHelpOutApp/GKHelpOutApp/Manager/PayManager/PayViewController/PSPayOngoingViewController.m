//
//  PSPayOngoingViewController.m
//  PrisonService
//
//  Created by calvin on 2018/4/23.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSPayOngoingViewController.h"

@interface PSPayOngoingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *paymentTableView;

@end

@implementation PSPayOngoingViewController

- (IBAction)actionOfLeftItem:(id)sender {
    if (self.closeAction) {
        self.closeAction();
    }
}

- (void)renderContents {
    //[self isHidenNaviBar];
    UILabel *topTitleLabel = [UILabel new];
    topTitleLabel.font = FontOfSize(15);
    topTitleLabel.textColor = AppBaseTextColor1;
    topTitleLabel.textAlignment = NSTextAlignmentCenter;
    topTitleLabel.text = @"选择支付方式";
    [self.view addSubview:topTitleLabel];
    [topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(44);
    }];
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"universalCloseIcon"] forState:UIControlStateNormal];
    closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    @weakify(self)
    [closeButton bk_whenTapped:^{
        @strongify(self)
        if (self.closeAction) {
            self.closeAction();
        }
    }];
    [self.view addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(topTitleLabel.mas_top);
        make.bottom.mas_equalTo(topTitleLabel.mas_bottom);
        make.width.mas_equalTo(40);
    }];
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.titleLabel.font = FontOfSize(15);
    [payButton setTitleColor:UIColorFromHexadecimalRGB(0xff8a07) forState:UIControlStateNormal];
    [payButton setTitle:@"去支付" forState:UIControlStateNormal];
    payButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [payButton bk_whenTapped:^{
        @strongify(self)
        if (self.goPay) {
            self.goPay();
        }
    }];
    [self.view addSubview:payButton];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(topTitleLabel.mas_top);
        make.bottom.mas_equalTo(topTitleLabel.mas_bottom);
        make.width.mas_equalTo(60);
    }];
    UIView *topBgView = [UIView new];
    topBgView.backgroundColor = UIColorFromHexadecimalRGB(0xf7f7f7);
    [self.view addSubview:topBgView];
    [topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(topTitleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(100);
    }];
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = FontOfSize(12);
    titleLabel.textColor = UIColorFromHexadecimalRGB(0x5b5b5b);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"本次订单需要支付";
    [topBgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(24);
        make.height.mas_equalTo(13);
    }];
    UILabel *amountLabel = [UILabel new];
    amountLabel.font = FontOfSize(35);
    amountLabel.textColor = UIColorFromHexadecimalRGB(0x5b5b5b);
    amountLabel.textAlignment = NSTextAlignmentCenter;
    CGFloat amount = 0;
    if (self.getAmount) {
        amount = self.getAmount();
    }
    amountLabel.text = [NSString stringWithFormat:@"¥%.2f",amount];
    [topBgView addSubview:amountLabel];
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    self.paymentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.paymentTableView.backgroundColor = [UIColor clearColor];
    self.paymentTableView.dataSource = self;
    self.paymentTableView.delegate = self;
    self.paymentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.paymentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    self.paymentTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.paymentTableView];
    [self.paymentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topBgView.mas_left);
        make.right.mas_equalTo(topBgView.mas_right);
        make.top.mas_equalTo(topBgView.mas_bottom).offset(20);
        make.bottom.mas_equalTo(-15);
    }];
}

- (BOOL)fd_interactivePopDisabled {
    return YES;
}

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (BOOL)isHidenNaviBar{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.view.backgroundColor = [UIColor clearColor];
    [self renderContents];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    if (self.getRows) {
        rows = self.getRows();
    }
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = FontOfSize(14);
    cell.textLabel.textColor = UIColorFromHexadecimalRGB(0x2d2d2d);
    UIImage *icon = nil;
    if (self.getIcon) {
        icon = self.getIcon(indexPath.row);
    }
    cell.imageView.image = icon;
    NSString *name = nil;
    if (self.getName) {
        name = self.getName(indexPath.row);
    }
    cell.textLabel.text = name;
    NSInteger selectedIndex = -1;
    if (self.getSelectedIndex) {
        selectedIndex = self.getSelectedIndex();
    }
    UIImage *accessoryImage = indexPath.row == selectedIndex ? [UIImage imageNamed:@"appointmentPaymentSelected"] : [UIImage imageNamed:@"appointmentPaymentNormal"];
    cell.accessoryView = [[UIImageView alloc] initWithImage:accessoryImage];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.getSelectedIndex) {
        NSInteger index = self.getSelectedIndex();
        if (indexPath.row != index) {
            if (self.seletedPayment) {
                self.seletedPayment(indexPath.row);
            }
            [tableView reloadData];
        }
    }
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
