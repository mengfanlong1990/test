//
//  xibV.m
//  love
//
//  Created by mfl on 2021/6/19.
//  Copyright © 2021 love. All rights reserved.
//

#import "xibV.h"
static id instance = nil;
@interface xibV()

@end

@implementation xibV

#pragma --单例--常规实现--
+(instancetype)getInstance{
    if (instance==nil) {
        instance = [[xibV alloc]init];
    }
    return instance;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (instance==nil) {
        instance = [super allocWithZone:zone];
    }
    return instance;
    
}
-(id)copyWithZone:(struct _NSZone *)zone{
    return instance;
}
#pragma --单例--GCD方式的单例--
//+(instancetype) getInstance{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[self alloc]init];
//    });
//    return instance;
//}
//+(instancetype)allocWithZone:(struct _NSZone *)zone
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken,
//                  instance = [super allocWithZone:zone];
//                  );
//    return instance;
//
//}
#pragma ----冒号排序--C语言--
-(void)sort_mp:(NSArray *)array{
    NSMutableArray * mArray = [[NSMutableArray alloc] initWithArray:array];
    int i , j = 0;
    for ( i =0; i<mArray.count-1; i++) {
        for ( j = 0; j<mArray.count-1-i; j++) {
            if (mArray[j]>mArray[j+1]) {
                id temp =mArray[j+1];
                mArray[j+1] = mArray[j];
                mArray[j] = temp;
            }
        }
    }
}
#pragma ----冒号排序--OC语言--时间复杂度应为O(n^2)
-(NSArray *)bubbleSortWithArray:(NSArray *)array
{
    NSMutableArray * mArray = [[NSMutableArray alloc] initWithArray:array];
    NSUInteger arrayLength = mArray.count;
    int i,j,times = 0;
    for (i = 0; i < arrayLength - 1; i++) {
        for (j = 0; j < arrayLength - 1 - i; j++) {
            if ([[mArray objectAtIndex:j]integerValue] > [[mArray objectAtIndex:(j + 1)]integerValue]) {
                id temp = [mArray objectAtIndex:j];
                [mArray replaceObjectAtIndex:j withObject:[mArray objectAtIndex:(j + 1)]];
                [mArray replaceObjectAtIndex:(j + 1) withObject:temp];
            }
            times ++;
        }
    }
    NSLog(@"循环次数:%d",times);
    return mArray;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.ce.constant = -100;
    
    NSArray * array = @[@8,@1,@14,@23,@5,@9,@7,@4];
    NSArray * bubbleSortAttay = [self bubbleSortWithArray:array];
    NSLog(@"原数组:%@\n排序后的数组:%@",array,bubbleSortAttay);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
