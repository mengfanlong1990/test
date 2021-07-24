//
//  AFHttpRequestClient.m
//

#import "AFHttpRequestClient.h"
#import "NSString+AttributeStr.h"
#import "MBHubManger.h"
@implementation AFHttpRequestClient
+(AFHttpRequestClient *)shareClient{
    static AFHttpRequestClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[AFHttpRequestClient alloc]init];
    });
    return client;
}
- (void)config
{
    static AFHTTPSessionManager  *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] init];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    });
    _manager = manager;
//    [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    //        接受类型
//    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/xml",@"text/plain", nil];
//    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
//                                                         @"text/html",
//                                                         @"image/jpeg",
//                                                         @"image/png",
//                                                         @"application/octet-stream",
//                                                         @"text/json",
//                                                         nil];


}

+(void)postUrl:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary *dict,NSInteger status,NSString *returnMsg))success failure:(void (^)(NSDictionary *dict,NSInteger status,NSString *returnMsg))failure
{
    
    
    if( [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable){
        failure(nil, NETNOTCONNECT,@"网络未连接");
        return;
    }
    AFHttpRequestClient *client = [AFHttpRequestClient shareClient];
    [client config];
    __block MBHubManger *manager;
    dispatch_async(dispatch_get_main_queue(), ^{
        manager = [MBHubManger manager];
    });
    [client.manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSDictionary *dateDict = dict[@"returnData"];
        NSNumber *statusCode = dict[@"returnValue"];
        NSString *returnMsg = dict[@"returnMsg"];
        NSString *msg = [returnMsg replaceUnicode];
        NSLog(@"%@?%@--%@",URLString, [self appendParameters:parameters], [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil]);
        if (statusCode.integerValue != 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
               [manager showHint:msg];
            });
            
         failure(nil,statusCode.integerValue,msg);
          
        }else{
          success(dateDict,statusCode.integerValue,msg);
        }
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        failure(nil,error.code,error.domain);
        NSLog(@"%@?%@--%@",URLString, [self appendParameters:parameters], error);
        if (error.code == -1009) {
            [[MBHubManger manager]showBadNetWithTip];
        }else{
        [manager showHint:[NSString stringWithFormat:@"%ld",(long)error.code]];
        }
    }];
}

+(void)syncPostUrl:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary *dict,NSInteger status,NSString *returnMsg))success failure:(void (^)(NSDictionary *dict,NSInteger status,NSString *returnMsg))failure{
    if( [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable){
        failure(nil, NETNOTCONNECT,@"网络未连接");
        return;
    }
    __block complete = NO;
    AFHttpRequestClient *client = [AFHttpRequestClient shareClient];
    [client config];
    __block MBHubManger *manager;
        manager = [MBHubManger manager];
    [client.manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        complete = YES;

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSDictionary *dateDict = dict[@"returnData"];
        NSNumber *statusCode = dict[@"returnValue"];
        NSString *returnMsg = dict[@"returnMsg"];
        NSString *msg = [returnMsg replaceUnicode];
        NSLog(@"%@?%@--%@",URLString, [self appendParameters:parameters], [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil]);
        if (statusCode.integerValue != 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [manager showHint:msg];
            });
            
            failure(nil,statusCode.integerValue,msg);
            
        }else{
            success(dateDict,statusCode.integerValue,msg);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete = YES;

        failure(nil,error.code,error.domain);
        NSLog(@"%@?%@--%@",URLString, [self appendParameters:parameters], error);
        if (error.code == -1009) {
            [[MBHubManger manager]showBadNetWithTip];
        }else{
            [manager showHint:[NSString stringWithFormat:@"%ld",(long)error.code]];
        }
        
    }];
    
    
        while (!complete) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    
    
}


//上传图片
+ (void)postUrl:(NSString *)URLString
          image:(UIImage *)newImage
          imageDic:(NSDictionary *)dic
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
        success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject))success
        failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure{
    
    AFHttpRequestClient *client = [AFHttpRequestClient shareClient];
    [client config];
    NSData *newImageData = [client compressSize:newImage];
    NSDictionary *parameter = @{@"param":[client DataTOjsonString:dic],
                                @"pic":newImageData};
    [client.manager POST:URLString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:newImageData name:@"pic" fileName:@"1.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil]);
        NSLog(@"%@--%@",task.originalRequest,[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@--%@",task.originalRequest,error);
        if (error.code == -1009|| error.code == -1003) {
            //加tip@"网络请求失败,请稍后重试"
        }else{
            //加tip
        }
        failure(task,error);
    }];
}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }  
    return jsonString;
}

#pragma mark - 压缩图片
- (NSData *)compressSize:(UIImage *)myImage{
    //压缩
    //设置image的尺寸
    CGSize imagesize = myImage.size;
    imagesize.height = imagesize.height / 3;
    imagesize.width = imagesize.width / 3;
    
    
    UIImage * newImg = [self imageWithImage:myImage scaledToSize:imagesize];
    NSData *imageData = UIImagePNGRepresentation(newImg);
    return imageData;
}

//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (NSString *)appendParameters:(NSDictionary *)parameters {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
 

    
    NSArray *paramArr = param.allKeys;
    
    NSMutableArray *paramPair = [NSMutableArray array];
    for (NSString *key in paramArr) {
        NSString *value = param[key];
        if (!value) {
            value = @"";
        }
        [paramPair addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }
   
    
    return [paramPair componentsJoinedByString:@"&"];
}







@end
