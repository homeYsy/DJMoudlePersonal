//
//  AFNConfig.h
//  DJBase
//  AFN配置
//  Created by CSS on 2019/5/28.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef enum {
    RequestPrintLogTypeNone, //不会打印任何请求日志
    RequestPrintLogTypeJSON, //请求日志将以json格式打印
    RequestPrintLogTypeNSObject //请求日志将以NSObject格式打印，例如:NSArray,NSDictionary
}RequestPrintLogType;

@interface AFNConfig : NSObject

@property(nonatomic, strong) NSString *hostName;//api地址
@property(nonatomic, strong) NSString *suffixName;//api后缀
@property(nonatomic, strong) NSString *userDefaultsCookie;//用户cookie存储名称
@property(nonatomic, assign) NSInteger                timeoutInterval ; //请求超时时间间隔
@property(nonatomic, assign) RequestPrintLogType       printLogType ; //打印日志的类型
@property(nonatomic, strong) AFHTTPRequestSerializer  *requestSerializer ; //请求的serializer
@property(nonatomic, strong) AFHTTPResponseSerializer *responseSerializer ; //请求返回内容的serializer

/**
 单例模式

 @return AFNConfig实例
 */
+ (AFNConfig *)sharedInstance;

/**
 初始化网络模块，设置host

 @param hostName            请求的host，例如http://api.test.com
 @param userDefaultsCookie  用户cookie存储名称
 */
+ (void)initWithHost:(NSString *)hostName
              cookie:(NSString *)userDefaultsCookie;

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
  responseSerializer:(AFHTTPResponseSerializer *)responseSerializer;

@end
