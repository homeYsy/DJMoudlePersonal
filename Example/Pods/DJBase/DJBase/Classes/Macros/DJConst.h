//
//  DJConst.h
//  DJBase
//  常用宏定义
//  Created by CSS on 2019/6/3.
//  Copyright © 2019年 djkj. All rights reserved.
//

#ifndef DJConst_h
#define DJConst_h

#define SELF_BUNDLE [NSBundle bundleForClass:[self class]]
#define UIImageName(x) [UIImage imageNamed:x inBundle:SELF_BUNDLE compatibleWithTraitCollection:nil]

#define WEAK_SELF __weak typeof(self) weakSelf = self
#define STRONG_SELF __strong typeof(weakSelf) self = weakSelf

#define kDeviceVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define GQAlertShow(messageText,buttonName) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:(messageText) \
delegate:nil cancelButtonTitle:(buttonName) otherButtonTitles: nil];\
[alert show];

#endif /* DJConst_h */
