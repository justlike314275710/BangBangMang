//
//  PSViewModelService.h
//  PrisonService
//
//  Created by calvin on 2018/4/2.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSResponse.h"

//typedef NS_ENUM(NSInteger, PSDataStatus) {
//    PSDataInitial = 0, //类刚刚初始化，还未获取数据
//    PSDataError,       //接口获取数据失败
//    PSDataEmpty,       //接口正常返回无数据
//    PSDataNormal       //接口返回有正常数据
//};




@protocol PSViewModelService <NSObject>

@optional
@property (nonatomic, assign) PSDataStatus dataStatus;

- (void)fetchDataWithParams:(id)params completed:(RequestDataCompleted)completedCallback failed:(RequestDataFailed)failedCallback;
- (void)checkDataWithCallback:(CheckDataCallback)callback;

@end
