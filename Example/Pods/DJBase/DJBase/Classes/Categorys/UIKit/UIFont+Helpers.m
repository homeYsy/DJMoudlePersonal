//
//  UIFont+Helpers.m
//  DJBase
//
//  Created by CSS on 2019/5/31.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "UIFont+Helpers.h"
#import "djUtilsMacros.h"

@implementation UIFont (Helpers)

+ (CGFloat)adjustFontSize:(CGFloat)fontsize {
    CGFloat newFont;
    if (IS_IPHONE_5) {
        newFont = fontsize;
    } else if (IS_IPHONE_6) {
        newFont = fontsize + IPHONE6_INCREMENT;
    } else if (IS_IPHONE_6_PLUS) {
        newFont = fontsize + IPHONE6PLUS_INCREMENT;
    } else if (IS_IPHONE_6_PLUS_UP) {
        newFont = fontsize + IPHONE6PLUS_UP_INCREMENT;
    } else if (IS_IPHONEX) {
        newFont = fontsize + IS_IPHONEX_INCREMENT;
    } else {
        newFont = fontsize;
    }
    return newFont;
}

@end
