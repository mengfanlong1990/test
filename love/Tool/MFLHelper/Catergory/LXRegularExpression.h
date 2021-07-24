//
//  LXRegularExpression.h
//  addChildViewController
//
//  Created by mfl on 16/12/6.
//  Copyright © 2016年 mfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LXRegularExpression : NSObject

@property (nonatomic,copy)NSString *passwordString;

///判断是不是手机号码
+(BOOL) isValidPhoneNumber:(NSString *)string;
///判断是不是身份证号
+ (BOOL)isValidIdentityCard:(NSString *)identityCard;
///判断是不是邮箱
+ (BOOL)isValidEmailAddress:(NSString *)emailStr;
///判断是不是身份证号
//+ (BOOL)validateIdentityCard: (NSString *)identityCard;

///验证密码是否正确  密码只能包含“字母”，“数字”，“下划线”，长度6~18
+(BOOL)isValidPassword:(NSString *)passwordStr;




@end
