//
//  NSString+Utils.h
//  Common
//
//  Created by calvin on 14-4-2.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, STUserLevelType) {
    STUserLevelTypeStar,
    STUserLevelTypeMoon,
    STUserLevelTypeSun,
    STUserLevelTypeCyanDiamond,
    STUserLevelTypeBlueDiamond,
    STUserLevelTypePurpleDiamond,
    STUserLevelTypeCrownOne, //皇冠
    STUserLevelTypeCrownTwo,
    STUserLevelTypeCrownThree
};

@interface NSString (Utils)

- (NSString*)encodeAsURIComponent;
- (NSString*)escapeHTML;
- (NSString*)unescapeHTML;
+ (NSString*)localizedString:(NSString*)key;
+ (NSString*)base64encode:(NSString*)str;
+ (NSString *)dateWithTimeInterval:(NSTimeInterval)timeInterval formatter:(NSString *)formatter;
+ (NSString *)dateWithDate:(NSDate *)date formatter:(NSString *)formatter;
+(NSString *) timeChange:(NSString *)timeString;
/**
 *  时间显示逻辑
 *
 *  @param needFormatDate 待转换时间
 *
 */
+ (NSString *)customFormateDateStringFromDate:(NSDate *)needFormatDate;

/**
 * 全局红包活动时间显示逻辑
 */
+ (NSString *)globalRedPackFormateDateStringFromDate:(NSDate *)actDate;

- (NSString *)flattenHTMLWithImgStyle;
- (NSString *)flattenHTMLWhiteSpace:(BOOL)trim;
- (NSString *)stringByDecodingHTMLEntitiesInString;
- (NSString *)stringByStrippingHTML;
- (NSString *)stringByStrippingSpace;
- (NSString *)flattenImgHTMLWithWihtString:(NSString *)str;

+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;
+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

+ (NSString*)guid;
/**
 * 编写正编写正则表达式：最多输入50个中文、英文、数字的字符，且不能包含英文标点和特殊符号
 *
 * @return no 合法， yes 非法
*/
+ (BOOL)isLegalInputString:(NSString*)inputString;
- (NSInteger)multiLength;
- (NSString *)subMultiStringToIndex:(NSInteger)index;

//过滤出文本中的话题
- (NSString *)filterTopicString;

- (NSString *)decodePercentEscapeString;

+ (STUserLevelType)getUserLevelTypeWithUserLevel:(NSString *)userlevel;

//身份证正则表达式
+ (BOOL)verifyIDCardNumber:(NSString *)value;

//计算含有emoji表情的字符串长度
+ (CGFloat)getAttributedStringHeightWithString:(NSAttributedString *)string WidthValue:(CGFloat)width;

// 预约祥情的时间处理
+ (NSString *)mothTrunTimestampToDate:(long long)timestamp; // 返回几月几日
+ (NSString *)hourTrunTimestampToDate:(long long)timestamp; // 返回几时几分

- (id)JsonObject;

+ (NSString *)stringWithNumber:(NSUInteger)number;

@end
