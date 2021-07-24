//
//  NSString+AttributeStr.h
//  yyhouse
//
//  Created by 刘佳 on 2017/10/24.
//  Copyright © 2017年 RenJiZiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (AttributeStr)
-(NSAttributedString *)attrWithFont:(UIFont *)font withColor:(UIColor *)color withRange:(NSRange)range;

-(CGFloat )textLenghWithfont:(UIFont *)font;
//判断手机号
- (BOOL)checkoutPhone;
//textField 验证位数
-(BOOL)textCanPutInWithMaxLength:(NSInteger) maxLengh withReplaceStr:(NSString *)replaceStr;
//是否可以点亮btn
-(BOOL)textPhoneCanLightBtnWithReplaceStr:(NSString *)string;
-(BOOL)textCanLightBtnWithLengh:(NSInteger) lengh withReplaceStr:(NSString *)string;
- (NSString*) replaceUnicode;
@end
@interface NSString (NSDate)
-(NSString*)dateStrWithWeek;
@end
