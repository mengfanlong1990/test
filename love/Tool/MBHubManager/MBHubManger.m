//
//  MBHubManger.m
//  CarLink
//
//  Created by 刘佳 on 16/9/22.
//  Copyright © 2016年 星河车送. All rights reserved.
//

#import "MBHubManger.h"
#import <MBProgressHUD/MBProgressHUD.h>
static MBProgressHUD *Hub ;
static UIWindow *hubWindow;
static MBProgressHUD *HubVideo;
static BadNetBar *badNetBar;


@interface MBHubManger()
@property (nonatomic,assign)BOOL isShowingBadNet;
@end
@implementation MBHubManger
+(instancetype)manager{
    static MBHubManger *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
        Hub = [[MBProgressHUD alloc]init];
        Hub.frame = CGRectMake(0, 64, ScreenBounds.size.width, ScreenBounds.size.height);
//        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:Hub];
//        Hub.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        Hub.removeFromSuperViewOnHide = YES;
        
        HubVideo = [[MBProgressHUD alloc]init];
        HubVideo.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        HubVideo.bezelView.color = [UIColor clearColor];
        HubVideo.label.font = Font(13);
        HubVideo.label.textColor = [UIColor whiteColor];
        [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
        HubVideo.removeFromSuperViewOnHide = YES;
        
        //没有网络
      
        CGFloat margin = 15;
        CGFloat height = 35;
        CGFloat y = isiPhoneX ? 44:20;
        badNetBar = [[BadNetBar alloc]initWithFrame:CGRectMake(margin, y, ScreenBounds.size.width - margin *2, height)];

       

    });
    return sharedAccountManagerInstance;
   
}
-(void)showStatus{
    
    [[UIApplication sharedApplication].keyWindow addSubview:Hub];

    Hub.mode=MBProgressHUDModeIndeterminate;
    Hub.label.text = @"";
    dispatch_async(dispatch_get_main_queue(), ^{
        

    [Hub showAnimated:YES];
    });
}
-(void)showStatusWithContent:(NSString *)content{
    [[UIApplication sharedApplication].keyWindow addSubview:Hub];
    
    Hub.mode=MBProgressHUDModeIndeterminate;
    Hub.label.text = content;
    dispatch_async(dispatch_get_main_queue(), ^{
            [Hub showAnimated:YES];
    });

}
-(void)dismissStatus{
    dispatch_async(dispatch_get_main_queue(), ^{
        
    [Hub hideAnimated:NO afterDelay:0];
    });
    
}
-(void)showHint:(NSString *)hint{
    [[UIApplication sharedApplication].keyWindow addSubview:Hub];
    Hub.mode = MBProgressHUDModeText;
    Hub.label.text = hint;
    dispatch_async(dispatch_get_main_queue(), ^{
    [Hub showAnimated:YES];
    [Hub hideAnimated:NO afterDelay:1];
    });
}


-(void)showHubVideoWithTip:(NSString *)tip InView:(UIView *)view{
    [view addSubview:HubVideo];
    HubVideo.frame = CGRectMake(50, view.frame.size.height/2 - 100, view.frame.size.width-100, 200);

    HubVideo.mode = MBProgressHUDModeIndeterminate;
    HubVideo.label.text = tip;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [HubVideo showAnimated:YES];
    });
}
-(void)dismissVideoWithTip{
    dispatch_async(dispatch_get_main_queue(), ^{
        [HubVideo hideAnimated:NO];

    });
}

-(void)showBadNetWithTip{
    if (self.isShowingBadNet == YES) {
        return;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:badNetBar];
    CGFloat margin = 15;
    CGFloat height = 35;
    CGFloat y = isiPhoneX ? 44:20;
    badNetBar.alpha = 0;
    self.isShowingBadNet = YES;
    [UIView animateWithDuration:0.3 animations:^{
        badNetBar.alpha = 1;
        badNetBar.frame = CGRectMake(margin, y +50, ScreenBounds.size.width- margin *2, height);
    }completion:^(BOOL finished) {
        
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            
            badNetBar.alpha = 0;
             badNetBar.frame = CGRectMake(margin, y, ScreenBounds.size.width - margin *2, height);
        }completion:^(BOOL finished) {
            self.isShowingBadNet = NO   ;
        }];
    });
    
}


@end

@interface BadNetBar()
@property (nonatomic,weak)UILabel *tipLabel;
@end
@implementation BadNetBar
-(instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}

-(void)initUI{
  
    self.userInteractionEnabled = NO;
    UILabel *tipLabel = [[UILabel alloc]init];
    [self addSubview:tipLabel];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = Font(13);
    [self addSubview:tipLabel];
    self.tipLabel = tipLabel;
    [tipLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        
    }];
    tipLabel.text = @"当前无网络，请检查网络设置";
    tipLabel.textAlignment = NSTextAlignmentCenter  ;
    self.backgroundColor = MainColor;
    self.layer.cornerRadius = 4;
    self.clipsToBounds = YES;
    
    
}
@end
