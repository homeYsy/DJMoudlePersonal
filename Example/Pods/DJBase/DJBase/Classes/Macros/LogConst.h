//
//  LogConst.h
//  DJBase
//  日志宏定义
//  Created by CSS on 2019/6/3.
//  Copyright © 2019年 djkj. All rights reserved.
//

#ifndef LogConst_h
#define LogConst_h

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%d\t%s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#endif /* LogConst_h */
