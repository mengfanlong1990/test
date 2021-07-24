//
//  MFLCustomHUD.h
//  MomBaby
//
//  Created by rjzd on 2018/6/20.
//  Copyright © 2018年 RenJiZiding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFLCustomHUD : NSObject
@property (nonatomic, copy) NSString * text;//显示的文字
@property (nonatomic, copy) UIColor * textColor;//显示的文字颜色
+ (instancetype)showCustomHudText:(NSString *)text textColor:(UIColor *)color InView:(UIView *)view;
- (void)animationShow:(BOOL)show;
- (void)hide:(BOOL)hide;
@end
