//
//  UpdateAPPConfigure.m
//  DJUpdateAPPCheck
//
//  Created by zhangsp on 2018/10/31.
//  Copyright © 2018 zhangsp. All rights reserved.
//

#import "UpdateAPPConfigure.h"
#import "UIViewController+APPViewRequest.h"
#import <UIKit/UIKit.h>
#import "MBProgressHUD+Custom.h"
#import "UpdatePopView.h"
#import "djUtilsMacros.h"
#import "NSString+Helpers.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define UPDATE_URL @"http://192.168.23.170:37527/djcpsversion/"
#define UPDATE_Suffix @"do"
@implementation UpdateAPPConfigure

/** 网络配置的单例对象 */
+ (instancetype)shared {
    static UpdateAPPConfigure *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[UpdateAPPConfigure alloc]init];
        config.serviceAddress = @"http://192.168.2.76:8088/";
        config.appGroup = @1;
    });
    return config;
}

/**
 校验版本更新
 */
-(void)checkVersion
{
    if (!self.vc) {
        DLog(@"未获取到当前控制器");
        return;
    }
    
    NSDictionary *param = @{@"identifier":@"com.djkg.bi", // [[NSBundle mainBundle] bundleIdentifier]
                            @"systemPlatform":@2,   //1 Android ;2 iOS
                            @"appGroup":self.appGroup}; //测试环境1 正式环境2
    NSString *urlString = [NSString stringWithFormat:@"%@query/getNewestApp.%@",UPDATE_URL,UPDATE_Suffix];
    WS(weakSelf)
    [self.vc postUrl:urlString params:param success:^(id data) {
        NSDictionary *resultDic = data;
        if (resultDic && ((NSNull *)resultDic != [NSNull null])) {
            [weakSelf updateEnterpriseAPP:resultDic];
        }
    }failure:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}


//测试版本 启动的自动更新
-(void)updateEnterpriseAPP:(NSDictionary *)dic
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version_Remote = dic[@"version"];//服务端的版本
    NSString *app_Version_local = [infoDictionary objectForKey:@"CFBundleShortVersionString"];// app版本
    //将版本号按照.切割后存入数组中
    NSArray *localArray = [app_Version_local componentsSeparatedByString:@"."];
    NSArray *remoteArray = [app_Version_Remote componentsSeparatedByString:@"."];
    NSInteger minArrayLength = MIN(localArray.count, remoteArray.count);
    BOOL needUpdate = NO;
    for(int i=0;i<minArrayLength;i++){//以最短的数组长度为遍历次数,防止数组越界
        //取出每个部分的字符串值,比较数值大小
        NSString *localElement = localArray[i];
        NSString *remoteElement = remoteArray[i];
        NSInteger  localValue =  localElement.integerValue;
        NSInteger  appValue = remoteElement.integerValue;
        if(localValue<appValue) { ///低于服务器
            //从前往后比较数字大小,一旦分出大小,跳出循环
            needUpdate = YES;
            break;
        }
        else if (localValue>appValue)
        {
            needUpdate = NO;
            break;
        }
        else{
            needUpdate = NO;
        }
    }
    if (needUpdate) {
        //弹出提示更新弹框
        WS(weakSelf)
        UpdatePopView *popup = [[UpdatePopView alloc] initWithStyleTitle:dic[@"version"] message:dic[@"updateLog"] cancelText:dic[@"isForce"] updateBlock:^{
            if (dic[@"versionId"]) {
                // 上传终端信息
                [weakSelf submitCustomerInfo:dic[@"versionId"]];
            }
            NSString *url = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@%@",weakSelf.serviceAddress,dic[@"appUrl"]] ;
            [weakSelf goWebAction:url];
        } cancelBlock:nil];
        [popup show];
    }
}


-(void)goWebAction:(NSString *)webUrl{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:webUrl];
    
    if (@available(iOS 10.0, *)) {
        [application openURL:URL options:@{}
           completionHandler:^(BOOL success) {
               NSLog(@"Open %@: %d",webUrl,success);
           }];
    } else {
        [application openURL:URL];
    }
}

/**
 上传设备信息
 */
-(void)submitCustomerInfo:(NSString *)versionId
{
    if (!self.vc) {
        DLog(@"未获取到当前控制器");
        return;
    }
    NSString *urlString = [NSString stringWithFormat:@"%@upload/feedback.%@",UPDATE_URL,UPDATE_Suffix];
    NSDictionary *param = @{@"model":[NSString deviceModel],
                            @"system":[NSString stringWithFormat:@"iOS%@", [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"]],
                            @"brand":@"iPhone",
                            @"versionId":[NSString stringWithFormat:@"%@",versionId]
                            };
    
    [self.vc postUrl:urlString params:param success:^(id data) {
        DLog(@"上传成功");
    }failure:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}
@end
