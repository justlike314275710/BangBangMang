//
//  FeedbackTypeModel.h
//  PrisonService
//
//  Created by kky on 2018/12/26.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol FeedbackTypeModel <NSObject>

@end

NS_ASSUME_NONNULL_BEGIN

@interface FeedbackTypeModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *type;
@property (nonatomic, strong) NSString<Optional> *desc;

@property (nonatomic, strong) NSString<Optional> *content; //投诉内容
@property (nonatomic, strong) NSString<Optional> *contents; //监狱投诉内容
@property (nonatomic, strong) NSString<Optional> *familyId;
@property (nonatomic, strong) NSString<Optional> *createdAt; //日期
@property (nonatomic, strong) NSString<Optional> *updatedAt;
@property (nonatomic, strong) NSString<Optional> *phone;
@property (nonatomic, strong) NSString<Optional> *uuid;
@property (nonatomic, strong) NSString<Optional> *relationship;
@property (nonatomic, strong) NSString<Optional> *jailId;
@property (nonatomic, strong) NSString<Optional> *idCardFront;
@property (nonatomic, strong) NSString<Optional> *idCardBack;
@property (nonatomic, strong) NSString<Optional> *typeId;
@property (nonatomic, strong) NSString<Optional> *typeName;
@property (nonatomic, strong) NSString<Optional> *imageUrls;
@property (nonatomic, strong) NSString<Optional> *isReply;
@property (nonatomic, strong) NSString<Optional> *reply;
@property (nonatomic, strong) NSString<Optional> *replyAt;
@property (nonatomic, strong) NSString<Optional> *answer;
@property (nonatomic, strong) NSString<Optional> *writefeedType;
@property (nonatomic, strong) NSString<Optional> *title;



@end

NS_ASSUME_NONNULL_END
