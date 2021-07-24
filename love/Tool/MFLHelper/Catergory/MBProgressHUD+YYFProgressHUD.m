//
//  MBProgressHUD+YYFProgressHUD.m
//  yyf
//
//  Created by rjzd on 2017/8/15.
//  Copyright © 2017年 人济紫顶. All rights reserved.
//

#import "MBProgressHUD+YYFProgressHUD.h"

@implementation MBProgressHUD (YYFProgressHUD)
/*
 
 // 使用UIActivityIndicatorView来显示进度，这是默认值
 MBProgressHUDModeIndeterminate,
 
 // 使用一个圆形饼图来作为进度视图
 MBProgressHUDModeDeterminate,
 
 // 使用一个水平进度条
 MBProgressHUDModeDeterminateHorizontalBar,
 
 // 使用圆环作为进度条  MBProgressHUDModeAnnularDeterminate
 MBProgressHUDModeAnnularDeterminate,
 
 // 显示一个自定义视图，通过这种方式，可以显示一个正确或错误的提示图
 MBProgressHUDModeCustomView,
 
 // 只显示文本
 MBProgressHUDModeText
 
 */


#pragma mark 显示信息
+ (void)showLX:(NSString *)text icon:(NSString *)imageNamed view:(UIView *)view
{
    if (view==nil) {
        
        view = [UIApplication sharedApplication].keyWindow;
    }
    //     快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //    hud.label.text = text;
    hud.labelText=text;
    hud.labelFont=[UIFont systemFontOfSize:13];
    //    hud.label.font=[UIFont systemFontOfSize:13];
    //     再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    //     自定义设置图片 成功与失败时的图片
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    UIImageView *customImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
    customImage.frame = CGRectMake(10, 0, CGRectGetWidth(customView.frame)-20, CGRectGetHeight(customView.frame)-20);
    [customView addSubview:customImage];
    hud.customView = customImage;
    
    //     隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    //     2秒之后再消失
    //    [hud hideAnimated:YES afterDelay:2];
    [hud hide:YES afterDelay:2];
}

#pragma mark -------------显示错误的信息--------------
+ (void)showErrorLX:(NSString *)error
{
    [self showLX:error icon:@"Error" view:nil];
    
}
+ (void)showErrorLX:(NSString *)error toView:(UIView *)view{
    
    [self showLX:error icon:@"Error" view:view];
}
#pragma mark -------------显示成功的信息--------------
+ (void)showSuccessLX:(NSString *)success
{
    [self showLX:success icon:@"Succeed" view:nil];
}
+ (void)showSuccessLX:(NSString *)success toView:(UIView *)view
{
    [self showLX:success icon:@"Succeed" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessagLX:(NSString *)message
{
    //         快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    //    hud.label.text=message;
    hud.labelText=message;
    //     隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    //    hud.mode=MBProgressHUDModeText;
    //      设置蒙版效果
    //    hud.backgroundView.style = MBProgressHUDModeDeterminateHorizontalBar;
    //    hud.backgroundView.color =[UIColor colorWithWhite:0.f alpha:.2f] ;
    hud.dimBackground=NO;
    [hud hide:YES afterDelay:2];
    return hud;
    
}
+ (MBProgressHUD *)showMessagLX:(NSString *)message toView:(UIView *)view {
    
    //         快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    //    hud.label.text=message;
    hud.labelText=message;
    //     隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    //    hud.mode=MBProgressHUDModeText;
    //      设置蒙版效果
    hud.dimBackground=YES;
    //    hud.backgroundView.style = MBProgressHUDModeDeterminateHorizontalBar;
    //    hud.backgroundView.color =[UIColor colorWithWhite:0.f alpha:.2f] ;
    [hud hide:YES afterDelay:1.5];
    return hud;
}

+ (void)showProgressStatus:(NSProgress *)progress message:(NSString *)message
{
    [self showProgress:progress message:message withView:nil];
    
}

+ (void)showProgressStatus:(NSProgress *)progress message:(NSString *)message withView:(UIView *)view
{
    [self showProgress:progress message:message withView:view];
    
}

+ (void)showProgress:(NSProgress*)progress message:(NSString *)message withView:(UIView *)view
{
    if (view==nil) {
        view=[UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    //    hud.label.text = message;
    hud.labelText=message;
    //    hud.progressObject = progress;
    //    hud.progress=progress;
    
}

#pragma mark - HUD

- (void)hud_showProgressMessage:(NSString *)msg {
    
    [self showHUDTitle:msg withImageNamed:nil withMode:MBProgressHUDModeIndeterminate withAfterDelay:0 withComplete:nil];
}

- (void)hud_showToastMessage:(NSString *)msg {
    
    [self hud_showToastMessage:msg withComplete:nil];
}

- (void)hud_showToastMessage:(NSString *)msg withComplete:(void (^)())completion {
    
    [self showHUDTitle:msg withImageNamed:nil withMode:MBProgressHUDModeText withAfterDelay:0.5 withComplete:completion];
}

- (void)hideMBProgressHUD {
    
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

- (void)hideMBProgressHUD:(UIView *)view {
    
    [MBProgressHUD hideHUDForView:view animated:YES];;
}

- (void)showHUDTitle:(NSString *)title withImageNamed:(NSString *)imageNamed withMode:(MBProgressHUDMode)mode withAfterDelay:(NSTimeInterval)delay withComplete:(void (^)())completion {
    
    //根据具体需求再写
    
    
}
+ (void)hiddenHUD {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
}


+ (void)showHUDOnlyText:(NSString *)text afterDelay:(NSInteger)afterDelay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];;
    hud.removeFromSuperViewOnHide= YES;
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    hud.label.lineBreakMode = NSLineBreakByCharWrapping;
    [hud hideAnimated:YES afterDelay:afterDelay];
}

+(void)showHUDWithText:(NSString *)text image:(UIImage *)image{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.label.text = text?:@"";
    hud.mode = MBProgressHUDModeCustomView;
    if (image) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
        hud.customView = imgView;
    }else{
        
    }
    //设置在hud影藏时将其从SuperView上移除,自定义情况下默认为NO
    hud.removeFromSuperViewOnHide = YES;
    
    //设置方框view为该模式后修改颜色才有效果
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    //设置方框view背景色
    hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    //设置总背景view的背景色，并带有透明效果
    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];


//    //文字颜色
    hud.label.textColor =[UIColor colorWithHexStr:@"#dddddd"];
    
//    hud.contentColor = [UIColor whiteColor];
//    hud.animationType = MBProgressHUDAnimationFade;
    hud.margin = 0.;
    hud.minSize =CGSizeMake(100, 100);
    hud.square = YES;
}
+ (void)showTransformImageWithText:(NSString *)text  afterDelay:(NSInteger)afterDelay{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    if (text) {
        hud.label.text = text;
    }
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [UIImage imageNamed:@"pic_jiazai"];
    UIImageView *imgV = [[UIImageView alloc] initWithImage:image];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    [imgV.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    
    hud.customView = imgV;
    hud.square = YES;
    

    if (afterDelay<=0) {
        [hud hideAnimated:YES afterDelay:10.f];
    }else{
        [hud hideAnimated:YES afterDelay:afterDelay];
    }
   

}
@end
