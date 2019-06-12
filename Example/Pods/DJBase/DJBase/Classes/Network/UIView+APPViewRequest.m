//
//  UIView+APPViewRequest.m
//  DJBase
//  UIView 网络请求
//  Created by CSS on 2019/5/13.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "UIView+APPViewRequest.h"
#import <objc/runtime.h>
#import <MJExtension/MJExtension.h>
#import "MBProgressHUD+Custom.h"
#import "APPResult.h"
#import "AFNLogger.h"
#import "djUtilsMacros.h"
#import "NSString+Helpers.h"

static void *kUIView_APPViewRequest;

@implementation UIView (APPViewRequest)

#pragma mark - get
- (APPViewRequest *)afn_sharedManager {
    APPViewRequest *request = [APPViewRequest sharedManager];
    return request;
}

#pragma mark - 功能
//添加版本号参数
- (NSDictionary *)addParams:(NSDictionary *)param {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:param];
    [params setValue:[@"ios_" stringByAppendingString:[NSString appVersion]] forKey:@"version"];
    return params;
}

#pragma mark - GET
/**
 GET请求-无参
 
 @param url       请求网址字符串
 @param success   请求成功的回调
 */
- (void)GET:(NSString *)url
    success:(SuccessBlock)success {
    [self GET:url success:success failure:nil];
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
    [self GET:url params:nil success:success failure:failure];
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
    [self GET:url params:params success:success failure:nil];
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
    [self GET:url params:params progress:nil success:success failure:failure];
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
    APPViewRequest *viewParameter = [self afn_request];
    
    if ([viewParameter afn_showHud]) {
        [MBProgressHUD showActivityMessageInWindow:[viewParameter afn_showHudMsg]];
    }
    
    NSDictionary *param = [self addParams:params];
    
    [AFNLogger printWithRequest:url type:@"GET" params:param];
    
    //请求
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak typeof(self) weak = self;
    [AFNManager GET:url params:param progress:^(NSProgress *afnProgress) {
        if (progress) progress(afnProgress);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [weak dealWithSuccessResponseObject:responseObject url:url params:param viewParam:viewParameter success:success failure:failure];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weak dealWithFailError:error url:url params:param viewParam:viewParameter failure:failure];
    }];
}

#pragma mark - POST
/**
 POST请求-无参
 
 @param url       请求网址字符串
 @param success   请求成功的回调
 */
- (void)POST:(NSString *)url
     success:(SuccessBlock)success {
    [self POST:url success:success failure:nil];
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
    [self POST:url params:nil success:success failure:failure];
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
    [self POST:url params:params success:success failure:nil];
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
    [self POST:url params:params progress:nil success:success failure:failure];
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
    APPViewRequest *viewParameter = [self afn_request];
    
    if ([viewParameter afn_showHud]) {
        [MBProgressHUD showActivityMessageInWindow:[viewParameter afn_showHudMsg]];
    }
    
    NSDictionary *param = [self addParams:params];
    
    [AFNLogger printWithRequest:url type:@"POST" params:param];
    
    //请求
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak typeof(self) weak = self;
    [AFNManager POST:url params:param progress:^(NSProgress *afnProgress) {
        if (progress) progress(afnProgress);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [weak dealWithSuccessResponseObject:responseObject url:url params:param viewParam:viewParameter success:success failure:failure];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weak dealWithFailError:error url:url params:param viewParam:viewParameter failure:failure];
    }];
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
    APPViewRequest *viewParameter = [self afn_request];
    
    if ([viewParameter afn_showHud]) {
        [MBProgressHUD showActivityMessageInWindow:[viewParameter afn_showHudMsg]];
    }
    
    NSDictionary *param = [self addParams:params];
    
    [AFNLogger printWithRequest:url type:@"POST" params:param];
    
    //请求
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak typeof(self) weak = self;
    [AFNManager POST:url params:param andImages:images progress:^(NSProgress *afnProgress) {
        if (progress) progress(afnProgress);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [weak dealWithSuccessResponseObject:responseObject url:url params:param viewParam:viewParameter success:success failure:failure];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weak dealWithFailError:error url:url params:param viewParam:viewParameter failure:failure];
    }];
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
    APPViewRequest *viewParameter = [self afn_request];
    
    if ([viewParameter afn_showHud]) {
        [MBProgressHUD showActivityMessageInWindow:[viewParameter afn_showHudMsg]];
    }
    
    NSDictionary *param = [self addParams:params];
    
    [AFNLogger printWithRequest:url type:@"POST" params:param];
    
    //请求
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak typeof(self) weak = self;
    [AFNManager POST:url params:param name:name filePath:filePath progress:^(NSProgress *afnProgress) {
        if (progress) progress(afnProgress);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [weak dealWithSuccessResponseObject:responseObject url:url params:param viewParam:viewParameter success:success failure:failure];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weak dealWithFailError:error url:url params:param viewParam:viewParameter failure:failure];
    }];
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
    APPViewRequest *viewParameter = [self afn_request];
    
    if ([viewParameter afn_showHud]) {
        [MBProgressHUD showActivityMessageInWindow:[viewParameter afn_showHudMsg]];
    }
    
    NSDictionary *param = [self addParams:params];
    
    [AFNLogger printWithRequest:url type:@"POST" params:param];
    
    //请求
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak typeof(self) weak = self;
    [AFNManager getUrl:url params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        [weak dealWithSuccessResponseObject:responseObject url:url params:param viewParam:viewParameter success:success failure:failure];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weak dealWithFailError:error url:url params:param viewParam:viewParameter failure:failure];
    }];
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
    APPViewRequest *viewParameter = [self afn_request];
    
    if ([viewParameter afn_showHud]) {
        [MBProgressHUD showActivityMessageInWindow:[viewParameter afn_showHudMsg]];
    }
    
    NSDictionary *param = [self addParams:params];
    
    [AFNLogger printWithRequest:url type:@"POST" params:param];
    
    //请求
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak typeof(self) weak = self;
    [AFNManager postUrl:url params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        [weak dealWithSuccessResponseObject:responseObject url:url params:param viewParam:viewParameter success:success failure:failure];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weak dealWithFailError:error url:url params:param viewParam:viewParameter failure:failure];
    }];
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
    APPViewRequest *viewParameter = [self afn_request];
    
    if ([viewParameter afn_showHud]) {
        [MBProgressHUD showActivityMessageInWindow:[viewParameter afn_showHudMsg]];
    }
    
    NSDictionary *param = [self addParams:[NSDictionary new]];
    
    [AFNLogger printWithRequest:url type:@"Download" params:param];
    
    //请求
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak typeof(self) weak = self;
    [AFNManager Download:url fileDir:fileDir progress:^(NSProgress *afnProgress) {
        if (progress) progress(afnProgress);
    } success:^(NSURLResponse *response, NSURL *filePath) {
        if (success) success(filePath);
    } failure:^(NSError *error) {
        [weak dealWithFailError:error url:url params:param viewParam:viewParameter failure:failure];
    }];
}

#pragma mark - Private Method
/**
 网络请求成功后执行 - 网络正常,有返回数据

 @param responseObject  服务器返回数据
 @param url             请求网址字符串
 @param params          请求参数
 @param viewParam       页面请求参数
 @param success         请求成功的回调
 @param failure         请求失败的回调
 */
- (void)dealWithSuccessResponseObject:(id)responseObject
                                  url:(NSString *)url
                               params:(NSDictionary *)params
                            viewParam:(APPViewRequest *)viewParam
                              success:(SuccessBlock)success
                              failure:(FailureBlock)failure {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (responseObject) {
        APPResult *result = [APPResult mj_objectWithKeyValues:responseObject];

        [AFNLogger printWithResponse:url result:[result mj_keyValues]];
        
        BOOL isSuccess = [result.success boolValue];
        //判断
        if (isSuccess) {
            id data = result.data;
            if (!data) data = result.msg;
            
            NSDictionary *total = result.total;
            if ([data isKindOfClass:[NSArray class]]) {
                if (total != nil) {
                    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:data];
                    [array insertObject:total atIndex:0];
                    data = array;
                }
            }
            
            if ([viewParam afn_showHud]) {
                [MBProgressHUD hideHUD];
            }
            //解析
            if(success) success(data);
        }else {
            if ([viewParam afn_showHud]) {
                [MBProgressHUD hideHUD];
            }
            [MBProgressHUD showTopTipMessage:result.msg];
            if (failure) failure(result.msg);
        }
    }else {
        if (failure) failure(@"数据为空");
    }
}

/**
 网络请求失败后执行 - 网络异常

 @param error       错误信息
 @param url         请求网址字符串
 @param params      请求参数
 @param viewParam   页面请求参数
 @param failure     请求失败的回调
 */
- (void)dealWithFailError:(NSError *)error
                      url:(NSString *)url
                   params:(NSDictionary *)params
                viewParam:(APPViewRequest *)viewParam
                  failure:(FailureBlock)failure {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    /// 默认类型:服务器报错.
    /// 404 500 503 -1011 -1009.
    NSInteger errorType = EmptyViewTypeService;
    switch (error.code) {
        case -1009:
        {
            /// 修改类型:网络报错.
            errorType = EmptyViewTypeNetwork;
        }
            break;
        default:
            break;
    }
    
    NSString *tipStr = @"系统错误, 请联系研发中心处理!";
    
#if DEBUG
    tipStr = [NSString stringWithFormat:@"系统%ld错误, 请联系研发中心处理!",(long)error.code];
#endif
    
    if ([viewParam afn_showHud]) {
        [MBProgressHUD hideHUD];
    }
    DLog(@"%@\n %@",url,error);
    
    [MBProgressHUD showTopTipMessage:tipStr];
    
    if (failure) failure(tipStr);
}

#pragma mark - runtime
- (void)setAfn_request:(APPViewRequest *)afn_request {
    objc_setAssociatedObject(self, &kUIView_APPViewRequest, afn_request, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (APPViewRequest *)afn_request {
    if (!objc_getAssociatedObject(self, &kUIView_APPViewRequest)) {
        APPViewRequest *req = [self afn_sharedManager];
        [self setAfn_request:req];
    }
    return objc_getAssociatedObject(self, &kUIView_APPViewRequest);
}

@end
