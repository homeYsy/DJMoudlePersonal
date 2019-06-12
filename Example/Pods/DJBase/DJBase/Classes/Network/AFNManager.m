//
//  AFNManager.m
//  DJBase
//  AFN封装
//  Created by CSS on 2019/5/13.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "AFNManager.h"
#import <AFNetworking/AFNetworking.h>
#import "AFNConfig.h"
#import "djUtilsMacros.h"

#pragma mark - 声明
@interface AFNManager()

@end

#pragma mark - 实现
@implementation AFNManager

#pragma mark - 单例
//利用单例管理SessionManager避免多次实例内存溢出
//sessionManager单例
+ (id)networkManager {
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    });
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = [[AFNConfig sharedInstance]timeoutInterval];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSUserDefaults *userCookies = [[NSUserDefaults standardUserDefaults]objectForKey:[[AFNConfig sharedInstance]userDefaultsCookie]];
    NSString *cookies = [NSString stringWithFormat:@"%@",userCookies];
    [manager.requestSerializer setValue:cookies forHTTPHeaderField:@"Cookie"];
    return manager;
}

#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(NetworkStatusBlock)networkStatus {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(NetworkStatusUnknown) : nil;
                    DLog(@"未知网络");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(NetworkStatusNotReachable) : nil;
                    DLog(@"无网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(NetworkStatusReachableViaWWAN) : nil;
                    DLog(@"手机自带网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(NetworkStatusReachableViaWiFi) : nil;
                    DLog(@"WIFI");
                    break;
            }
        }];
    });
}

#pragma mark - GET
/**
 GET请求-有参带进度
 
 @param url        请求网址字符串
 @param params     请求参数
 @param progress   上传进度回调
 @param success    请求成功的回调
 @param failure    请求失败的回调
 */
+ (void)GET:(NSString *)url
     params:(NSDictionary *)params
   progress:(AFNProgressBlock)progress
    success:(AFNSuccessBlock)success
    failure:(AFNFailureBlock)failure {
    AFHTTPSessionManager *manager = [self networkManager];
    if ([[AFNConfig sharedInstance]requestSerializer]) {
        manager.requestSerializer = [[AFNConfig sharedInstance]requestSerializer];
    }
    if ([[AFNConfig sharedInstance]responseSerializer]) {
        manager.responseSerializer = [[AFNConfig sharedInstance]responseSerializer];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@.%@",[AFNConfig sharedInstance].hostName,url,[AFNConfig sharedInstance].suffixName];
    [manager GET:urlString parameters:params progress:progress success:success failure:failure];
}

#pragma mark - POST
/**
 POST请求
 
 @param url        请求网址字符串
 @param params     请求参数
 @param progress   上传进度回调
 @param success    请求成功的回调
 @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)url
      params:(NSDictionary *)params
    progress:(AFNProgressBlock)progress
     success:(AFNSuccessBlock)success
     failure:(AFNFailureBlock)failure {
    AFHTTPSessionManager *manager = [self networkManager];
    if ([[AFNConfig sharedInstance]requestSerializer]) {
        manager.requestSerializer = [[AFNConfig sharedInstance]requestSerializer];
    }
    if ([[AFNConfig sharedInstance]responseSerializer]) {
        manager.responseSerializer = [[AFNConfig sharedInstance]responseSerializer];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@.%@",[AFNConfig sharedInstance].hostName,url,[AFNConfig sharedInstance].suffixName];
    [manager POST:urlString parameters:params progress:progress success:success failure:failure];
}

/**
 POST请求-上传多张图片
 
 @param url        请求网址字符串
 @param params     请求参数
 @param images     上传的图片组
 @param progress   上传进度回调
 @param success    请求成功的回调
 @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)url
      params:(NSDictionary *)params
   andImages:(NSArray<UIImage *> *)images
    progress:(AFNProgressBlock)progress
     success:(AFNSuccessBlock)success
     failure:(AFNFailureBlock)failure {
    AFHTTPSessionManager *manager = [self networkManager];
    if ([[AFNConfig sharedInstance]requestSerializer]) {
        manager.requestSerializer = [[AFNConfig sharedInstance]requestSerializer];
    }
    if ([[AFNConfig sharedInstance]responseSerializer]) {
        manager.responseSerializer = [[AFNConfig sharedInstance]responseSerializer];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@.%@",[AFNConfig sharedInstance].hostName,url,[AFNConfig sharedInstance].suffixName];
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //图片
        if (images && [images count] > 0) {
            for (NSInteger index = 0; index < images.count; index++) {
                //图片转数据
                NSString *imgName = [NSString stringWithFormat:@"image%ld", index];
                NSData *data = UIImagePNGRepresentation(images[index]);
                if (data == nil) {
                    data = UIImageJPEGRepresentation(images[index], 1.0);
                }
                //添加参数
                [formData appendPartWithFileData:data name:@"file" fileName:imgName mimeType:@"image/png"];
            }
        }
    } progress:progress success:success failure:failure];
}

/**
 POST请求-上传文件
 
 @param url        请求网址字符串
 @param params     请求参数
 @param name       文件名称
 @param filePath   文件路径
 @param progress   上传进度回调
 @param success    请求成功的回调
 @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)url
      params:(NSDictionary *)params
        name:(NSString *)name
    filePath:(NSString *)filePath
    progress:(AFNProgressBlock)progress
     success:(AFNSuccessBlock)success
     failure:(AFNFailureBlock)failure {
    AFHTTPSessionManager *manager = [self networkManager];
    if ([[AFNConfig sharedInstance]requestSerializer]) {
        manager.requestSerializer = [[AFNConfig sharedInstance]requestSerializer];
    }
    if ([[AFNConfig sharedInstance]responseSerializer]) {
        manager.responseSerializer = [[AFNConfig sharedInstance]responseSerializer];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@.%@",[AFNConfig sharedInstance].hostName,url,[AFNConfig sharedInstance].suffixName];
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        //添加参数
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:@"video" fileName:name mimeType:@"video/quicktime" error:&error];
    } progress:progress success:success failure:failure];
}

/*-------------以下get请求和post请求为不带baseurl的  其他无区别---------*/
/**
 get请求
 
 @param url     请求的网址字符串 如http:192.168.10.10:8080/...../cscl.do
 @param params  请求的参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)getUrl:(NSString *)url
        params:(NSDictionary *)params
       success:(AFNSuccessBlock)success
       failure:(AFNFailureBlock)failure {
    AFHTTPSessionManager *manager = [self networkManager];
    if ([[AFNConfig sharedInstance]requestSerializer]) {
        manager.requestSerializer = [[AFNConfig sharedInstance]requestSerializer];
    }
    if ([[AFNConfig sharedInstance]responseSerializer]) {
        manager.responseSerializer = [[AFNConfig sharedInstance]responseSerializer];
    }
    [manager GET:url parameters:params progress:nil success:success failure:failure];
}

/**
 post请求
 
 @param url     请求的网址字符串 如http:192.168.10.10:8080/...../cscl.do
 @param params  请求的参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)postUrl:(NSString *)url
         params:(NSDictionary *)params
        success:(AFNSuccessBlock)success
        failure:(AFNFailureBlock)failure {
    AFHTTPSessionManager *manager = [self networkManager];
    if ([[AFNConfig sharedInstance]requestSerializer]) {
        manager.requestSerializer = [[AFNConfig sharedInstance]requestSerializer];
    }
    if ([[AFNConfig sharedInstance]responseSerializer]) {
        manager.responseSerializer = [[AFNConfig sharedInstance]responseSerializer];
    }
    [manager POST:url parameters:params progress:nil success:success failure:failure];
}

#pragma mark - Download
/**
 下载文件
 
 @param url        请求网址字符串
 @param fileDir    保存在沙盒的位置
 @param progress   上传进度回调
 @param success    请求成功的回调
 @param failure    请求失败的回调
 */
+ (void)Download:(NSString *)url
         fileDir:(NSString *)fileDir
        progress:(AFNProgressBlock)progress
         success:(void (^)(NSURLResponse *response, NSURL *filePath))success
         failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [self networkManager];
    if ([[AFNConfig sharedInstance]requestSerializer]) {
        manager.requestSerializer = [[AFNConfig sharedInstance]requestSerializer];
    }
    if ([[AFNConfig sharedInstance]responseSerializer]) {
        manager.responseSerializer = [[AFNConfig sharedInstance]responseSerializer];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@.%@",[AFNConfig sharedInstance].hostName,url,[AFNConfig sharedInstance].suffixName];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:progress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(error){
            failure(error);
        }else{
            success(response,filePath);
        }
    }];
    /// 启动任务.
    [downloadTask resume];
}

@end
