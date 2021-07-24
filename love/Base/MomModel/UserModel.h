//
//  UserModel.h
//

#import <Foundation/Foundation.h>
#import "CoderModel.h"
#import "MomApi.h"
@interface UserModel : CoderModel

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *headpicThumb;
@property (nonatomic,strong) NSString *headpic;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,assign) NSInteger sex;
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,assign) NSInteger height;
@property (nonatomic,assign) NSInteger weight;
@property (nonatomic,strong) NSString *birthday;
@end
