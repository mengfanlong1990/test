//
//  UIView+UIViewRoundCorners.h
//  yyhouse
//
//  Created by rjzd on 2018/3/13.
//  Copyright © 2018年 RenJiZiding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewRoundCorners)
//高效设置圆角
- (void)t_addRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius;
@end
