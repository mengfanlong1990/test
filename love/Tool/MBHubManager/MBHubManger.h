//
//  MBHubManger.h
//  CarLink
//
//  Created by 刘佳 on 16/9/22.
//  Copyright © 2016年 星河车送. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MBHubManger : NSObject
+(instancetype)manager;
-(void)showStatus;
-(void)dismissStatus;
-(void)showHint:(NSString *)hint;
-(void)showStatusWithContent:(NSString *)conten;

//视频详情页专供蒙版

-(void)showHubVideoWithTip:(NSString *)tip InView:(UIView *)view;
-(void)dismissVideoWithTip;

//网络不好的状态栏
-(void)showBadNetWithTip;
@end


@interface BadNetBar:UIView
@end
