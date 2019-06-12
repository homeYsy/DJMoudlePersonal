//
//  AFNLogger.m
//  DJBase
//  AFN日志打印
//  Created by CSS on 2019/5/28.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "AFNLogger.h"
#import "AFNConfig.h"
#import "djUtilsMacros.h"

@implementation AFNLogger

+ (id)convertToJSONString:(id)object {
    if ([NSJSONSerialization isValidJSONObject:object]){
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
        NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return object;
}

+ (void)printWithRequest:(NSString *)url
                    type:(NSString *)type
                  params:(id)params {
    if (![self isPrintLogType]) {
        return;
    }
    
    id _params = params;
    if ([self printLogType] == RequestPrintLogTypeJSON) {
        _params = [self convertToJSONString:params];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@.%@",[AFNConfig sharedInstance].hostName,url,[AFNConfig sharedInstance].suffixName];
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n**************************************************************\n*                       Request Start                        *\n**************************************************************\n\n"];
    [logString appendFormat:@"请求接口:\t%@\n", urlString];
    [logString appendFormat:@"请求方式:\t%@\n", type];
    [logString appendFormat:@"Params:\t\t%@\n", _params];
    [logString appendFormat:@"\n**************************************************************\n*                         Request End                        *\n**************************************************************\n\n"];
    DLog(@"%@",logString);
}

+ (void)printWithResponse:(NSString *)url
                   result:(id)result {
    if (![self isPrintLogType]) {
        return;
    }
    id _result = result;
    if ([self printLogType] == RequestPrintLogTypeJSON) {
        _result = [self convertToJSONString:result];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@.%@",[AFNConfig sharedInstance].hostName,url,[AFNConfig sharedInstance].suffixName];
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n**************************************************************\n*                       Response Start                        *\n**************************************************************\n\n"];
    [logString appendFormat:@"请求接口:\t%@\n", urlString];
    [logString appendFormat:@"result:\t\t%@\n", _result];
    [logString appendFormat:@"\n**************************************************************\n*                         Response End                        *\n**************************************************************\n\n"];
    DLog(@"%@",logString);
}

#pragma mark Private methord
+ (RequestPrintLogType)printLogType {
    return [[AFNConfig sharedInstance]printLogType];
}

+ (BOOL)isPrintLogType {
#ifdef DEBUG //仅在调试模式打印
    if ([self printLogType] == RequestPrintLogTypeNone) {
        return NO;
    }
    return YES;
#else
    return NO;
#endif
}

@end
