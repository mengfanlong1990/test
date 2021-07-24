//
//  UIColor+LXExtension.m
//  linktrustEduTeacher
//
//  Created by linktrusts on 2016/12/8.
//  Copyright © 2016年 linktrust. All rights reserved.
//

#import "UIColor+LXExtension.h"

@implementation UIColor (LXExtension)

+ (UIColor *)colorWithHexStr:(NSString *)color {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    // 删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // 如果是 # 开头的，那么截取字符串，字符串从索引为 1 的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    // 如果是 0x 开头的，那么截取字符串，字符串从索引为 2 的位置开始，一直到末尾
    if ([cString hasPrefix:@"0x"] ||
        [cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    
    NSUInteger lenght = [cString length];
    // RGB  RGBA  RRGGBB  RRGGBBAA
    if (lenght != 3 &&
        lenght != 4 &&
        lenght != 6 &&
        lenght != 8) {
        return [UIColor clearColor];
    }
    
    // 将相应的字符串转换为数字
    if (lenght < 5) {
        red = hexStrToInt([cString substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        green = hexStrToInt([cString substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        blue = hexStrToInt([cString substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (lenght == 4) {
            alpha = hexStrToInt([cString substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        } else {
            alpha = 1.0;
        }
    } else {
        red = hexStrToInt([cString substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        green = hexStrToInt([cString substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        blue = hexStrToInt([cString substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (lenght == 8) {
            alpha = hexStrToInt([cString substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        } else {
            alpha = 1.0;
        }
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


+ (UIColor *)colorWithHexStr:(NSString *)color withAlpha:(CGFloat)alpha{
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    // 删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // 如果是 # 开头的，那么截取字符串，字符串从索引为 1 的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    // 如果是 0x 开头的，那么截取字符串，字符串从索引为 2 的位置开始，一直到末尾
    if ([cString hasPrefix:@"0x"] ||
        [cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    
    NSUInteger lenght = [cString length];
    // RGB  RGBA  RRGGBB  RRGGBBAA
    if (lenght != 3 &&
        lenght != 4 &&
        lenght != 6 &&
        lenght != 8) {
        return [UIColor clearColor];
    }
    
    // 将相应的字符串转换为数字
    if (lenght < 5) {
        red = hexStrToInt([cString substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        green = hexStrToInt([cString substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        blue = hexStrToInt([cString substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
      
    } else {
        red = hexStrToInt([cString substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        green = hexStrToInt([cString substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        blue = hexStrToInt([cString substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
       
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
// 內联函数，
static inline NSUInteger hexStrToInt(NSString *colorStr) {
    unsigned int result;
    [[NSScanner scannerWithString:colorStr] scanHexInt:&result];
    return result;
}

+ (UIColor *)colorWithRGB16:(NSUInteger)rgbValue {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:((rgbValue & 0xFF)) / 255.0f
                           alpha:1.0f];
}

@end
