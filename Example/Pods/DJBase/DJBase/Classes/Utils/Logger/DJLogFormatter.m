//
//  DJLogFormatter.m
//  DJBase
//
//  Created by CSS on 2019/5/21.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "DJLogFormatter.h"

@implementation DJLogFormatter

- (id)init {
    if((self = [super init])) {
        threadUnsafeDateFormatter = [[NSDateFormatter alloc] init];
        [threadUnsafeDateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss:SSS"];
    }
    return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *logLevel;
    switch (logMessage->_flag) {
        case DDLogFlagError    : logLevel = @"Error"; break;
        case DDLogFlagWarning  : logLevel = @"Warning"; break;
        case DDLogFlagInfo     : logLevel = @"Info"; break;
        case DDLogFlagDebug    : logLevel = @"Debug"; break;
        default                : logLevel = @"Verbose"; break;
    }
    
    NSString *dateAndTime = [threadUnsafeDateFormatter stringFromDate:(logMessage->_timestamp)];
    NSString *logMsg = logMessage->_message;
    NSString *logFileNmae = logMessage -> _fileName;
    NSString *logFuncation = logMessage -> _function;
    long lineNum = logMessage -> _line;
    
    // 日志格式：类 函数名 :行数 <日志等级> 日期和时间 :::日志消息
    return [NSString stringWithFormat:@"%@ %@ :%li <%@> %@ :::\n %@ ",logFileNmae, logFuncation,lineNum, logLevel, dateAndTime, logMsg];
}

- (void)didAddToLogger:(id <DDLogger>)logger {
    loggerCount++;
    NSAssert(loggerCount <= 1, @"This logger isn't thread-safe");
}

- (void)willRemoveFromLogger:(id <DDLogger>)logger {
    loggerCount--;
}

@end
