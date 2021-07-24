//
//  UIView+LXExtension.m
//  addChildViewController
//
//  Created by heartjhl on 16/12/6.
//  Copyright © 2016年 heartjhl. All rights reserved.
//

#import "UIView+LXExtension.h"

@implementation UIView (LXExtension)

- (void)LXCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius=cornerRadius;
    self.layer.masksToBounds=YES;
}

- (void)LXborderColor:(UIColor *)color andWidth:(CGFloat)width
{
    self.layer.borderColor=color.CGColor;
    self.layer.borderWidth=width;
}

#pragma mark - view 抖动
-(void)LX_setViewJitter {
    // 获取到当前的View
    CALayer *viewLayer = self.layer;
    
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 5, position.y);
    
    CGPoint y = CGPointMake(position.x - 5, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    
    // 设置自动反转
    [animation setAutoreverses:YES];
    
    // 设置时间
    [animation setDuration:.05];
    
    // 设置次数
    [animation setRepeatCount:2];
    
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
    
}

- (UIViewController *)viewRootViewController {
    // 下一个响应者
    id next = [self nextResponder];
    do {
        // 当下一个响应者派生自ViewController
        if ([next isKindOfClass:[UIViewController class]]) {
            return next;
        }
        next = [next nextResponder];
    } while (next);
    return nil;
}

/************* X ****************/
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x {
    return self.frame.origin.x;
}

/************* Y ****************/
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y {
    return self.frame.origin.y;
}

/************* width ****************/
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width {
    return self.frame.size.width;
}

/************* height ****************/
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height {
    return self.frame.size.height;
}

/************* size ****************/
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}

/************* origin ****************/
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin {
    return self.frame.origin;
}

/************* centerX ****************/
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX {
    return self.center.x;
}

/************* centerY ****************/
- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY {
    return self.center.y;
}


/************* minX ****************/
- (CGFloat)minX {
    return CGRectGetMinX(self.frame);
}

/************* midX ****************/
- (CGFloat)midX {
    return CGRectGetMidX(self.frame);
}

/************* maxX ****************/
- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

/************* minY ****************/
- (CGFloat)minY {
    return CGRectGetMinY(self.frame);
}

/************* midY ****************/
- (CGFloat)midY {
    return CGRectGetMidY(self.frame);
}

/************* maxY ****************/
- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}


@end
