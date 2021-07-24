//
//  MFLDatePickerView.h
//  MomBaby
//
//  Created by rjzd on 2018/6/5.
//  Copyright © 2018年 RenJiZiding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFLDatePickerView : UIView

/*三列日期数据*/
/**
 初始化方法，带年月日的日期选择

 @param block 返回选中的日期
 @return MFLDatePickerView对象
 */
- (instancetype)initDatePackerToAssign:(NSArray *)toAssignArr WithResponse:(void(^)(NSString*))block;

/*一列外部数据*/
/**
 初始化方法，根据传递参数选择
 @param dataSource 外界传递数据
 @param toAssign 到指定"toAssign"的位置
 @param block 返回选中的参数
 @return MFLDatePickerView对象
 */
- (instancetype)initYearPickerViewWith:(NSMutableArray *)dataSource toAssign:(NSString *)toAssign WithResponse:(void(^)(NSString*))block;


/*两列外部location数据*/
/**
 初始化方法，根据传递参数选择
 @param dataSource 外界传递数据
 @param toAssignDic 到指定dic的位置
 @param block 返回选中的参数
 @return MFLDatePickerView对象
 */
- (instancetype)initMorePickerViewWith:(NSMutableArray *)dataSource toRegionAssign:(NSDictionary *)toAssignDic WithResponse:(void(^)(NSString*))block;
/**
 显示方法
 */
- (void)show;
//@property (nonatomic,strong) NSArray * toTimeArray;
//@property (nonatomic,strong) NSString * baseContentToRow;

@end
