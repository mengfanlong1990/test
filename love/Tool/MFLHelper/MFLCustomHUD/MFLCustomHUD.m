//
//  MFLCustomHUD.m
//  MomBaby
//
//  Created by rjzd on 2018/6/20.
//  Copyright © 2018年 RenJiZiding. All rights reserved.
//

#import "MFLCustomHUD.h"
#import <MBProgressHUD.h>
@interface MFLCustomHUD()<MBProgressHUDDelegate>
{
    MBProgressHUD *_hud;
}
@end
@implementation MFLCustomHUD

+ (instancetype)showCustomHudText:(NSString *)text textColor:(UIColor *)color InView:(UIView *)view
{
    MFLCustomHUD * hud = [[MFLCustomHUD alloc] initWithView:view];
    hud.text = text;
    
    hud.textColor = color;
    
    [hud animationShow:YES];
    
    return hud;
}

- (instancetype)initWithView:(UIView *)view
{
    if (view == nil) {
        return nil;
    }
    self = [super init];
    if (self) {
        
        //自定义view
        _hud = [[MBProgressHUD alloc] initWithView:view];
        _hud.delegate = self;
        _hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        _hud.bezelView.color = [UIColor clearColor];
        _hud.backgroundView.color = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [view addSubview:_hud];
    }
    return self;
}

- (void)animationShow:(BOOL)show
{
    if (_text != nil && _text.length != 0) {
        _hud.label.text = _text;
    }
    if (_textColor) {
        _hud.label.textColor = _textColor;
    }
    UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW*50 , kScreenH*50)];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    
    for(int i = 1; i < 5 ; i++){
        NSString *imgName = [NSString stringWithFormat:@"hud%d",i];
        
        [imageArray addObject:[UIImage imageNamed:imgName]];
    }
    
    images.animationDuration = .6;
    
    images.animationImages = imageArray;
    // 开始播放
    [images startAnimating];
    
    //自定义
    _hud.mode = MBProgressHUDModeCustomView;
    
    _hud.delegate = self;
    
    _hud.customView = images;
    
    [_hud showAnimated:show];
}
- (void)hide:(BOOL)hide
{
    [_hud hideAnimated:hide];
    [_hud removeFromSuperview];
    _hud = nil;

}
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [_hud removeFromSuperview];
    
    _hud = nil;
}

@end
