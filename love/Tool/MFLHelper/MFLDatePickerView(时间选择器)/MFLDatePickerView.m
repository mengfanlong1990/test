//
//  MFLDatePickerView.m
//  MomBaby
//
//  Created by rjzd on 2018/6/5.
//  Copyright © 2018年 RenJiZiding. All rights reserved.
//

#import "MFLDatePickerView.h"
#import "AppDelegate.h"

@interface MFLDatePickerView () <UIPickerViewDataSource,UIPickerViewDelegate>{
    UIView *contentView;
    void(^backBlock)(NSString *);
    
    NSMutableArray *yearArray;
    NSMutableArray *monthArray;
    NSMutableArray *dayArray;
    
    NSInteger currentYear;
    NSInteger currentMonth;
    NSInteger currentDay;
    
    NSString *restr;
    
    NSString *selectedYear;
    NSString *selectecMonth;
    NSString *selectecDay;
    
    BOOL onlyOneSelect;
    BOOL isMoreSelect;
    NSMutableArray *outDataSource;
    NSString *selectedData;
    
    NSString *selectedRegion;
    NSString *selectedCity;
    NSMutableArray *regionArray;
    NSMutableArray *cityArray;
    NSInteger selectRegionIndex;
    NSInteger selectCityIndex;
    
    NSString *toAssignRow;//外界传递的到指定的字符串的row
    NSArray *toAssignArray;//外界传递的到指定时间的row
    NSDictionary *toAssignDictionary;//外界传递的到指定地点的row
}


@end

@implementation MFLDatePickerView

#pragma mark - initDatePickerView
/**
 初始化方法，带年月日的日期选择
 
 @param block 返回选中的日期
 @return MFLDatePickerView对象
 */
- (instancetype)initDatePackerToAssign:(NSArray *)toAssignArr WithResponse:(void(^)(NSString*))block{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
    }
    onlyOneSelect = NO;
    isMoreSelect = NO;
    toAssignArray = toAssignArr;
    [self setViewInterface];
    if (block) {
        backBlock = block;
    }
    
    return self;
}

/**
 初始化方法，根据传递参数选择
 
 @param block 返回选中的参数
 @return MFLDatePickerView对象
 */
- (instancetype)initYearPickerViewWith:(NSMutableArray *)dataSource toAssign:(NSString *)toAssign WithResponse:(void(^)(NSString*))block{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
    }
    onlyOneSelect = YES;
    isMoreSelect = NO;
    outDataSource = dataSource;
    toAssignRow = toAssign;
    [self setViewInterface];
    if (block) {
        backBlock = block;
    }

    return self;
}

/*多列外部数据*/
/**
 初始化方法，根据传递参数选择
 @param dataSource 外界传递数据
 @param toAssignDic 到指定dic的位置
 @param block 返回选中的参数
 @return MFLDatePickerView对象
 */
- (instancetype)initMorePickerViewWith:(NSMutableArray *)dataSource toRegionAssign:(NSDictionary *)toAssignDic WithResponse:(void(^)(NSString*))block
{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
    }
    onlyOneSelect = YES;
    isMoreSelect = YES;
    regionArray =[NSMutableArray array];
    cityArray =[NSMutableArray array];
    selectRegionIndex = 0;
    selectCityIndex = 0;
    outDataSource = dataSource;
    for (NSDictionary *dic in dataSource) {
        [regionArray addObject:[dic objectForKey:@"name"]?:@""];
        [cityArray addObject:[dic objectForKey:@"city"]?:@[]];
    }
    selectedRegion = [regionArray objectAtIndex:0];
    selectedCity = [[cityArray objectAtIndex:selectRegionIndex]objectAtIndex:0];
    toAssignDictionary = toAssignDic;
    [self setViewInterface];
    if (block) {
        backBlock = block;
    }
    
    return self;
}



#pragma mark - Configuration
- (void)setViewInterface {
    
    [self getCurrentDate];
    
    [self setYearArray];
    
    [self setMonthArray];
    
    [self setDayArray];
    
    
    //设置背景颜色为黑色，并有0.4的透明度
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    UIControl *control = [[UIControl alloc] init];
    [self addSubview:control];
    [control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    [control addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 300)];
    [self addSubview:contentView];


    //添加白色view
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:whiteView];
    //添加确定和取消按钮
    for (int i = 0; i < 2; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 60) * i, 0, 60, 40)];
        [button setTitle:i == 0 ? @"取消" : @"确定" forState:UIControlStateNormal];
        if (i == 0) {
            [button setTitleColor:MainColor forState:UIControlStateNormal];
        } else {
            [button setTitleColor:MainColor forState:UIControlStateNormal];
        }
        [whiteView addSubview:button];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10 + i;
    }
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.bounds), 260)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.backgroundColor = [UIColor colorWithRed:240.0/255 green:243.0/255 blue:250.0/255 alpha:1];
    
    //设置pickerView默认选中当前时间
    if (!onlyOneSelect) {
        if ([toAssignArray count]>0&&[toAssignArray count]==3) {
            selectedYear =[toAssignArray firstObject];
            selectecMonth =toAssignArray[1];
            selectecDay =toAssignArray[2];
            NSInteger yearIndex = [yearArray indexOfObject:selectedYear];
            NSInteger monthIndex = [monthArray indexOfObject:selectecMonth];
            NSInteger dayIndex = [dayArray indexOfObject:selectecDay];
            if (yearIndex>=0&&yearIndex<[yearArray count]) {
               [pickerView selectRow:yearIndex inComponent:0 animated:YES];
            }else{
                [pickerView selectRow:[selectedYear integerValue] - 1970 inComponent:0 animated:YES];
            }
            if (monthIndex>=0&&monthIndex<[monthArray count]) {
                [pickerView selectRow:monthIndex inComponent:1 animated:YES];
            }else{
                [pickerView selectRow:[selectecMonth integerValue] - 1 inComponent:1 animated:YES];
            }
            if (dayIndex>=0&&dayIndex<[dayArray count]) {
                [pickerView selectRow:dayIndex inComponent:2 animated:YES];
            }else{
                [pickerView selectRow:[selectecDay integerValue] -1 inComponent:2 animated:YES];
            }

            
        }else{
            [pickerView selectRow:[selectedYear integerValue] - 1970 inComponent:0 animated:YES];
            [pickerView selectRow:[selectecMonth integerValue] - 1 inComponent:1 animated:YES];
            [pickerView selectRow:[selectecDay integerValue] -1 inComponent:2 animated:YES];
        }
       
    }else{
        if (!isMoreSelect) {//单列
            if ([toAssignRow length]>0) {
                NSInteger index = [outDataSource indexOfObject:toAssignRow];
                if (index>=0&&index<[outDataSource count]) {
                    selectedData = toAssignRow;
                    [pickerView selectRow:index inComponent:0 animated:YES];
                }else{
                    [pickerView selectRow:0 inComponent:0 animated:YES];
                }
                
            }else{
                [pickerView selectRow:0 inComponent:0 animated:YES];
            }
        }else{//两列
            if ([toAssignDictionary count]>0) {
                NSString * regionStr =[toAssignDictionary objectForKey:@"name"];
                NSString * cityStr =[toAssignDictionary objectForKey:@"city"];
                for (int i = 0; i<[regionArray count]; i++) {
                    if ([regionStr isEqualToString:[regionArray objectAtIndex:i]]) {
                        selectRegionIndex =i;
                    }
                    for (int j = 0; j< [[[outDataSource objectAtIndex:i]objectForKey:@"city"]count] ;j++ ) {
                        NSArray * cityA =[[outDataSource objectAtIndex:i]objectForKey:@"city"];
                        if ([cityStr isEqualToString:[cityA objectAtIndex:j]]) {
                            selectCityIndex = j;
                        }
                    }
                }
                [pickerView selectRow:selectRegionIndex inComponent:0 animated:YES];
                [pickerView selectRow:selectCityIndex inComponent:1 animated:YES];
            }else{
                selectRegionIndex = 0;
                selectCityIndex = 0;
            }
        }
       
        
    }
    
    [contentView addSubview:pickerView];
}

- (void)getCurrentDate {
    //获取当前时间 （时间格式支持自定义）
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];//自定义时间格式
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    //拆分年月成数组
    NSArray *dateArray = [currentDateStr componentsSeparatedByString:@"-"];
    if (dateArray.count == 3) {//年 月 日
        currentYear = [[dateArray firstObject]integerValue];
        currentMonth = [dateArray[1] integerValue];
        currentDay =  [dateArray[2] integerValue];
    }
    selectedYear = [NSString stringWithFormat:@"%ld",(long)currentYear];
    selectecMonth = [NSString stringWithFormat:@"%02ld",(long)currentMonth];
    selectecDay = [NSString stringWithFormat:@"%02ld",(long)currentDay];
}

- (void)setYearArray {
    //初始化年数据源数组
    yearArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 1970; i <= currentYear+1 ; i++) {
        NSString *yearStr = [NSString stringWithFormat:@"%ld",(long)i];
        [yearArray addObject:yearStr];
    }
}

- (void)setMonthArray {
    //初始化月数据源数组
    monthArray = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 1 ; i <= 12; i++) {
        NSString *monthStr = [NSString stringWithFormat:@"%02ld",(long)i];
        [monthArray addObject:monthStr];
    }
}
- (void)setDayArray {
    //初始化日数据源数组
    [self DaysfromYear:[selectedYear integerValue]  andMonth:[selectecMonth integerValue]];
}
#pragma mark - tools
//通过年月求每月天数
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;
    
    BOOL isrunNian = num_year%4==0 ? (num_year%100==0? (num_year%400==0?YES:NO):YES):NO;
    switch (num_month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
            [self setdayArray:31];
            return 31;
        }
        case 4:case 6:case 9:case 11:{
            [self setdayArray:30];
            return 30;
        }
        case 2:{
            if (isrunNian) {
                [self setdayArray:29];
                return 29;
            }else{
                [self setdayArray:28];
                return 28;
            }
        }
        default:
            break;
    }
    return 0;
}
//设置每月的天数数组
- (void)setdayArray:(NSInteger)num
{
    if (!dayArray) {
        dayArray = [NSMutableArray array];
    }
    [dayArray removeAllObjects];
    for (int i=1; i<=num; i++) {
        [dayArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
}
#pragma mark - Actions
- (void)buttonTapped:(UIButton *)sender {
    if (sender.tag == 10) {
        [self dismiss];
    } else {
        if (onlyOneSelect) {
            if (isMoreSelect) {
//                NSDictionary * dic =[outDataSource objectAtIndex:0];
//                restr =  [selectedDic length]<=0?([outDataSource count]>0?[[dic objectForKey:@"name"] stringByAppendingString:[[dic objectForKey:@"city"]objectAtIndex:0]]:@""):selectedDic;
                restr = [[selectedRegion?:@"" stringByAppendingString:@"-"] stringByAppendingString:selectedCity?:@""];
            }else{
                 restr = [selectedData length]<=0?([outDataSource count]>0?outDataSource[0]:@""):selectedData;
            }
           
        } else {
            restr = [NSString stringWithFormat:@"%@年%@月%@日",selectedYear,selectecMonth,selectecDay];
        }
        backBlock(restr);
        [self dismiss];
    }
}

#pragma mark - pickerView出现
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.4 animations:^{
        contentView.center = CGPointMake(self.frame.size.width/2, contentView.center.y - contentView.frame.size.height);
    }];
}
#pragma mark - pickerView消失
- (void)dismiss{
    
    [UIView animateWithDuration:0.4 animations:^{
        contentView.center = CGPointMake(self.frame.size.width/2, contentView.center.y + contentView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDataSource UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (onlyOneSelect) {
        if (isMoreSelect) {//两列
            return 2;
        }
        return 1;//只一列
    } else {
        return 3;
    }
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (onlyOneSelect) {
        if (isMoreSelect) {//两列
            if (component == 0) {
                return [regionArray count];
            } else {
                return [[cityArray objectAtIndex:selectRegionIndex]count];
            }
        }
        return outDataSource.count;//只一列
    } else {
        if (component == 0) {
            return yearArray.count;
        } else if (component == 1) {
            return monthArray.count;
        }else {
            return dayArray.count;
        }
    }
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (isMoreSelect) {
        return 200;
    }
    return 100;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (onlyOneSelect) {//只一列
        if (isMoreSelect) {//两列
            if (component == 0) {
                return [regionArray objectAtIndex:row];
            } else {
                return [[cityArray objectAtIndex:selectRegionIndex]objectAtIndex:row];
            }
        }
        return outDataSource[row];
    } else {
        if (component == 0) {
            return [NSString stringWithFormat:@"%@年",yearArray[row]];
        } else if (component == 1) {
            return [NSString stringWithFormat:@"%@月",monthArray[row]];
        }else {
            return [NSString stringWithFormat:@"%@日",dayArray[row]];
        }
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (onlyOneSelect) {//只一列
        if (isMoreSelect) {//两列
//            NSDictionary * dic =[outDataSource objectAtIndex:component];
//            [[dic objectForKey:@"city"]objectAtIndex:row];
//            regionArray objectAtIndex:row
//            selectedDic = [[dic objectForKey:@"name"] stringByAppendingString:[[dic objectForKey:@"city"]objectAtIndex:row]];
            if (component==0) {
                NSString * reg = [regionArray objectAtIndex:row];
                selectRegionIndex = row;
                selectedRegion = reg;
                [pickerView reloadComponent:1];
            }else{
                NSString * cit = [cityArray objectAtIndex:row];
                selectCityIndex = row;
                selectedCity = [[cityArray objectAtIndex:selectRegionIndex]objectAtIndex:row];;
            }
        }else{
            selectedData = outDataSource[row];
        }
        
    } else {
        if (component == 0) {
            selectedYear = yearArray[row];
            selectecMonth = [NSString stringWithFormat:@"%ld",(long)currentMonth];
            selectecDay = [NSString stringWithFormat:@"%ld",(long)currentDay];
            [pickerView reloadComponent:1];

            
        } else if (component == 1) {
            selectecMonth = monthArray[row];
            [self setDayArray];
            [pickerView reloadComponent:2];
        }else{
            selectecDay = dayArray[row];
        }
    }
    
    
    

}
//-(void)setToTimeArray:(NSArray *)toTimeArray
//{
//    _toTimeArray = toTimeArray;
//    if (toTimeArray.count == 3) {//年 月 日
//        currentYear = [[toTimeArray firstObject]integerValue];
//        currentMonth = [toTimeArray[1] integerValue];
//        currentDay =  [toTimeArray[2] integerValue];
//    }
//    selectedYear = [NSString stringWithFormat:@"%ld",(long)currentYear];
//    selectecMonth = [NSString stringWithFormat:@"%ld",(long)currentMonth];
//    selectecDay = [NSString stringWithFormat:@"%ld",(long)currentDay];
//}
//-(void)setBaseContentToRow:(NSString *)baseContentToRow
//{
//    _baseContentToRow = baseContentToRow;
//    selectedData=baseContentToRow;
//}
@end
