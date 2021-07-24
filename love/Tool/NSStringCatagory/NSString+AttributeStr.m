//
//  NSString+AttributeStr.m
//  yyhouse
//
//  Created by 刘佳 on 2017/10/24.
//  Copyright © 2017年 RenJiZiding. All rights reserved.
//

#import "NSString+AttributeStr.h"
@implementation NSString (AttributeStr)
-(NSAttributedString *)attrWithFont:(UIFont *)font withColor:(UIColor *)color withRange:(NSRange)range{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:self];
    NSDictionary *dict = @{
                           NSFontAttributeName :font,
                           NSForegroundColorAttributeName:color
                           };
    
    [string setAttributes:dict range:range];
    
    return string;
}


-(CGFloat )textLenghWithfont:(UIFont *)font{
    NSDictionary *dict = @{
                           NSFontAttributeName :font
                           };
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:kNilOptions attributes:dict context:nil].size;
    return size.width;
}

//判断手机号
- (BOOL)checkoutPhone{
    NSString *regexStr = @"^1[3,6,8]\\d{9}|14[5,7,9]\\d{8}|15[^4]\\d{8}|17[^2,4,9]\\d{8}$";
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) return NO;
    NSInteger count = [regular numberOfMatchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length)];
    if (count > 0) {
        return YES;
    } else {
        return NO;
    }
}

-(BOOL)textCanPutInWithMaxLength:(NSInteger) maxLengh withReplaceStr:(NSString *)replaceStr{
    if (self.length < maxLengh||[replaceStr isEqualToString:@""]) {
        return YES;
    }
        return NO;
    
}
-(BOOL)textPhoneCanLightBtnWithReplaceStr:(NSString *)string{
    if (self.length == 10 &&(![string isEqualToString:@""])) {
        NSString *str = [NSString stringWithFormat:@"%@%@",self,string];
        if ([str checkoutPhone]) {
           return  YES;
        }else{
           return  NO;
        }
    }else{
        return NO;
    }
}
-(BOOL)textCanLightBtnWithLengh:(NSInteger) lengh withReplaceStr:(NSString *)string{
    if ((self.length == lengh - 1&&![string isEqualToString:@""])||self.length >lengh||(self.length == lengh && ![string isEqualToString:@""])) {
        return YES;
    }
    return NO;
}

- (NSString*) replaceUnicode

{
    
    NSString*tepStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    
    NSString*tepStr2 = [tepStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    
    NSString*tepStr3 = [[@"\""  stringByAppendingString:tepStr2]stringByAppendingString:@"\""];
    
    NSData*tepData = [tepStr3  dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString*axiba = [NSPropertyListSerialization    propertyListWithData:tepData options:NSPropertyListMutableContainers format:NULL error:NULL];
    
    return  [axiba   stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
}


@end

static NSCalendar *_calender;

@implementation NSString (NSDate)
-(NSCalendar *)getCalender{
    if (_calender == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _calender  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            
        });
    }
    return _calender ;
}
-(NSString*)dateStrWithWeek{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.longLongValue];
    NSDateComponents *components = [[self getCalender] components:NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday fromDate:date];
    NSString *weekStr ;
    switch (components.weekday) {
        case 1:
            {
                weekStr = @"星期日";
            }
            break;
        case 2:
            weekStr = @"星期一";

            break;
        case 3:
            weekStr = @"星期二";

            break;
        case 4:
            weekStr = @"星期三";

            break;
        case 5:
            weekStr = @"星期四";

            break;
        case 6:
            weekStr = @"星期五";

            break;
        case 7:
            weekStr = @"星期六";
            
            break;
        default:
            break;
    }
    NSString *timeStr = [NSString stringWithFormat:@"%ld-%ld-%ld (%@) %02ld：%ld",components.year,components.month,components.day,weekStr,components.hour,components.minute];
    return timeStr;
}



@end
