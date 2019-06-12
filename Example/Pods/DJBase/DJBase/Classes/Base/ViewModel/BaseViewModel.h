//
//  BaseViewModel.h
//  DJBase
//  ViewModel 父类
//  Created by CSS on 2019/5/21.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+APPViewRequest.h"
#import <MJExtension/MJExtension.h>

/** 请求操作完成 */
typedef void (^completionBlock)(BOOL success, NSString *des);

@interface BaseViewModel : NSObject
@property(nonatomic, strong) NSMutableArray *dataArray;//数据源
//获取数据
- (void)getDataRequest:(completionBlock)completion;
//tableView头部刷新的网络请求
- (void)headerRefreshRequest:(completionBlock)completion;
//tableView底部刷新的网络请求
- (void)footerRefreshRequest:(completionBlock)completion;

@end
