//
//  DJLogFormatter.h
//  DJBase
//
//  Created by CSS on 2019/5/21.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDLog.h"

@interface DJLogFormatter : NSObject<DDLogFormatter> {
    int loggerCount;
    NSDateFormatter *threadUnsafeDateFormatter;
}

@end
