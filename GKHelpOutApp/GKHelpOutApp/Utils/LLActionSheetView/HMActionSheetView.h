//
//  HMActionSheetView.h
//  GKHelpOutApp
//
//  Created by kky on 2019/3/12.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMActionSheetView;

@protocol HMActionSheetDelegate <NSObject>

- (void)hm_actionSheetView:(HMActionSheetView *)actionSheetView clickButtonAtIndex:(NSInteger )buttonIndex;

@end

@interface HMActionSheetView : UIView

// 支持代理
@property (nonatomic,weak) id <HMActionSheetDelegate> delegate;

// 支持block
@property (nonatomic,copy) void (^ClickIndex) (NSInteger index);

/**
 根据数组进行文字显示,返回index
 @param titleArr 传入显示的数组
 @param show 是否显示取消按钮
 @return return value description
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArr
                     andShowCancel:(BOOL )show;

- (void)show;

@end

