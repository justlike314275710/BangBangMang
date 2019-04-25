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
#import "NTESSessionUtil.h"
@interface PSMessageViewController ()
@property (nonatomic, strong) TLAddMenuView *addMenuView;
@property (nonatomic , strong) UIView *NavView;//导航栏 ;
@end

@implementation PSMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"消息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :CNavBgFontColor, NSFontAttributeName :[UIFont boldSystemFontOfSize:18]}];
    [self p_loadUI];
     //[self.view addSubview:self.emptyTipLabel];

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



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.supportsForceTouch) {
//        id<UIViewControllerPreviewing> preview = [self registerForPreviewingWithDelegate:self sourceView:cell];
//        [self.previews setObject:preview forKey:@(indexPath.row)];
//    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.supportsForceTouch) {
//        id<UIViewControllerPreviewing> preview = [self.previews objectForKey:@(indexPath.row)];
//        [self unregisterForPreviewingWithContext:preview];
//        [self.previews removeObjectForKey:@(indexPath.row)];
//    }
}


- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)context viewControllerForLocation:(CGPoint)point {
//    UITableViewCell *touchCell = (UITableViewCell *)context.sourceView;
//    if ([touchCell isKindOfClass:[UITableViewCell class]]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:touchCell];
//        NIMRecentSession *recent = self.recentSessions[indexPath.row];
//        NTESSessionPeekNavigationViewController *nav = [NTESSessionPeekNavigationViewController instance:recent.session];
//        return nav;
//    }
    return nil;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
//    UITableViewCell *touchCell = (UITableViewCell *)previewingContext.sourceView;
//    if ([touchCell isKindOfClass:[UITableViewCell class]]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:touchCell];
//        NIMRecentSession *recent = self.recentSessions[indexPath.row];
//        NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:recent.session];
//        [self.navigationController showViewController:vc sender:nil];
//    }
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NIMRecentSession *recentSession = weakSelf.recentSessions[indexPath.row];
        [weakSelf onDeleteRecentAtIndexPath:recentSession atIndexPath:indexPath];
        [tableView setEditing:NO animated:YES];
    }];
    
    
//    NIMRecentSession *recentSession = weakSelf.recentSessions[indexPath.row];
//    BOOL isTop = [NTESSessionUtil recentSessionIsMark:recentSession type:NTESRecentSessionMarkTypeTop];
//    UITableViewRowAction *top = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:isTop?@"取消置顶":@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        [weakSelf onTopRecentAtIndexPath:recentSession atIndexPath:indexPath isTop:isTop];
//        [tableView setEditing:NO animated:YES];
//    }];
    
    return @[delete];
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    // All tasks are handled by blocks defined in editActionsForRowAtIndexPath, however iOS8 requires this method to enable editing
}

- (void)onDeleteRecentAtIndexPath:(NIMRecentSession *)recent atIndexPath:(NSIndexPath *)indexPath
{
    id<NIMConversationManager> manager = [[NIMSDK sharedSDK] conversationManager];
    [manager deleteRecentSession:recent];
}

- (void)onTopRecentAtIndexPath:(NIMRecentSession *)recent
                   atIndexPath:(NSIndexPath *)indexPath
                         isTop:(BOOL)isTop
{
    if (isTop)
    {
        [NTESSessionUtil removeRecentSessionMark:recent.session type:NTESRecentSessionMarkTypeTop];
    }
    else
    {
        [NTESSessionUtil addRecentSessionMark:recent.session type:NTESRecentSessionMarkTypeTop];
    }
    self.recentSessions = [self customSortRecents:self.recentSessions];
    [self.tableView reloadData];
}


#pragma mark -- get
- (UILabel *)emptyTipLabel{
    if (!_emptyTipLabel) {
        _emptyTipLabel = [[UILabel alloc] init];
        _emptyTipLabel.text = @"还没有会话，在通讯录中找个人聊聊吧";
        [_emptyTipLabel sizeToFit];
        _emptyTipLabel.textColor = AppBaseTextColor1;
        _emptyTipLabel.hidden = self.recentSessions.count;
        _emptyTipLabel.centerX = self.view.width * .5f;
        _emptyTipLabel.centerY = (self.view.height-44-64) * .5f;
    }
    return _emptyTipLabel;
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
