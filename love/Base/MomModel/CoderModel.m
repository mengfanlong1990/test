//
//  CoderModel.m
//

#import "CoderModel.h"
#import <MJExtension/MJExtension.h>
@implementation CoderModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        [self mj_decode:aDecoder];
        }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [self mj_encode:aCoder];
    
}
-(NSArray *)properties{
    unsigned int count;
    NSMutableArray *nameArr = [NSMutableArray array];
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0 ; i<count; i ++) {
        const char *propertyName = property_getName(properties[i]);
        [nameArr addObject:[NSString stringWithUTF8String:propertyName]];
    }
    return nameArr;
}
@end
