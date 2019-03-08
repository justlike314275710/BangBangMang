//
//  FeedloadImgView.m
//  PrisonService
//
//  Created by kky on 2018/12/19.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "FeedloadImgView.h"
#import "FeedLoadItemView.h"



#define loadImgWidth  67
#define closeImgWidth 18
#define itemWidth (67+18/2)
#define spaceX 15

@interface FeedloadImgView ()
@end

@implementation FeedloadImgView

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count {
    self = [super initWithFrame:frame];
    if (self) {
        //整体大小
        [self p_setUI:count];
     }
    return self;
}

- (void)p_setUI:(NSInteger)count {
    int spaceWidth = (self.width-spaceX*2 - itemWidth*count)/(count-1);
    for (int i = 0; i<count;i++) {
        FeedLoadItemView *feedLoadItem = [[FeedLoadItemView alloc] initWithFrame:CGRectMake(spaceX+(spaceWidth+itemWidth)*i,0, itemWidth, itemWidth) type:FeedLoadSelect];
        [self addSubview:feedLoadItem];
        feedLoadItem.tag = 10+i;
        if (i!= 0) {
            feedLoadItem.Type = FeedLoadNone;
        }
        //点击取消
        feedLoadItem.cancelBlock = ^(NSInteger tag) {
            NSInteger index = tag-10;
            if (self.dataString.count >index) {
                //删除图片
                NSArray *ary = [NSArray arrayWithObject:self.dataUrlString];
                NSDictionary *deleDic = @{@"urls":ary};
                /*
                [PSDeleteRequest requestPUTWithURLStr:ImageDeleteUrl paramDic:deleDic finish:^(id  _Nonnull responseObject) {
                    
                } enError:^(NSError * _Nonnull error) {
                    
                }];
                 */
                
                [self.dataString removeObjectAtIndex:index];
                [self.dataUrlString removeObjectAtIndex:index];
                [self p_freshUI:count];

                if (self.feedloadResultBlock) {
                    self.feedloadResultBlock(self.dataUrlString);
                }
            
            }
        };
        //点击选择
        feedLoadItem.selectBlock = ^(NSInteger tag, UIImage *image,NSString *url) {
            [self.dataString addObject:image];
            [self.dataUrlString addObject:url];
            [self p_freshUI:count];
            if (self.feedloadResultBlock) {
                self.feedloadResultBlock(self.dataUrlString);
            }

        };
        
    }
}

- (void)p_freshUI:(NSInteger)count {
    NSInteger tag = self.dataString.count;
    for (int i = 0; i<count; i++) {
        FeedLoadItemView *feedLoadItem = (FeedLoadItemView *)[self viewWithTag:i+10];
        if (i<tag) {
            feedLoadItem.Type = FeedloadIng;
            feedLoadItem.upLoadimage = self.dataString[i];
            //浏览图片
            /*
            feedLoadItem.browserBlock = ^(UIImageView *imgV, NSInteger tag) {
                [HUPhotoBrowser showFromImageView:imgV withImages:self.dataString atIndex:i];
            };
             */
            
        } else if (i==tag) {
            feedLoadItem.Type = FeedLoadSelect;
        } else {
            feedLoadItem.Type = FeedLoadNone;
        }
    }
}

-(NSMutableArray *)dataString {
    if (!_dataString) {
        _dataString = [NSMutableArray array];
    }
    return _dataString;
}

- (NSMutableArray *)dataUrlString {
    if (!_dataUrlString) {
        _dataUrlString = [NSMutableArray array];
    }
    return _dataUrlString;
}

- (void)cancelImg:(UIImageView *)sender {
    
}

- (void)handlePickerImage:(UIImage *)image {
    
}




@end
