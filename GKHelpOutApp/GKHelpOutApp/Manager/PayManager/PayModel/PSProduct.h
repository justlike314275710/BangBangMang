//
//  PSProduct.h
//  PrisonService
//
//  Created by calvin on 2018/5/14.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "JSONModel.h"

@protocol PSProduct<NSObject>
@end

@interface PSProduct : JSONModel

@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) CGFloat defaultPrice;
@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, assign) NSInteger quantity;
@property (nonatomic, assign) BOOL selected;

@end
