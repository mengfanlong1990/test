//
//  UIView+LXExtension.h
//  addChildViewController
//
//  Created by heartjhl on 16/12/6.
//  Copyright © 2016年 heartjhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LXExtension)

// 设置视图为圆角
- (void)LXCornerRadius:(CGFloat)cornerRadius;

// 设置视图的边框颜色和宽度
- (void)LXborderColor:(UIColor *)color andWidth:(CGFloat)width;

/// 设置视图抖动几下
-(void)LX_setViewJitter;

/** 获取当前视图的根视图控制器 */
- (UIViewController *)viewRootViewController;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, readonly) CGFloat minX;
@property (nonatomic, readonly) CGFloat midX;
@property (nonatomic, readonly) CGFloat maxX;
@property (nonatomic, readonly) CGFloat minY;
@property (nonatomic, readonly) CGFloat midY;
@property (nonatomic, readonly) CGFloat maxY;

@end
