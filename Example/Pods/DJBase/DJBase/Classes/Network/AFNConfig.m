//
//  AFNConfig.m
//  DJBase
//  AFN配置
//  Created by CSS on 2019/5/28.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "AFNConfig.h"

@implementation AFNConfig

/**
 单例模式
 
 @return AFNConfig实例
 */
+ (AFNConfig *)sharedInstance {
    static AFNConfig *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 初始化

 @return AFNConfig实例
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        _hostName = nil;
        _suffixName = @"do";
        _userDefaultsCookie = @"mUserDefaultsCookie";
        _timeoutInterval = 30;//默认30s
        _printLogType = RequestPrintLogTypeNSObject;
        _requestSerializer = nil;
        _responseSerializer = nil;
    }
    return self;
}

/**
 初始化网络模块，设置host
 
 @param hostName            请求的host，例如http://api.test.com
 @param userDefaultsCookie  用户cookie存储名称
 */
+ (void)initWithHost:(NSString *)hostName
              cookie:(NSString *)userDefaultsCookie {
    [self initWithHost:hostName suffix:@"do" cookie:userDefaultsCookie timeoutInterval:30 printLogType:RequestPrintLogTypeNSObject requestSerializer:nil responseSerializer:nil];
}

/**
 初始化网络模块，设置host
 
 @param hostName            请求的host，例如http://api.test.com
 @param suffixName          请求的后缀，例如do
 @param userDefaultsCookie  用户cookie存储名称
 @param timeoutInterval     请求超时时间间隔
 @param printLogType        打印日志的类型
 @param requestSerializer   请求的serializer
 @param responseSerializer  处理请求返回内容的serializer
 */
+ (void)initWithHost:(NSString *)hostName
              suffix:(NSString *)suffixName
              cookie:(NSString *)userDefaultsCookie
     timeoutInterval:(NSInteger)timeoutInterval
        printLogType:(RequestPrintLogType)printLogType
   requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
  responseSerializer:(AFHTTPResponseSerializer *)responseSerializer {
    [[AFNConfig sharedInstance]setHostName:hostName];
    [[AFNConfig sharedInstance]setSuffixName:suffixName];
    [[AFNConfig sharedInstance]setUserDefaultsCookie:userDefaultsCookie];
    [[AFNConfig sharedInstance]setTimeoutInterval:timeoutInterval];
    [[AFNConfig sharedInstance]setPrintLogType:printLogType];
    if (requestSerializer) {
        [[AFNConfig sharedInstance] setRequestSerializer:requestSerializer];
    }
    if (responseSerializer) {
        [[AFNConfig sharedInstance] setResponseSerializer:responseSerializer];
    }
}

@end
