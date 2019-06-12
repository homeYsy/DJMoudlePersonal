//
//  AFNManager.h
//  DJBase
//  AFN封装
//  Created by CSS on 2019/5/13.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - typeof
typedef NS_ENUM(NSUInteger, NetworkStatusType) {
    /** 未知网络*/
    NetworkStatusUnknown,
    /** 无网络*/
    NetworkStatusNotReachable,
    /** 手机网络*/
    NetworkStatusReachableViaWWAN,
    /** WIFI网络*/
    NetworkStatusReachableViaWiFi
};

/** 网络请求成功的Block */
typedef void(^AFNSuccessBlock)(NSURLSessionDataTask *task, id responseObject);
/** 网络请求失败的Block */
typedef void(^AFNFailureBlock)(NSURLSessionDataTask *task, NSError *error);
/** 上传或下载进度的Block */
typedef void(^AFNProgressBlock)(NSProgress *afnProgress);
/** 网络状态的Block*/
typedef void(^NetworkStatusBlock)(NetworkStatusType status);

#pragma mark - 声明
@interface AFNManager : NSObject

/**
 单例
 */
+ (id )networkManager;

/**
 实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
 */
+ (void)networkStatusWithBlock:(NetworkStatusBlock)networkStatus;

#pragma mark - GET
/**
 GET请求
 
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
    failure:(AFNFailureBlock)failure;

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
     failure:(AFNFailureBlock)failure;

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
     failure:(AFNFailureBlock)failure;

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
     failure:(AFNFailureBlock)failure;

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
       failure:(AFNFailureBlock)failure;

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
        failure:(AFNFailureBlock)failure;

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
         failure:(void (^)(NSError *error))failure;

@end
