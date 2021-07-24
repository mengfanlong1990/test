//
//  HttpRequest.m
//

#import "HttpRequest.h"
#import "AFHttpRequestClient.h"
@implementation HttpRequest
//+(void)httpLoginReqWithPara:(NSObject *) model completion:(void(^)(NSInteger status ,NSString *returnMsg,ResLogin *resLogin)) completion{
//
//    [AFHttpRequestClient postUrl:BaseUrl  parameters:model.mj_keyValues success:^(NSDictionary *dict, NSInteger status, NSString *returnMsg) {
//        ResLogin * resModel = [ResLogin mj_objectWithKeyValues:dict];
//        completion(status,returnMsg,resModel);
//    } failure:^(NSDictionary *dict, NSInteger status, NSString *returnMsg) {
//        completion(status,returnMsg,nil);
//    }];
//
//}
//
//+(void)httpSendSMSCodeReqWithPara:(NSObject *) model completion:(void(^)(NSInteger status ,NSString *returnMsg)) completion{
//    [AFHttpRequestClient postUrl:BaseUrl  parameters:model.mj_keyValues success:^(NSDictionary *dict, NSInteger status, NSString *returnMsg) {
//        completion(status,returnMsg);
//    } failure:^(NSDictionary *dict, NSInteger status, NSString *returnMsg) {
//        completion(status,returnMsg);
//    }];
//}
//
//+(void)httpRegisterReqWithPara:(NSObject *) model completion:(void(^)(NSInteger status ,NSString *returnMsg,ResLogin *resLogin)) completion{
//    [AFHttpRequestClient postUrl:BaseUrl  parameters:model.mj_keyValues success:^(NSDictionary *dict, NSInteger status, NSString *returnMsg) {
//        ResLogin * resModel = [ResLogin mj_objectWithKeyValues:dict];
//        completion(status,returnMsg,resModel);
//    } failure:^(NSDictionary *dict, NSInteger status, NSString *returnMsg) {
//        completion(status,returnMsg,nil);
//    }];
//}
@end
