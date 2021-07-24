//
//  UserCenter.m
//
#import "UserModel.h"
#import "UserCenter.h"
#import "AppDelegate.h"
static UserModel *_userModel;
NSString *UserModelPath = @"UserModelPath";
NSString *underUser = @"OnlyOneUser";


@implementation UserCenter
+(instancetype)defaultUserCenter{
    static UserCenter *_userCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       _userCenter = [[UserCenter alloc]init];
        
    });
    return _userCenter;
}

@end;
