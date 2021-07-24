//
//  CostomTabBar.h
//  yyhouse
//
//  Created by 刘佳 on 2017/11/27.
//  Copyright © 2017年 RenJiZiding. All rights reserved.
//
@protocol costomProtocol <NSObject>
-(void)costomClickCenter:(UIButton *)btn;
@end
#import <UIKit/UIKit.h>

@interface CostomTabBar : UITabBar
@property (nonatomic,weak)id <costomProtocol>delegate;
@end
