//
//  UIView+LXBadge.h
//  linktrustEduStudent
//
//  Created by mengyueping on 2017/5/17.
//  Copyright © 2017年 linktrust. All rights reserved.
//
/*
 *  小红点功能
 */

#import <UIKit/UIKit.h>

@interface UIView (LXBadge)
/**
 *  通过创建label，显示小红点；
 */
@property (nonatomic, strong) UILabel *badge;

/**
 *  显示小红点
 */
- (void)showBadge;

/**
 * 显示几个小红点儿
 * parameter redCount 小红点儿个数
 */
- (void)showBadgeWithCount:(NSInteger)redCount;

/**
 *  隐藏小红点
 */
- (void)hidenBadge;

@end
