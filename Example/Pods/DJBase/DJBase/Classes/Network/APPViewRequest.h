//
//  APPViewRequest.h
//  DJBase
//  页面请求参数
//  Created by CSS on 2019/5/13.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface APPViewRequest : NSObject

@property (nonatomic, assign) BOOL afn_showHud;                 //显示等待框
@property (nonatomic, assign) NSString *afn_showHudMsg;         //等待框显示内容

+ (instancetype)sharedManager;

@end

NS_ASSUME_NONNULL_END
