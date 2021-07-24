//
//  MomConstant.m
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  完美解决Xcode NSLog打印不全的宏 亲测目前支持到8.2bate版
 */
#ifdef DEBUG
//#define NSLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define NSLog(format, ...)
#endif








#ifdef DEBUG
#define  BaseUrl @""
#else
#define  BaseUrl @""
#endif



/***** macro *****/
#pragma mark - macro----------
#define APPDELEGATE     (AppDelegate *)[UIApplication sharedApplication].delegate
#define ScreenBounds [UIScreen mainScreen].bounds
#define kScreenW                   [UIScreen mainScreen].bounds.size.width
#define kScreenH                   [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight           [[UIApplication sharedApplication] statusBarFrame].size.height
#define WS __weak typeof(self)weakSelf = self
#define SS(strongSelf)           __strong __typeof(&*self) strongSelf = self;
#define Font(fontSize)             [UIFont systemFontOfSize:fontSize]
#define  AppSystemVersion [UIDevice currentDevice].systemVersion.floatValue
#define  Version  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
#define isiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)// 判断是否是iPhone X
#define ScreenScale [UIScreen mainScreen].scale//屏幕分辨率缩放
#define SafeAreaTopHeight (kScreenH >= 812.0 ? 88 : 64)




#pragma mark 常量----------
#define MBSHOWTIME 2.f//MBProgress 显示时长
#define SMSLength 6//验证码长度
#define PageSize  10//每页请求数据数
#define NETNOTCONNECT     -1009


#pragma mark color----------
#define  MainColor              [UIColor colorWithHexStr:@"2cacc0"]
#define  LineColor           [UIColor colorWithHexStr:@"e5e5e5"]





#pragma mark Notification----------
//#define LOGINSTATEIN  @"LOGINSTATEIN"//登录




#pragma mark netError----------
//#define NETNOTCONNECT     -1009








