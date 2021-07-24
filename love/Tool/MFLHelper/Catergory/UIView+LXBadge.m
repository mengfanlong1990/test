//
//  UIView+LXBadge.m
//  linktrustEduStudent
//
//  Created by mengyueping on 2017/5/17.
//  Copyright © 2017年 linktrust. All rights reserved.
//

#import "UIView+LXBadge.h"
#import <objc/runtime.h>

static char badgeViewKey;
static NSInteger const pointWidth = 6; //小红点的宽高
static NSInteger const rightRange = 10; //距离控件右边的距离
static CGFloat const badgeFont = 9;    //字体的大小

@implementation UIView (LXBadge)

#pragma mark - 接口

/**
 *  显示小红点
 */
- (void)showBadge
{
    if (self.badge == nil) {
        CGRect frame = CGRectMake(CGRectGetWidth(self.frame)- pointWidth - rightRange, rightRange, pointWidth, pointWidth);
        
        self.badge = [[UILabel alloc] initWithFrame:frame];
        self.badge.backgroundColor = [UIColor redColor];
        self.badge.layer.masksToBounds = YES;
        self.badge.layer.cornerRadius = pointWidth / 2;
        
        [self addSubview:self.badge];
        [self bringSubviewToFront:self.badge];
    }
}

/**
 * 显示几个小红点儿
 * parameter redCount 小红点儿个数
 */
- (void)showBadgeWithCount:(NSInteger)redCount
{
    if (redCount < 0) {
        return;
    }
    
    [self showBadge];
    self.badge.textColor = [UIColor whiteColor];
    self.badge.font = [UIFont systemFontOfSize:badgeFont];
    self.badge.textAlignment = NSTextAlignmentCenter;
    self.badge.text = (redCount > 99 ? [NSString stringWithFormat:@"99+"] : [NSString stringWithFormat:@"%@", @(redCount)]);
    [self.badge sizeToFit];
    
    CGRect frame = self.badge.frame;
    frame.size.width += 4;
    frame.size.height += 4;
    frame.origin.y = -frame.size.height / 2;
    
    if (CGRectGetWidth(frame) < CGRectGetHeight(frame)) {
        frame.size.width = CGRectGetHeight(frame);
    }
    self.badge.frame = frame;
    self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 2;
}

/**
 *  隐藏小红点
 */
- (void)hidenBadge
{
    if (self.badge != nil) {
        [self.badge removeFromSuperview];
        self.badge = nil;        
    }
}

#pragma mark - runtime GetterAndSetter

- (UILabel *)badge
{
    //通过runtime创建一个UILabel的属性
    return objc_getAssociatedObject(self, &badgeViewKey);
}

- (void)setBadge:(UILabel *)badge
{
    objc_setAssociatedObject(self, &badgeViewKey, badge, OBJC_ASSOCIATION_RETAIN);
}


@end
