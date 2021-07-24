//
//  UIColor+LXExtension.h
//  linktrustEduTeacher
//
//  Created by linktrusts on 2016/12/8.
//  Copyright © 2016年 linktrust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LXExtension)

/** 16进制颜色转换为 RGB颜色
 *  传入字符串
 *  如：#FFFFFF／0xFFFFFF／0XFFFFFF
 */
+ (UIColor *)colorWithHexStr:(NSString *)color;

/** 16进制颜色转换为 RGB颜色
 *  传入16进制数字
 *  如：0xFFFFFF／0XFFFFFF
 */
+ (UIColor *)colorWithRGB16:(NSUInteger)rgbValue;

+ (UIColor *)colorWithHexStr:(NSString *)color withAlpha:(CGFloat)alpha;

@end
