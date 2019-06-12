//
//  UpdateAPPConfigure.h
//  DJUpdateAPPCheck
//
//  Created by zhangsp on 2018/10/31.
//  Copyright © 2018 zhangsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpdateAPPConfigure : NSObject

/// 服务地址.
@property(nonatomic, copy) NSString *serviceAddress;

/// 测试环境1 正式环境2. 默认为1
@property(nonatomic, strong) NSNumber *appGroup;

@property(nonatomic, strong) UIViewController *vc;

/** 网络配置的单例对象 */
+ (instancetype)shared;

/**
 校验版本更新
 */
-(void)checkVersion;


/**
 上传设备信息
 */
-(void)submitCustomerInfo:(NSString *)versionId;
@end

NS_ASSUME_NONNULL_END
