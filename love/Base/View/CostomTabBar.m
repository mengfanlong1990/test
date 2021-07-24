//
//  CostomTabBar.m
//  yyhouse
//
//  Created by 刘佳 on 2017/11/27.
//  Copyright © 2017年 RenJiZiding. All rights reserved.
//

#import "CostomTabBar.h"
//#import "UIImage+YYWebImage.h"
@interface CostomTabBar()
@property (nonatomic, strong) UIButton *centerBtn;
@end

@implementation CostomTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = [UIColor greenColor];
        self.backgroundColor = [UIColor clearColor];
        
        if (ScreenBounds.size.width *ScreenScale == 1125) {
            self.backgroundImage = [UIImage imageNamed:@"tabBarX"];
        }else if(ScreenBounds.size.width *ScreenScale == 640){
            self.backgroundImage = [UIImage imageNamed:@"tab640"];
        }
        else{
        self.backgroundImage = [UIImage imageNamed:@"TabBg"];
        }

//        self.shadowImage = [UIImage yy_imageWithColor:[UIColor clearColor] size:CGSizeMake(ScreenBounds.size.width , 1)];
    }
    return self;
}
- (UIButton *)centerBtn
{
    if (_centerBtn == nil) {
        _centerBtn = [[UIButton alloc] init];
        [_centerBtn setImage:[UIImage imageNamed:@"TabCenter"] forState:UIControlStateNormal];
//        [_centerBtn setTitle:@"发布" forState:UIControlStateNormal];
        
        [_centerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [_centerBtn addTarget:self action:@selector(clickCenterBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_centerBtn sizeToFit];
        [self addSubview:_centerBtn];
    }
    return _centerBtn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 把 tabBarButton 取出来（把 tabBar 的 subViews 打印出来就明白了）
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonArray addObject:view];
        }
                   
        }
    
    
    CGFloat barWidth = self.bounds.size.width;
    CGFloat barHeight = self.bounds.size.height;
    CGFloat centerBtnWidth = CGRectGetWidth(self.centerBtn.frame);
    CGFloat centerBtnHeight = CGRectGetHeight(self.centerBtn.frame);
    UIView *tabBaritem = tabBarButtonArray.firstObject;
    // 设置中间按钮的位置，居中，凸起一丢丢
    self.centerBtn.center = CGPointMake(barWidth / 2,tabBaritem.center.y - 18.5);
    // 重新布局其他 tabBarItem
    // 平均分配其他 tabBarItem 的宽度
    CGFloat barItemWidth = (barWidth - centerBtnWidth) / tabBarButtonArray.count;
    // 逐个布局 tabBarItem，修改 UITabBarButton 的 frame
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGRect frame = view.frame;
        if (idx >= tabBarButtonArray.count / 2) {
            // 重新设置 x 坐标，如果排在中间按钮的右边需要加上中间按钮的宽度
            frame.origin.x = idx * barItemWidth + centerBtnWidth;
        } else {
            frame.origin.x = idx * barItemWidth;
        }
        // 重新设置宽度
        frame.size.width = barItemWidth;
        view.frame = frame;
    }];
    // 把中间按钮带到视图最前面
    [self bringSubviewToFront:self.centerBtn];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    // 如果事件发生在 tabbar 里面直接返回
    if (result) {
        return result;
    }
    // 这里遍历那些超出的部分就可以了，不过这么写比较通用。
    for (UIView *subview in self.subviews) {
        // 把这个坐标从tabbar的坐标系转为 subview 的坐标系
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        // 如果事件发生在 subView 里就返回
        if (result) {
            return result;
        }
    }
    return nil;
}
-(void)clickCenterBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(costomClickCenter: )]) {
        [self.delegate costomClickCenter:btn];
    }
    
}

@end
