//
//  MFLCustomHUDManager.m
//  MomBaby
//
//  Created by rjzd on 2018/7/5.
//  Copyright © 2018年 RenJiZiding. All rights reserved.
//

#import "MFLCustomHUDManager.h"
#import "MFLCustomHUD.h"
@interface MFLCustomHUDManager()
@property (nonatomic, strong)  MFLCustomHUD* hud;
@end

@implementation MFLCustomHUDManager
+(instancetype)defaultMFLCustomHUDManager{
    static MFLCustomHUDManager * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[MFLCustomHUDManager alloc]init];
        
    });
    return _manager;
}

-(void)showHud{
    _hud = [MFLCustomHUD showCustomHudText:@"" textColor:[UIColor clearColor] InView:[UIApplication sharedApplication].keyWindow];
}
-(void)hidenHud
{
    for (id view in [[UIApplication sharedApplication].keyWindow subviews]) {
        [view isKindOfClass:[MFLCustomHUD class]];[_hud hide:YES];
    }
    
}
@end
