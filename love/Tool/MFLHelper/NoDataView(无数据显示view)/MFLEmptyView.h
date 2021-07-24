//
//  MFLEmptyView.h
//  AiKline
//
//  Created by mengfl on 16/9/7.
//  Copyright © 2016年 YJNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TapViewBlock)();
@interface MFLEmptyView : UIView
/** 空内容图片 */
@property (nonatomic,strong) NSString *emptyImageName;
/** 空内容文字说明 */
@property (nonatomic,strong) NSString *emptyLabelText;

@property (weak, nonatomic) IBOutlet UIImageView *emptyImageView;
@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;

/** 敲击视图要做的事 */
- (void)tapViewTodo:(TapViewBlock)tapViewTodo;

+ (instancetype)emptyView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *offCenterY;
@property (assign, nonatomic) BOOL isReLoad;//是否是重新加载视图
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerYOffset;

@end
