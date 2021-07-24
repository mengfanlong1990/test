//
//  MBProgressHUD+YYFProgressHUD.h
//  yyf
//
//  Created by rjzd on 2017/8/15.
//  Copyright © 2017年 人济紫顶. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (YYFProgressHUD)

/**
 * 要显示错误信息的时候调用该方法
 */
+ (void)showErrorLX:(NSString *)error;
/**
 * 要显示错误信息的时候调用该方法 ****** 可选择加载到哪个视图上
 */
+ (void)showErrorLX:(NSString *)error toView:(UIView *)view;
/**
 *要显示成功信息的时候调用该方法
 */
+ (void)showSuccessLX:(NSString *)success;
/**
 *要显示成功信息的时候调用该方法 ****** 可选择加载到哪个视图上
 */
+ (void)showSuccessLX:(NSString *)success toView:(UIView *)view;
/**
 *要显示自定义信息的时候调用该方法
 */
+ (MBProgressHUD *)showMessagLX:(NSString *)message;
/**
 *要显示自定义信息的时候调用该方法 ****** 可选择加载到哪个视图上
 */
+ (MBProgressHUD *)showMessagLX:(NSString *)message toView:(UIView *)view;
//暂用
///**
// *
// */
//- (void)LXhud_showProgressMessage:(NSString *)msg;
//
///**
// *
// */
//- (void)LXhud_showToastMessage:(NSString *)msg;
///**
// *
// */
//- (void)LXhud_showToastMessage:(NSString *)msg withComplete:(void (^)())completion;
/**
 * 隐藏  隐藏加载到默认视图上的 MBProgressHUD
 */
- (void)hideMBProgressHUD;
/**
 * 隐藏  加载到指定视图上的 MBProgressHUD
 */
- (void)hideMBProgressHUD:(UIView *)view;
/**
 * 使用圆环作为进度条
 */

+ (void)showProgressStatus:(NSProgress *)progress message:(NSString *)message;
/**
 * 使用圆环作为进度条  加载到指定的视图上
 */

+ (void)showProgressStatus:(NSProgress *)progress message:(NSString *)message withView:(UIView *)view;


+ (void)showHUDOnlyText:(NSString *)text afterDelay:(NSInteger)afterDelay ;

+ (void)hiddenHUD ;

+(void)showHUDWithText:(NSString *)text image:(UIImage *)image;
+ (void)showTransformImageWithText:(NSString *)text  afterDelay:(NSInteger)afterDelay;
@end
