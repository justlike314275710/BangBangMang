//
//  PSMacro.h
//  PrisonService
//
//  Created by calvin on 2018/4/2.
//  Copyright © 2018年 calvin. All rights reserved.
//
#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


#define UIColorFromHexadecimalRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromHexadecimalRGBA(rgbValue,alp) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alp]

#define UIColorFromRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define AppBaseTextColor1 (UIColorFromHexadecimalRGB(0x666666))//灰色

#define AppBaseTextColor2 (UIColorFromHexadecimalRGB(0x999999))

//#define AppBaseTextColor3 (UIColorFromHexadecimalRGB(0x264c90))//蓝色 主题色
#define AppBaseTextColor3 UIColorFromRGB(100,140,214)

#define AppBaseTextColor4 (UIColorFromHexadecimalRGB(0x7d8da2))

#define AppBaseLineColor (UIColorFromHexadecimalRGB(0xe5e5e5))

#define AppBaseTextFont1 (FontOfSize(15))

#define AppBaseTextFont2 (FontOfSize(13))

#define AppBaseTextFont3 (FontOfSize(14))

#define AppBaseBackgroundColor1 [UIColor whiteColor]

#define AppBaseBackgroundColor2 (UIColorFromHexadecimalRGB(0xF9F8FE))

#define FontOfSize(size) [UIFont systemFontOfSize:size]

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define RELATIVE_HEIGHT_VALUE(value) SCREEN_HEIGHT * value / 667.0

#define RELATIVE_WIDTH_VALUE(value) SCREEN_WIDTH * value / 375.0

#define IS_iPhone_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//获取视图的高
#define GETHEIGHT(view) CGRectGetHeight(view.frame)
//获取视图的宽
#define GETWIDTH(view) CGRectGetWidth(view.frame)
//获取视图的X坐标
#define GETORIGIN_X(view) view.frame.origin.x
//获取视图的Y坐标
#define GETORIGIN_Y(view) view.frame.origin.y
//获取下一个视图的X坐标
#define GETRIGHTORIGIN_X(view) view.frame.origin.x + CGRectGetWidth(view.frame)
//获取下一个视图的Y坐标
#define GETBOTTOMORIGIN_Y(view) view.frame.origin.y + CGRectGetHeight(view.frame)


#ifdef DEBUG
#define PSLog(...) NSLog(__VA_ARGS__);
#else
#define PSLog(...);
#endif
