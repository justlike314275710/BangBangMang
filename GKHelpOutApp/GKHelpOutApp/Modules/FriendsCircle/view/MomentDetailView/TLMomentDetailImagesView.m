//
//  TLMomentDetailImagesView.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentDetailImagesView.h"

#define     WIDTH_MOMENT_CONTENT       (SCREEN_WIDTH - 80.0f)
#define     SPACE                      4.0

@interface TLMomentDetailImagesView ()



@end

@implementation TLMomentDetailImagesView

- (instancetype)initWithImageSelectedAction:(void (^)(NSArray *images, NSInteger index))imageSelectedAction
{
    if (self = [super initWithFrame:CGRectZero]) {
        self.imageSelectedAction = imageSelectedAction;
    }
    return self;
}

- (void)setImages:(NSArray *)images
{
    [self SDWebImageAuth];
    _images = images;
    [self removeAllSubviews];
    
    if (images.count == 0) {
        return;
    }

    CGFloat imageWidth;
    CGFloat imageHeight;
    if (images.count == 1) {
        imageWidth = WIDTH_MOMENT_CONTENT * 0.6;
        imageHeight = imageWidth * 1.2;
    }
    else {
        imageHeight = imageWidth = (WIDTH_MOMENT_CONTENT - SPACE * 2.0) / 3.0;
    }
    
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < images.count && i < 9; i++) {
        UIButton *imageView;
        if (i < self.imageViews.count) {
            imageView = self.imageViews[i];
        }
        else {
            imageView = [[UIButton alloc] init];
            [imageView.imageView setContentMode:UIViewContentModeScaleAspectFill];
            [imageView setClipsToBounds:YES];
            [imageView setTag:i];
            [imageView addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.imageViews addObject:imageView];
        }

        NSString*url=NSStringFormat(@"%@/files/%@",EmallHostUrl,images[i]);

        [imageView tt_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:IMAGE_NAMED(@"circle_detail")];

        [imageView setFrame:CGRectMake(x, y, imageWidth, imageHeight)];
        [self addSubview:imageView];
        
        if ((i != 0 && images.count != 4 && (i + 1) % 3 == 0) || (images.count == 4 && i == 1)) {
            y += (imageHeight + SPACE);
            x = 0;
        }
        else {
            x += (imageWidth + SPACE);
        }
    }
}

#pragma mark ————— 设置SDWebImage认证token —————
-(void)SDWebImageAuth{
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    NSString*token=NSStringFormat(@"Bearer %@",help_userManager.oathInfo.access_token);
    [SDWebImageManager.sharedManager.imageDownloader setValue:token forHTTPHeaderField:@"Authorization"];
    [SDWebImageManager sharedManager].imageCache.config.maxCacheAge=5*60.0;
    
}

#pragma mark - # Event Response
- (void)buttonClicked:(UIButton *)sender
{
    if (self.imageSelectedAction) {
        self.imageSelectedAction(self.images, sender.tag);
    }
}

-(NSMutableArray *)imageViews {
    if (!_imageViews) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

@end
