//
//  UIImage+Extension.m
//  yyhouse
//
//  Created by 刘佳 on 2017/11/10.
//  Copyright © 2017年 RenJiZiding. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
-(UIImage*)scaleToSize:(CGSize)size
{
//    // 先缩放
//    UIGraphicsBeginImageContext(size);
//    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    // 返回新的改变大小后的图片
//    return scaledImage;
    if([[UIScreen mainScreen] scale] == 2.0){
         UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
        
    }else if([[UIScreen mainScreen] scale] == 3.0){
          UIGraphicsBeginImageContextWithOptions(size, NO, 3.0);
    }
    else{                UIGraphicsBeginImageContext(size);        }
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();        // 使当前的context出堆栈
    UIGraphicsEndImageContext();        // 返回新的改变大小后的图片
    return scaledImage;
    
    
}

- (NSData *)compressionQualityToFixed {
    CGFloat limitedBytes = 150.0;
    NSData *imageData = UIImageJPEGRepresentation(self, 1.0);
    if (imageData.length>limitedBytes*1024) {
        // 处理长图
        CGFloat rate = MAX(self.size.width, self.size.height)/MIN(self.size.width, self.size.height);
        limitedBytes *= rate;
    }
    return [self compressionQualityToLimit:limitedBytes];
}



- (NSData *)compressionQualityToLimit:(CGFloat)limit {
    UIImage *img = self;
    CGFloat compression = 0.99f;
    CGFloat maxCompression = 0.1f;
    NSInteger maxFileSize = limit*1024;
    
    NSData *imageData = UIImageJPEGRepresentation(img, compression);
    
    while ([imageData length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(img, compression);
    }
    
    return imageData;
    
}
-(NSData *)zoomImageWithSizeRatio:(CGFloat)ratio LimitQuality:(CGFloat)limit{
    
    
    UIImage *img = self;
    CGSize size = img.size;
    CGFloat width = CGRectGetWidth(ScreenBounds)*ScreenScale;
    CGSize zoomSize = CGSizeMake(size.width *ratio, size.height *ratio);
    if (zoomSize.width >width) {
        zoomSize.height = width/ zoomSize.width  *zoomSize.height;
        zoomSize.width = width;
        
    }
    
    UIImage *scaleImage = [self scaleToSize:zoomSize];
    NSData *data = [scaleImage compressionQualityToLimit:limit];
    NSLog(@"%ld",data.length);
    return data;
    
}
@end
