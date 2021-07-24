//
//  UIImage+Extension.h
//  yyhouse
//
//  Created by 刘佳 on 2017/11/10.
//  Copyright © 2017年 RenJiZiding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
-(UIImage*)scaleToSize:(CGSize)size;
-(NSData *)zoomImageWithSizeRatio:(CGFloat)ratio LimitQuality:(CGFloat)limit;
- (NSData *)compressionQualityToLimit:(CGFloat)limit; //limit 限制多大的视图 单位kb
@end
