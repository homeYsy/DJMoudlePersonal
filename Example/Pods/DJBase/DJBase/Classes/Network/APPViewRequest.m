//
//  APPViewRequest.m
//  DJBase
//  页面请求参数
//  Created by CSS on 2019/5/13.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "APPViewRequest.h"

@implementation APPViewRequest

+ (instancetype)sharedManager {
    APPViewRequest *manager = [[APPViewRequest alloc] init];
    manager.afn_showHud = YES;
    manager.afn_showHudMsg = @"";
    return manager;
}


@end
