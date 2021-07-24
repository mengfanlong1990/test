//
//  NSString+LXExtension.m
//  addChildViewController
//
//  Created by heartjhl on 16/12/7.
//  Copyright © 2016年 heartjhl. All rights reserved.
//

#import "NSString+LXExtension.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (LXExtension)




- (NSString *)MD5LX {
    
    const char* cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int)strlen(cStr), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSInteger i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x", result[i]];
    }
    
    return ret;
}

-(NSString *)SHA1LX
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
    
}

- (BOOL)isValidateByRegex:(NSString *)regex{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)lx_isChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)lx_isSpecialCharacters {
    NSString *match = @"(^[\u4E00-\u9FA5A-Za-z0-9]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return ![predicate evaluateWithObject:self];
}

- (BOOL)lx_isEnglish {
    NSString *match = @"(^[A-Za-z]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)lx_isEnglishAndNumber {
    NSString *match = @"(^[a-zA-Z][a-zA-Z0-9_]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)lx_isNumber {
    NSString *match = @"(^[0-9]*$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

+ (NSAttributedString *)attributedPlaceholderWithText:(NSString *)textString {
    NSString *firstStr = [NSString stringWithFormat:@"%@", textString];
    NSAttributedString *firstAttString = [[NSAttributedString alloc] initWithString:firstStr attributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexStr:@"a4b7bc"], NSFontAttributeName : [UIFont systemFontOfSize:16]}];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithAttributedString:firstAttString];

    return attString.copy;
}

+ (NSAttributedString *)attributedStringFirstString:(NSString *)firstString font:(UIFont *)firstFont color:(UIColor *)firstColor middleString:(NSString *)midString font:(UIFont *)midFont color:(UIColor *)midColor lastString:(NSString *)lastString font:(UIFont *)lastFont color:(UIColor *)lastColor {
    UIFont *defaultFont = (firstFont == nil) ? [UIFont systemFontOfSize:17] : firstFont;
    UIColor *defaultColor = (firstColor == nil) ? [UIColor grayColor] : firstColor;
    
    NSAttributedString *firstAttString = [[NSAttributedString alloc] initWithString:firstString attributes:@{NSFontAttributeName : (firstFont == nil) ? defaultFont : firstFont, NSForegroundColorAttributeName : (firstFont == nil) ? defaultColor : firstColor}];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithAttributedString:firstAttString];
    
    if (midString != nil ||
        ![midString isEqualToString:@""] ||
        midString.length > 0) {
        NSString *midStr = [NSString stringWithFormat:@"%@", midString];
        NSAttributedString *midAttString = [[NSAttributedString alloc] initWithString:midStr attributes:@{NSFontAttributeName : (midFont == nil) ? defaultFont : midFont, NSForegroundColorAttributeName : (midColor == nil) ? [UIColor orangeColor] : midColor}];
        [attString appendAttributedString:midAttString];
    }
    
    NSAttributedString *lastAttString = [[NSAttributedString alloc] initWithString:lastString attributes:@{NSFontAttributeName : (lastFont == nil) ? defaultFont : lastFont, NSForegroundColorAttributeName : (lastColor == nil) ? defaultColor : lastColor}];
    [attString appendAttributedString:lastAttString];
    
    return attString.copy;
}

+(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
}


- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    return CGSizeMake(size.width, ceil(size.height));
}
- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];//没有最大宽度，随便计算
}

- (NSURL *)lx_URL {
    if ([self containsString:@"http://"] || [self containsString:@"https://"]) {
        return [NSURL URLWithString:self];
    }
    return [NSURL fileURLWithPath:self];
}

// 判断是否有emoji
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}

//[😬  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
//字符转化16进制数
+ (NSString *)hexStringFromString:(NSString *)string{
    
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"$$$$$:%@",myD);
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        NSLog(@"!!!!!!!!!!:%@",newHexStr);
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

// 16进制转换为字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString {
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    return unicodeString;
}

/** 字符 转 Unicode */
+ (NSString *)stringToUnicode:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *unicode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return unicode;
}

/** Unicode 转 字符 */
+ (NSString *)unicodeToString:(NSString *)unicode {
    NSData *data = [unicode dataUsingEncoding:NSUTF8StringEncoding];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
    return string;
}


/**
 * 字母、数字、中文正则判断（包括空格）（在系统输入法中文输入时会出现拼音之间有空格，需要忽略，当按return键时会自动用字母替换，按空格输入响应汉字）
 */

+ (BOOL)isInputRuleAndBlank:(NSString *_Nullable)str{
    
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\d\\s]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

/**
 *  过滤字符串中的emoji
 */
+ (NSString *_Nullable)disable_emoji:(NSString *_Nonnull)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}
/**
 * 字母、数字、中文正则判断（不包括空格）
 */
+ (BOOL)isInputRuleNotBlank:(NSString *_Nullable)str {
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\d]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        NSString *other = @"➋➌➍➎➏➐➑➒";
        unsigned long len=str.length;
        for(int i=0;i<len;i++)
        {
            unichar a=[str characterAtIndex:i];
            if(!((isalpha(a))
                 ||(isalnum(a))
                 ||((a=='_') || (a == '-'))
                 ||((a >= 0x4e00 && a <= 0x9fa6))
                 ||([other rangeOfString:str].location != NSNotFound)
                 ))
                return NO;
        }
        return YES;
        
    }
    return isMatch;
}
// 判断字符串中是否含有非法字符 （非法字符是指 除数字 字母 文字以外的所有字符）
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}

//获取当前年月日
+ (NSString *)getCurrentDate
{
    //获取当前时间 （时间格式支持自定义）
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];//自定义时间格式
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    //拆分年月成数组
    NSArray *dateArray = [currentDateStr componentsSeparatedByString:@"-"];
    return [NSString stringWithFormat:@"%@-%@-%@",[NSString stringWithFormat:@"%ld",(long)[dateArray firstObject]],[NSString stringWithFormat:@"%02ld",(long)dateArray[1]],[NSString stringWithFormat:@"%02ld",(long)dateArray[2]]];
   
}
//通过年月求每月天数
+(NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;
    
    BOOL isrunNian = num_year%4==0 ? (num_year%100==0? (num_year%400==0?YES:NO):YES):NO;
    switch (num_month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
            return 31;
        }
        case 4:case 6:case 9:case 11:{
            return 30;
        }
        case 2:{
            if (isrunNian) {
                return 29;
            }else{
                return 28;
            }
        }
        default:
            break;
    }
    return 0;
}
@end
