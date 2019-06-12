//
//  UIFont+Helpers.h
//  DJBase
//
//  Created by CSS on 2019/5/31.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IPHONE6_INCREMENT 2
#define IPHONE6PLUS_INCREMENT 3
#define IPHONE6PLUS_UP_INCREMENT 4
#define IS_IPHONEX_INCREMENT 4
@interface UIFont (Helpers)

/// 自适应字体大小
+ (CGFloat)adjustFontSize:(CGFloat)fontsize;

@end
