//
//  UIViewController+APPViewRequest.m
//  DJBase
//  UIViewController 网络请求
//  Created by CSS on 2019/5/13.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "UIViewController+APPViewRequest.h"

@implementation UIViewController (APPViewRequest)

- (void)setAfn_request:(APPViewRequest *)afn_request {
    [self.view setAfn_request:afn_request];
}

- (APPViewRequest *)afn_request {
    return [self.view afn_request];
}
#pragma mark - GET
/**
 GET请求-无参
 
 @param url       请求网址字符串
 @param success   请求成功的回调
 */
- (void)GET:(NSString *)url
    success:(SuccessBlock)success {
    [self.view GET:url success:success];
}

/**
 GET请求-无参
 
 @param url       请求网址字符串
 @param success   请求成功的回调
 @param failure   请求失败的回调
 */
- (void)GET:(NSString *)url
    success:(SuccessBlock)success
    failure:(FailureBlock)failure {
    [self.view GET:url success:success failure:failure];
}

/**
 GET请求-有参
 
 @param url       请求网址字符串
 @param params    请求参数
 @param success   请求成功的回调
 */
- (void)GET:(NSString *)url
     params:(NSDictionary *)params
    success:(SuccessBlock)success {
    [self.view GET:url params:params success:success];
}

/**
 GET请求-有参
 
 @param url       请求网址字符串
 @param params    请求参数
 @param success   请求成功的回调
 @param failure   请求失败的回调
 */
- (void)GET:(NSString *)url
     params:(NSDictionary *)params
    success:(SuccessBlock)success
    failure:(FailureBlock)failure {
    [self.view GET:url params:params success:success failure:failure];
}

/**
 GET请求
 
 @param url       请求网址字符串
 @param params    请求参数
 @param progress  上传进度回调
 @param success   请求成功的回调
 @param failure   请求失败的回调
 */
- (void)GET:(NSString *)url
     params:(NSDictionary *)params
   progress:(ProgressBlock)progress
    success:(SuccessBlock)success
    failure:(FailureBlock)failure {
    [self.view GET:url params:params progress:progress success:success failure:failure];
}

#pragma mark - POST
/**
 POST请求-无参
 
 @param url       请求网址字符串
 @param success   请求成功的回调
 */
- (void)POST:(NSString *)url
     success:(SuccessBlock)success {
    [self.view POST:url success:success];
}

/**
 POST请求-无参
 
 @param url       请求网址字符串
 @param success   请求成功的回调
 @param failure   请求失败的回调
 */
- (void)POST:(NSString *)url
     success:(SuccessBlock)success
     failure:(FailureBlock)failure {
    [self.view POST:url success:success failure:failure];
}

/**
 POST请求-有参
 
 @param url       请求网址字符串
 @param params    请求参数
 @param success   请求成功的回调
 */
- (void)POST:(NSString *)url
      params:(NSDictionary *)params
     success:(SuccessBlock)success {
    [self.view POST:url params:params success:success];
}

/**
 POST请求-有参
 
 @param url       请求网址字符串
 @param params    请求参数
 @param success   请求成功的回调
 @param failure   请求失败的回调
 */
- (void)POST:(NSString *)url
      params:(NSDictionary *)params
     success:(SuccessBlock)success
     failure:(FailureBlock)failure {
    [self.view POST:url params:params success:success failure:failure];
}

/**
 POST请求
 
 @param url       请求网址字符串
 @param params    请求参数
 @param progress  上传进度回调
 @param success   请求成功的回调
 @param failure   请求失败的回调
 */
- (void)POST:(NSString *)url
      params:(NSDictionary *)params
    progress:(ProgressBlock)progress
     success:(SuccessBlock)success
     failure:(FailureBlock)failure {
    [self.view POST:url params:params progress:progress success:success failure:failure];
}

/**
 POST请求-上传图片
 
 @param url       请求网址字符串
 @param params    请求参数
 @param images    上传的图片组
 @param progress  上传进度回调
 @param success   请求成功的回调
 @param failure   请求失败的回调
 */
- (void)POST:(NSString *)url
      params:(NSDictionary *)params
   andImages:(NSArray<UIImage *> *)images
    progress:(ProgressBlock)progress
     success:(SuccessBlock)success
     failure:(FailureBlock)failure {
    [self.view POST:url params:params andImages:images progress:progress success:success failure:failure];
}

/**
 POST请求-上传文件
 
 @param url       请求网址字符串
 @param params    请求参数
 @param name      文件名称
 @param filePath  文件路径
 @param progress  上传进度回调
 @param success   请求成功的回调
 @param failure   请求失败的回调
 */
- (void)POST:(NSString *)url
      params:(NSDictionary *)params
        name:(NSString *)name
    filePath:(NSString *)filePath
    progress:(ProgressBlock)progress
     success:(SuccessBlock)success
     failure:(FailureBlock)failure {
    [self.view POST:url params:params name:name filePath:filePath progress:progress success:success failure:failure];
}

/*-------------以下get请求和post请求为不带baseurl的  其他无区别---------*/
/**
 get请求
 
 @param url     请求的网址字符串 如http:192.168.10.10:8080/...../cscl.do
 @param params  请求的参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)getUrl:(NSString *)url
        params:(NSDictionary *)params
       success:(SuccessBlock)success
       failure:(FailureBlock)failure {
    [self.view getUrl:url params:params success:success failure:failure];
}

/**
 post请求
 
 @param url     请求的网址字符串 如http:192.168.10.10:8080/...../cscl.do
 @param params  请求的参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)postUrl:(NSString *)url
         params:(NSDictionary *)params
        success:(SuccessBlock)success
        failure:(FailureBlock)failure {
    [self.view postUrl:url params:params success:success failure:failure];
}

#pragma mark - Download
/**
 下载文件
 
 @param url       请求网址字符串
 @param fileDir   保存在沙盒的位置
 @param progress  上传进度回调
 @param success   请求成功的回调
 @param failure   请求失败的回调
 */
- (void)Download:(NSString *)url
         fileDir:(NSString *)fileDir
        progress:(ProgressBlock)progress
         success:(SuccessBlock)success
         failure:(FailureBlock)failure {
    [self.view Download:url fileDir:fileDir progress:progress success:success failure:failure];
}

@end
