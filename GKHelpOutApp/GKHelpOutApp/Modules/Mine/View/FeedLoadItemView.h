//
//  FeedLoadItemView.h
//  PrisonService
//
//  Created by kky on 2018/12/19.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectBlock)(NSInteger tag,UIImage *image,NSString*url);
typedef void (^CancelBlock)(NSInteger tag);
typedef void (^BrowserBlock)(UIImageView *imgV ,NSInteger tag); //浏览图片

typedef NS_ENUM(NSInteger, FeedLoadType) {
    FeedLoadSelect,  //选择图片状态
    FeedLoadNone,    //没有图片状态
    FeedloadIng,     //加载图片状态
};

@interface FeedLoadItemView : UIView

@property(nonatomic,copy)SelectBlock selectBlock;
@property(nonatomic,copy)CancelBlock cancelBlock;
@property(nonatomic,copy)BrowserBlock browserBlock;
@property(nonatomic,assign) FeedLoadType Type;
@property(nonatomic,strong) UIImage *upLoadimage;

- (instancetype)initWithFrame:(CGRect)frame type:(FeedLoadType)type;

@end

