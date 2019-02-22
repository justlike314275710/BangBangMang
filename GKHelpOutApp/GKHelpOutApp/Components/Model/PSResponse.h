//
// 名称：PSResponse
// 注释：接口应答基类
//      提供所有网络应答的基类
// 作者：william zhao
// 日期：2013-09-30
//

#import "JSONModel.h"
/*!
 *  网络应答抽象类
 */
@interface PSResponse : JSONModel

/**
 *  返回状态码
 */
@property (nonatomic, assign) NSInteger code;
/**
 *  返回信息
 */
@property (nonatomic, strong) NSString<Optional> *msg;



@end
