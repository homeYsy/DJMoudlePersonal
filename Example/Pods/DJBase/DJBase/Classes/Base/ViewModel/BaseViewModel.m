//
//  BaseViewModel.m
//  DJBase
//  ViewModel 父类
//  Created by CSS on 2019/5/21.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "BaseViewModel.h"
#import "djUtilsMacros.h"

@implementation BaseViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - setter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

/** 获取数据 */
- (void)getDataRequest:(completionBlock)completion {
    DLog(@"请在子类重写方法:- (void)getDataRequest");
}

/** tableView头部刷新的网络请求 */
- (void)headerRefreshRequest:(completionBlock)completion {
    DLog(@"请在子类重写方法:- (void)headerRefreshRequest");
}

/** tableView底部刷新的网络请求 */
- (void)footerRefreshRequest:(completionBlock)completion {
    DLog(@"请在子类重写方法:- (void)footerRefreshRequest");
}

@end
