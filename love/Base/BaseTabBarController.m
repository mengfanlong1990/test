//
//  BaseTabBarController.m
//  yyhouse
//
//  Created by 刘佳 on 2017/11/27.
//  Copyright © 2017年 RenJiZiding. All rights reserved.
//

#import "BaseTabBarController.h"
#import "CostomTabBar.h"
@interface BaseTabBarController ()<costomProtocol>

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setValue:[[CostomTabBar alloc] init] forKey:@"tabBar"];
    
   

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated   ];
  
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate{
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}
@end






