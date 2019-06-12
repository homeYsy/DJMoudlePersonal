//
//  AFNLogger.h
//  DJBase
//  AFN日志打印
//  Created by CSS on 2019/5/28.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNLogger : NSObject

+ (void)printWithRequest:(NSString *)url
                 type:(NSString *)type
                  params:(id)params;

+ (void)printWithResponse:(NSString *)url
                  result:(id)result;

@end
