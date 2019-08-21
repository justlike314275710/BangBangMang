//
//  NSString+JsonString.m
//  GKHelpOutApp
//
//  Created by kky on 2019/3/7.
//  Copyright © 2019年 kky. All rights reserved.
//

 

@implementation NSString (JsonString)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+(NSString *)changeTelephone:(NSString*)teleStr{
    NSString *string=[teleStr stringByReplacingOccurrencesOfString:[teleStr substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    return string;
}

@end
