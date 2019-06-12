//
//  AppDelegate+DDLog.m
//  DJBase
//  日志
//  Created by CSS on 2019/5/21.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "DJLog.h"
#import "DJLogFormatter.h"

@implementation DJLog

- (void)initializeWithApplication {
    //启用XcodeColors
    setenv("XcodeColors", "YES", 0);
    
    [DDTTYLogger sharedInstance].logFormatter = [[DJLogFormatter alloc] init]; // 自定义日志
    // DDTTYLogger，你的日志语句将被发送到Xcode控制台
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // DDASLLogger，你的日志语句将被发送到苹果文件系统、你的日志状态会被发送到 Console.app
//    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
    // 缓存
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    DDLogFileManagerDefault* logFileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:documentsDirectory];
    DDLogInfo(@"log path = %@",documentsDirectory);
    // DDFileLogger，你的日志语句将写入到一个文件中，默认路径在沙盒的Library/Caches/Logs/目录下，文件名为bundleid+空格+日期.log。
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:logFileManager];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 刷新频率为24小时
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7; // 保存一周的日志，即7天
    [DDLog addLogger:fileLogger];
    
    
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    //修改颜色
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor orangeColor] backgroundColor:nil forFlag:DDLogFlagWarning];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:DDLogFlagError];
    
    // 产生Log
    DDLogVerbose(@"Verbose");   // 详细日志
    DDLogDebug(@"Debug");       // 调试日志
    DDLogInfo(@"Info");         // 信息日志
    DDLogWarn(@"Warn");         // 警告日志
    DDLogError(@"Error");       // 错误日志
}

@end
