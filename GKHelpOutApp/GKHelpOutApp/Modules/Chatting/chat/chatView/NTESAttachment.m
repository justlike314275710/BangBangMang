//
//  Attachment.m
//  DemoApplication
//
//  Created by chris on 15/11/1.
//  Copyright © 2015年 chris. All rights reserved.
//

#import "NTESAttachment.h"

@implementation NTESAttachment

- (NSString *)encodeAttachment{
    NSDictionary *dict = @{@"OrderTime":self.time,@"cid":self.cid,@"category":self.category,@"categoryType":self.categoryType,@"type":@"111"};
   // NSDictionary*par=@{@"data":dict,@"type":@"111"};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *encodeString = @"";
    if (data) {
        encodeString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return encodeString;
}

//其他协议如上传下载托管可根据自己的业务需求选择实现

#pragma mark - Getter
- (NSString *)title{
    if (!_title) {
        _title = @"";
    }
    return _title;
}

- (NSString *)category{
    if (!_category) {
        _category =@"";
    }
    return _category;
}
- (NSString *)cid{
    if (!_cid) {
        _cid = @"";
    }
    return _cid;
}
- (NSString *)categoryType{
    if (!_categoryType) {
        _categoryType = @"";
    }
    return _categoryType;
}

@end
