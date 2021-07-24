//
//  AFHttpRequestClient.h
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


@interface AFHttpRequestClient : NSObject

@property(nonatomic, strong)AFHTTPSessionManager *  manager;

/*post请求*/
+(void)postUrl:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary *dict,NSInteger status,NSString *returnMsg))success failure:(void (^)(NSDictionary *dict,NSInteger status,NSString *returnMsg))failure;

//上传图片
+ (void)postUrl:(NSString *)URLString
          image:(UIImage *)newImage
       imageDic:(NSDictionary *)dic
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
        success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject))success
        failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;
//同步post请求
+(void)syncPostUrl:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary *dict,NSInteger status,NSString *returnMsg))success failure:(void (^)(NSDictionary *dict,NSInteger status,NSString *returnMsg))failure;

@end
