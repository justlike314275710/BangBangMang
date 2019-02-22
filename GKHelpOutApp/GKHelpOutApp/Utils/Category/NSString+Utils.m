//
//  NSString+Utils.m
//  Common
//
//  Created by calvin on 14-4-2.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "GTMBase64.h"
#import "NSString+Utils.h"
#import <CoreText/CoreText.h>
#import <CommonCrypto/CommonDigest.h>

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
@implementation NSString (Utils)

- (NSString*)encodeAsURIComponent
{
	const char* p = [self UTF8String];
	NSMutableString* result = [NSMutableString string];
	
	for (;*p ;p++) {
		unsigned char c = *p;
		if (('0' <= c && c <= '9') || ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z') || (c == '-' || c == '_')) {
			[result appendFormat:@"%c", c];
		} else {
			[result appendFormat:@"%%%02X", c];
		}
	}
	return result;
}

+ (NSString*)base64encode:(NSString*)str
{
    if ([str length] == 0)
        return @"";
    
    const char *source = [str UTF8String];
    unsigned long strlength  = strlen(source);
    
    char *characters = malloc(((strlength + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    
    NSUInteger length = 0;
    NSUInteger i = 0;
    
    while (i < strlength) {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < strlength)
            buffer[bufferLength++] = source[i++];
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

- (NSString*)escapeHTML
{
	NSMutableString* s = [NSMutableString string];
	
	unsigned long start = 0;
	unsigned long len = [self length];
	NSCharacterSet* chs = [NSCharacterSet characterSetWithCharactersInString:@"<>&\""];
	
	while (start < len) {
		NSRange r = [self rangeOfCharacterFromSet:chs options:0 range:NSMakeRange(start, len-start)];
		if (r.location == NSNotFound) {
			[s appendString:[self substringFromIndex:start]];
			break;
		}
		
		if (start < r.location) {
			[s appendString:[self substringWithRange:NSMakeRange(start, r.location-start)]];
		}
		
		switch ([self characterAtIndex:r.location]) {
			case '<':
				[s appendString:@"&lt;"];
				break;
			case '>':
				[s appendString:@"&gt;"];
				break;
			case '"':
				[s appendString:@"&quot;"];
				break;
			case '&':
				[s appendString:@"&amp;"];
				break;
		}
		
		start = r.location + 1;
	}
	
	return s;
}

- (NSString*)unescapeHTML
{
	NSMutableString* s = [NSMutableString string];
	NSMutableString* target = [self mutableCopy];
	NSCharacterSet* chs = [NSCharacterSet characterSetWithCharactersInString:@"&"];
	
	while ([target length] > 0) {
		NSRange r = [target rangeOfCharacterFromSet:chs];
		if (r.location == NSNotFound) {
			[s appendString:target];
			break;
		}
		
		if (r.location > 0) {
			[s appendString:[target substringToIndex:r.location]];
			[target deleteCharactersInRange:NSMakeRange(0, r.location)];
		}
		
		if ([target hasPrefix:@"&lt;"]) {
			[s appendString:@"<"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		} else if ([target hasPrefix:@"&gt;"]) {
			[s appendString:@">"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		} else if ([target hasPrefix:@"&quot;"]) {
			[s appendString:@"\""];
			[target deleteCharactersInRange:NSMakeRange(0, 6)];
		} else if ([target hasPrefix:@"&amp;"]) {
			[s appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 5)];
		} else {
			[s appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 1)];
		}
	}
	
	return s;
}

+ (NSString*)localizedString:(NSString*)key
{
	return [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:key];
}

+ (NSString *)dateWithTimeInterval:(NSTimeInterval)timeInterval formatter:(NSString *)formatter
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)dateWithDate:(NSDate *)date formatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)customFormateDateStringFromDate:(NSDate *)needFormatDate
{
    @try {
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        NSDate * nowDate = [NSDate date];
        // 取当前时间和转换时间两个日期对象的时间间隔
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        
        //把间隔的秒数折算成天数和小时数：
        NSString *dateStr = @"";
        if (time <= 60 * 30) {  // 30分钟以内的
            dateStr = @"刚刚";
        }else if(time <= 60*60*24){   // 24小时以内
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            if ([need_yMd isEqualToString:now_yMd]) {
                // 在当天 显示几点几分
                [dateFormatter setDateFormat:@"HH:mm"];
                dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:needFormatDate]];
            }else{
                // 不在当天 显示几月几号
                [dateFormatter setDateFormat:@"MM-dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }else {
            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {
                //  在同一年
                [dateFormatter setDateFormat:@"MM-dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }else{
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
        return dateStr;
    }
    @catch (NSException *exception) {
        return @"";
    }
    
    
}

+ (NSString *)globalRedPackFormateDateStringFromDate:(NSDate *)actDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //获取今天0点时间
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *todayBegin = [calendar dateFromComponents:components];
    //下次活动时间距离今天0点的间隔
    NSTimeInterval interval = [actDate timeIntervalSinceDate:todayBegin];
    
    NSString *dateStr = @"";
    if(interval >= 0 && interval <= 60*60*48){   //48小时以内
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString * act_yMd = [dateFormatter stringFromDate:actDate];
        NSString *now_yMd = [dateFormatter stringFromDate:now];
        
        if ([act_yMd isEqualToString:now_yMd]) {
            //今天 显示几点几分
            [dateFormatter setDateFormat:@"HH:mm"];
            dateStr = [dateFormatter stringFromDate:actDate];
        }else{
            //明天
            [dateFormatter setDateFormat:@"HH:mm"];
            dateStr = [NSString stringWithFormat:@"明天%@",[dateFormatter stringFromDate:actDate]];
        }
    }else {
        [dateFormatter setDateFormat:@"MM月dd日HH:mm"];
        dateStr = [dateFormatter stringFromDate:actDate];
    }
    return dateStr;
}

/*
 
 Return the hexadecimal string representation of the MD5 digest of the target
 NSString. In this example, this is used to generate a statistically unique
 ID for each fortune file.
 
 */

- (NSString *)flattenHTMLWhiteSpace:(BOOL)trim
{
    
    NSScanner *theScanner;
    NSString *text = nil;
    NSString *flattenString = [NSString stringWithString:self];
    
    theScanner = [NSScanner scannerWithString:self];
    
    while (![theScanner isAtEnd]) {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        flattenString = [self stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
        
    }
    
    return trim ? [flattenString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : flattenString;
    
}

- (NSString *)flattenHTMLWithImgStyle
{
    
    NSScanner *theScanner;
    NSString *text = nil;
    NSString *flattenString = [NSString stringWithString:self];
    
    theScanner = [NSScanner scannerWithString:self];
    
    while (![theScanner isAtEnd]) {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        [theScanner scanUpToString:@">" intoString:&text];
        
        if ([text hasPrefix:@"<img"]
            ||[text hasPrefix:@"<span"]
            ||[text hasPrefix:@"</span"]
            ||[text hasPrefix:@"<strong"]
            ||[text hasPrefix:@"</strong"]) {
            flattenString = [self stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
        }
    }
    
    return flattenString;
    
}

- (NSString *)flattenImgHTMLWithWihtString:(NSString *)str
{
    NSScanner *theScanner;
    NSString *text = nil;
    NSString *flattenString = [NSString stringWithString:self];
    
    theScanner = [NSScanner scannerWithString:self];
    
    while (![theScanner isAtEnd]) {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        [theScanner scanUpToString:@">" intoString:&text];
        
        if ([text hasPrefix:@"<img"]) {
            flattenString = [self stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:str];
        }else {
            
            flattenString = [self stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
        }
    }
    
    return flattenString;
}


- (NSString *)stringByDecodingHTMLEntitiesInString
{
    NSMutableString *results = [NSMutableString string];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    while (![scanner isAtEnd]) {
        NSString *temp;
        if ([scanner scanUpToString:@"&" intoString:&temp]) {
            [results appendString:temp];
        }
        if ([scanner scanString:@"&" intoString:NULL]) {
            BOOL valid = YES;
            unsigned c = 0;
            NSUInteger savedLocation = [scanner scanLocation];
            if ([scanner scanString:@"#" intoString:NULL]) {
                // it's a numeric entity
                if ([scanner scanString:@"x" intoString:NULL]) {
                    // hexadecimal
                    unsigned int value;
                    if ([scanner scanHexInt:&value]) {
                        c = value;
                    } else {
                        valid = NO;
                    }
                } else {
                    // decimal
                    int value;
                    if ([scanner scanInt:&value] && value >= 0) {
                        c = value;
                    } else {
                        valid = NO;
                    }
                }
                if (![scanner scanString:@";" intoString:NULL]) {
                    // not ;-terminated, bail out and emit the whole entity
                    valid = NO;
                }
            } else {
                if (![scanner scanUpToString:@";" intoString:&temp]) {
                    // &; is not a valid entity
                    valid = NO;
                } else if (![scanner scanString:@";" intoString:NULL]) {
                    // there was no trailing ;
                    valid = NO;
                } else if ([temp isEqualToString:@"amp"]) {
                    c = '&';
                } else if ([temp isEqualToString:@"quot"]) {
                    c = '"';
                } else if ([temp isEqualToString:@"lt"]) {
                    c = '<';
                } else if ([temp isEqualToString:@"gt"]) {
                    c = '>';
                } else if ([temp isEqualToString:@"nbsp"]) {
                    c = ' ';
                } else if ([temp isEqualToString:@"times"]){
                    c = 'x';
                } else if ([temp isEqualToString:@"ldquo"]){
                    c = '"';
                }else if ([temp isEqualToString:@"rdquo"]){
                    c = '"';
                }else if ([temp isEqualToString:@"middot"]){
                    c = '.';
                }
                else {
                    // unknown entity
                    valid = NO;
                }
            }
            if (!valid) {
                // we errored, just emit the whole thing raw
                [results appendString:[self substringWithRange:NSMakeRange(savedLocation, [scanner scanLocation]-savedLocation)]];
            } else {
                [results appendFormat:@"%c", c];
            }
        }
    }
    return results;
}

-(NSString *)stringByStrippingHTML
{
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

-(NSString *)stringByStrippingSpace
{
    NSString *s = [self copy];
    
    NSRange spaceRange,wrapRange;
    while ((spaceRange = [s rangeOfString:@"&nbsp;"]).location != NSNotFound)
    {
        s = [s stringByReplacingCharactersInRange:spaceRange withString:@""];
    }
    while ((wrapRange = [s rangeOfString:@"\n"]).location != NSNotFound)
    {
        int i = 1;
        while ([[s substringWithRange:NSMakeRange(wrapRange.location + i, 1)] isEqualToString:@"\n"])
        {
            wrapRange.length += 1;
            i += 1;
            if ((wrapRange.location +i) >= [s length])
            {
                break;
            }
        }
        if (i > 1)
        {
            s = [s stringByReplacingCharactersInRange:wrapRange withString:@"wrapwrap"];
        }
        else
        {
            s = [s stringByReplacingCharactersInRange:wrapRange withString:@"wrap"];
        }
    }
    //NSLog(@"s = %@",s);
    return [s stringByReplacingOccurrencesOfString:@"wrap" withString:@"\n"];
}

+ (NSString*)encodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)encodeBase64Data:(NSData *)data {
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data {
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)guid {
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *cfuuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    CFRelease(cfuuid);
    return cfuuidString;
}

+(BOOL)isLegalInputString:(NSString *)inputString {

    // 编写正则表达式：最多输入50个中文、英文、数字的字符，且不能包含英文标点和特殊符号
    NSString *regex = @"^[\u4e00-\u9fa5a-zA-Z0-9]{0,50}$";
    // 创建谓词对象并设定条件的表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    // 对字符串进行判断
    if ([predicate evaluateWithObject:inputString]) {
        return NO;
    }else{
        return YES;
    }
}

- (NSInteger)multiLength {
    __block CGFloat length = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if ([substring length] == 1) {
            NSInteger clength = strlen([substring UTF8String]);
            if (clength == 1) {
                length += 0.5;
            }else {
                length += 1;
            }
        }else {
            length += 1;
        }
    }];
    return (int)ceil(length);
}

- (NSString *)subMultiStringToIndex:(NSInteger)index {
    __block CGFloat length = 0;
    NSMutableString *subString = [NSMutableString stringWithString:@""];
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if ([substring length] == 1) {
            NSInteger clength = strlen([substring UTF8String]);
            if (clength == 1) {
                length += 0.5;
            }else {
                length += 1;
            }
        }else {
            length += 1;
        }
        if (length <= index) {
            [subString appendString:substring];
        }
    }];
    return subString;
}

- (NSString *)filterTopicString
{
    NSRange topicRange = NSMakeRange(0, 0);
    NSMutableString *msg = [[NSMutableString alloc] initWithString:self];
    if ([msg hasPrefix:@"#"]) {
        [msg replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
        NSRange range = [msg rangeOfString:@"#"];
        if (range.location != NSNotFound && range.location != 0) {
            NSString *filterStr = [NSString stringWithString:[msg substringToIndex:range.location]];
            filterStr = [filterStr stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (filterStr.length > 0) {
                topicRange = NSMakeRange(0, range.location + 2);
            }
        }
    }
    return [self substringWithRange:topicRange];
}

- (NSString *)decodePercentEscapeString {
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByRemovingPercentEncoding];
}

+ (STUserLevelType)getUserLevelTypeWithUserLevel:(NSString *)userlevel {
    STUserLevelType levelType;
    NSInteger level = [userlevel integerValue];
    if (level <= 10) {
        levelType = STUserLevelTypeStar;
    } else if (level <= 15) {
        levelType = STUserLevelTypeMoon;
    } else if (level <= 20) {
        levelType = STUserLevelTypeSun;
    } else if (level <= 25) {
        levelType = STUserLevelTypeCyanDiamond;
    } else if (level <= 30) {
        levelType = STUserLevelTypeBlueDiamond;
    } else if (level <= 35) {
        levelType = STUserLevelTypePurpleDiamond;
    } else if (level <= 45) {
        levelType = STUserLevelTypeCrownOne;
    } else if (level <= 55) {
        levelType = STUserLevelTypeCrownTwo;
    } else {
        levelType = STUserLevelTypeCrownThree;
    }
    return levelType;
}

+ (BOOL)verifyIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
            return NO;
        }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
            return NO;
        }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
                + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
                + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
                + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
                 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
                 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
                 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
                 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
                 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

+ (CGFloat)getAttributedStringHeightWithString:(NSAttributedString *)string WidthValue:(CGFloat)width {
    CGFloat total_height = 0;
    
    CTFramesetterRef framesetter =  CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, width, 1000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (CTLineRef) CFBridgingRetain([linesArray objectAtIndex:[linesArray count]-1]);
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 1000 - line_y + (int) descent +1;    //+1为了纠正descent转换成int小数点后舍去的值
    CFRelease(textFrame);
    
    return total_height;
}

+ (NSString *)mothTrunTimestampToDate:(long long)timestamp{ // 返回月日
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp/1000.0];
    
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    
    dateFmt.dateFormat= @"MM月dd日";
    
    return [dateFmt stringFromDate:date];
}

+ (NSString *)hourTrunTimestampToDate:(long long)timestamp{ // 返回小时分钟
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp/1000.0];
    
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    
    dateFmt.dateFormat= @"HH:mm";
    
    return [dateFmt stringFromDate:date];
}

- (id)JsonObject {
    if ([self length] == 0) {
        return nil;
    }
    NSString *jsonStrong = [self copy];
    NSData *jsonData = [jsonStrong dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if (error) {
        return jsonStrong;
    }else {
        return object;
    }
}

+ (NSString *)stringWithNumber:(NSUInteger)number {
    NSString *numberString = nil;
    if (number < 1000) {
        numberString = [NSString stringWithFormat:@"%lu",(long)number];
    }else if (number >= 1000 && number < 10000){
        NSUInteger pre = number / 1000;
        NSUInteger last = number % 1000;
        if (last == 0) {
            numberString = [NSString stringWithFormat:@"%luK",(unsigned long)pre];
        }else {
            numberString = [NSString stringWithFormat:@"%.1fK",number/1000.0];
        }
    }else {
        NSUInteger pre = number / 10000;
        NSUInteger last = number % 10000;
        if (last == 0) {
            numberString = [NSString stringWithFormat:@"%luW",(unsigned long)pre];
        }else {
            numberString = [NSString stringWithFormat:@"%.1fW",number/10000.0];
        }
    }
    return numberString;
}

+(NSString *) timeChange:(NSString *)timeString{
    NSString*time=[timeString substringToIndex:18];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *currentDate = [dateFormatter dateFromString:time];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: currentDate];
    NSDate *localeDate = [currentDate dateByAddingTimeInterval: interval];
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc]init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *timeChanged = [outputFormatter stringFromDate:localeDate];
    
    NSLog(@"datestr = %@", timeChanged);
    
    return timeChanged;
    
}
@end
