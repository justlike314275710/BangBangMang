//
//  NTESContentView.m
//  DemoApplication
//
//  Created by chris on 15/11/1.
//  Copyright © 2015年 chris. All rights reserved.
//
#import "UIImage+Image.h"
#import "NTESAttachment.h"
#import "NTESContentView.h"
#import "PSContentManager.h"
#import "PSAdviceDetailsViewController.h"
#import "PSConsultationViewModel.h"
@interface NTESContentView()

@property (strong, nonatomic) UITapGestureRecognizer *tap;

@end
@implementation NTESContentView

- (instancetype)initSessionMessageContentView{
    self = [super initSessionMessageContentView];
    if (self) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:_tap];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:11.f];
//        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _subTitleLabel.font = [UIFont systemFontOfSize:12.f];
        self.postImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:_titleLabel];
        //[self addSubview:_subTitleLabel];
        [self addSubview:_postImageView];
    }
    return self;
}

- (UIImage *)stringToImage:(NSString *)str {
    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *photo = [UIImage imageWithData:imageData ];
    return photo;
}

- (void)refresh:(NIMMessageModel*)data{
    //务必调用super方法
    [super refresh:data];
    NIMCustomObject *object = data.message.messageObject;
    NTESAttachment *attachment = object.attachment;
    
    self.titleLabel.text = attachment.title;
    self.cid = attachment.cid;
    if ([attachment.category isEqualToString:@"财产纠纷"]) {
       [self.postImageView setImage:[UIImage imageNamed:@"咨询图-财务纠纷"]];
    }
    else if ([attachment.category isEqualToString:@"婚姻家庭"]){
       [self.postImageView setImage:[UIImage imageNamed:@"咨询图-婚姻家庭"]];
    }
    else if ([attachment.category isEqualToString:@"交通事故"]){
       [self.postImageView setImage:[UIImage imageNamed:@"咨询图-交通事故"]];
    }
    else if ([attachment.category isEqualToString:@"工伤赔偿"]){
      [self.postImageView setImage:[UIImage imageNamed:@"咨询图-工伤赔偿"]];
    }
    else if ([attachment.category isEqualToString:@"合同纠纷"]){
      [self.postImageView setImage:[UIImage imageNamed:@"咨询图-合同纠纷"]];
    }
    else if ([attachment.category isEqualToString:@"刑事辩护"]){
      [self.postImageView setImage:[UIImage imageNamed:@"咨询图-刑事辩护"]];
    }
    else if ([attachment.category isEqualToString:@"房产纠纷"]){
       [self.postImageView setImage:[UIImage imageNamed:@"咨询图-房产纠纷"]];
    }
    else if ([attachment.category isEqualToString:@"劳动就业"]){
       [self.postImageView setImage:[UIImage imageNamed:@"咨询图-劳动就业"]];
    }
   
   
    if (!self.model.message.isOutgoingMsg) {
        self.titleLabel.textColor = [UIColor blackColor];
        //self.subTitleLabel.textColor = [UIColor blackColor];
    }else{
        self.titleLabel.textColor = [UIColor blackColor];
        //self.subTitleLabel.textColor = [UIColor whiteColor];
    }
    
    [_titleLabel sizeToFit];
    //[_subTitleLabel sizeToFit];
}

- (void)tapGesture:(UITapGestureRecognizer *)recognizer {
     PSConsultationViewModel *viewModel =[[PSConsultationViewModel alloc]init];
    viewModel.adviceId=self.cid;
    PSAdviceDetailsViewController*detailsVc=[[PSAdviceDetailsViewController alloc]initWithViewModel:viewModel];
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] && object != nil) {
        object = [object nextResponder];
    }
    UIViewController *superController = (UIViewController*)object;
    [superController.navigationController pushViewController:detailsVc animated:YES];

}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    CGFloat titleOriginX = 10.f;
//    CGFloat titleOriginY = 10.f;
//    CGFloat subTitleOriginX = (self.frame.size.width  - self.subTitleLabel.frame.size.width) / 2;
//    CGFloat subTitleOriginY = self.frame.size.height  - self.subTitleLabel.frame.size.height - 10.f;
//
//    CGRect frame = self.titleLabel.frame;
//    frame.origin = CGPointMake(titleOriginX, titleOriginY);
//    self.titleLabel.frame = frame;
//
//    frame = self.subTitleLabel.frame;
//    frame.origin = CGPointMake(subTitleOriginX, subTitleOriginY);
//    self.subTitleLabel.frame = frame;
//}

- (UIImage *)chatBubbleImageForState:(UIControlState)state outgoing:(BOOL)outgoing{
    self.postImageView.frame = CGRectMake(10, 10, 38, 38);
    self.titleLabel.frame = CGRectMake(58, 10, 150, 38);
    return [UIImage imageWithColor:[UIColor whiteColor]];
}

@end
