//
//  LXRegularExpression.m
//  addChildViewController
//
//  Created by mfl on 16/12/6.
//  Copyright © 2016年 mfl. All rights reserved.
//

#import "LXRegularExpression.h"

@implementation LXRegularExpression

#pragma mark---------------手机号判断---------------------
+(BOOL)isValidPhoneNumber:(NSString *)mobileNum{
    
    if ([mobileNum length] == 0) {
        return NO;
    }
    NSString *regex = @"^((1[3,5,8][0-9])|(14[5,7])|(17[0,6,7,8]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    if (!isMatch) {
        
        return NO;
    }
    
    return YES;
}

#pragma mark------------身份证号码验证--------------------
+ (BOOL)isValidIdentityCard:(NSString *)identityCard
{
    if (identityCard.length <= 0) {
        
        return NO;
    }
    NSString *regex2 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    NSString *regex3 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    NSPredicate *identityCardPredicate2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex3];
    if ([identityCardPredicate evaluateWithObject:identityCard]==YES ||[identityCardPredicate2 evaluateWithObject:identityCard]==YES) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark------------邮箱验证--------------------
+ (BOOL)isValidEmailAddress:(NSString *)emailStr {
    
    if ([emailStr length] == 0) {
        return NO;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isMatch = [pred evaluateWithObject:emailStr];
    if (!isMatch) {
        
        return NO;
    }
    
    return YES;
    
}

/// 身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard
{
    
    if (identityCard.length <= 0) {
        
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
    
}

#pragma mark---------------------验证密码是否正确-----------
//密码只能包含“字母”，“数字”，“下划线”，长度6~18
+(BOOL)isValidPassword:(NSString *)passwordStr
{
    if (passwordStr.length <= 0) {
        
        return NO;
    }
//    NSString *regex2 = @"^[a-zA-Z][a-zA-Z0-9_]{5,17}$";
//    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
//    return [identityCardPredicate evaluateWithObject:passwordStr];

//    ^[a-zA-Z0-9_]{6,20}+$  ^([a-zA-Z]|[a-zA-Z0-9_]|[0-9]){6,18}$ ^[a-zA-Z][a-zA-Z0-9_]*$  ^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}
    
//    ^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18} 数字和字母  ^[a-zA-Z][a-zA-Z0-9_]{5,19}$   ^[a-zA-Z][a-zA-Z0-9_-]{5,19}$ (6-20)
    
    
//    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";//数字和字母
    NSString *regex = @"^[0-9A-Za-z]{0,20}$";//数字或字母
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:passwordStr];
}

/**
 ^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,10}$
 分开来注释一下：
 ^ 匹配一行的开头位置
 (?![0-9]+$) 预测该位置后面不全是数字
 (?![a-zA-Z]+$) 预测该位置后面不全是字母
 [0-9A-Za-z] {6,10} 由6-10位数字或这字母组成
 $ 匹配行结尾位置
 
 */


@end
