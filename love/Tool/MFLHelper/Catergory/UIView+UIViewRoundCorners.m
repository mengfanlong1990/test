//
//  UIView+UIViewRoundCorners.m
//  yyhouse
//
//  Created by rjzd on 2018/3/13.
//  Copyright © 2018年 RenJiZiding. All rights reserved.
//

#import "UIView+UIViewRoundCorners.h"

@implementation UIView (UIViewRoundCorners)
- (void)t_addRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}
@end
