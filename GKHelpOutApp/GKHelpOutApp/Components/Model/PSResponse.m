//
// Created by William Zhao on 13-6-26.
// Copyright (c) 2013 Vipshop Holdings Limited. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PSResponse.h"

@interface PSResponse ()

@property (nonatomic, strong) NSString<Ignore> *jsonString;

@end

@implementation PSResponse

- (instancetype)initWithString:(NSString*)string error:(JSONModelError**)err {
    self = [super initWithString:string error:err];
    if (self) {
        _jsonString = string;
    }
    return self;
}

- (NSString *)description {
    return _jsonString;
}

@end
