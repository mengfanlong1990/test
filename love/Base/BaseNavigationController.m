//
//  BaseNavigationController.m
//  yyhouse
//
//  Created by 刘佳 on 2017/10/30.
//  Copyright © 2017年 RenJiZiding. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(babyStateChange:) name:BABYSTATECHANGESUCCESS object:nil];
    self.navigationBar.tintColor = [UIColor colorWithWhite:55.0/256.0 alpha:1];
    self.navigationBar.barTintColor = MainColor;
    
}

-(void)babyStateChange:(NSNotification *)note//状态改变通知
{

//    NSString * state = [note.userInfo objectForKey:@"babyStatus"];
//    if ([state isEqualToString:@"1"]) {
//        self.navigationBar.barTintColor = CGreen;
//    }else{
//       self.navigationBar.barTintColor = GGreen;
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter&getter
-(BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}
@end
