//
//  ViewController.m
//  yyf
//
//  Created by 人济紫顶 on 2017/8/14.
//  Copyright © 2017年 人济紫顶. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^guidePageBlock)(void);

@interface YYFGuidePage : UIView

///引导页
-(instancetype)initWithFrame:(CGRect)frame withImagesArray:(NSArray *)imagesArray getIntoMainView:(void(^)())handlerBlock;


@end
