//
//  NSString+LXExtension.h
//  addChildViewController
//
//  Created by heartjhl on 16/12/7.
//  Copyright © 2016年 heartjhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LXExtension)


/// MD5加密
- (nonnull NSString *)MD5LX;

/// SHA1加密
-(NSString * __nonnull)SHA1LX;


/** 是不是中文 */
- (BOOL)lx_isChinese;

/** 是不是英文 */
- (BOOL)lx_isEnglish;

/** 是不是特殊字符 */
- (BOOL)lx_isSpecialCharacters;

/** 是不是英文字母、数字、_，且以英文字母开头 */
- (BOOL)lx_isEnglishAndNumber;

- (BOOL)lx_isNumber;

/** 可变 Placeholder */
+ (NSAttributedString * __nonnull)attributedPlaceholderWithText:(nonnull NSString *)textString;

/**
 可变字符串处理。
 第一段和最后一段字符串 不允许 为空。
 默认字体颜色为灰色、大小为 17。
 最后一段字符串颜色、字体为空 则 以第一段字体颜色、大小为准，都为空则 默认

 @param firstString 第一段字符串
 @param firstFont 字符串字体
 @param firstColor 字符串颜色
 @param midString 中间一段字符串
 @param midFont 字符串字体
 @param midColor 字符串颜色
 @param lastString 最后一段字符串
 @param lastFont 字符串字体
 @param lastColor 字符串颜色
 @return 可变字符串
 */
+ (NSAttributedString * __nonnull)attributedStringFirstString:(nonnull NSString *)firstString font:(nullable UIFont *)firstFont color:(nullable UIColor *)firstColor middleString:(nullable NSString *)midString font:(nullable UIFont *)midFont color:(nullable UIColor *)midColor lastString:(nonnull NSString *)lastString font:(nullable UIFont *)lastFont color:(nullable UIColor *)lastColor;

/**
 */
+ (NSAttributedString * __nonnull)getAttributedStringWithString:(nullable NSString *)string lineSpace:(CGFloat)lineSpace;


- (CGSize)sizeWithFont:(nonnull UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(nonnull UIFont *)font;

/** 增加了逻辑判断, 对于文件路径 和 网络路径进行不同的处理  */
@property (nonatomic, readonly, nullable)  NSURL *lx_URL;

/** 判断是否有emoji */
+ (BOOL)stringContainsEmoji:(nonnull NSString *)string;

/// 字符转化成16进制
+ (nonnull NSString *)hexStringFromString:(nonnull NSString *)string;

/// 16进制转化成字符
+ (nonnull NSString *)stringFromHexString:(nonnull NSString *)hexString;

/** 字符 转 Unicode */
+ (nonnull NSString *)stringToUnicode:(nonnull NSString *)string;
/** Unicode 转 字符 */
+ (nonnull NSString *)unicodeToString:(nonnull NSString *)unicode;
/**
 * 字母、数字、中文正则判断（包括空格）（在系统输入法中文输入时会出现拼音之间有空格，需要忽略，当按return键时会自动用字母替换，按空格输入响应汉字）
 */
+ (BOOL)isInputRuleAndBlank:(NSString *_Nullable)str;



/**
 *  过滤字符串中的emoji
 */
+ (NSString *_Nullable)disable_emoji:(NSString *_Nonnull)text;
/**
 * 字母、数字、中文正则判断（不包括空格）
 */
+ (BOOL)isInputRuleNotBlank:(NSString *_Nullable)str;

// 判断字符串中是否含有非法字符 （非法字符是指 除数字 字母 文字以外的所有字符）
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content;

//获取当前年月日
+ (NSString *)getCurrentDate;

//通过年月求每月天数
+(NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month;
@end
