//
//  UIColor+Helpers.h
//  DJBase
//
//  Created by CSS on 2019/5/31.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Helpers)

+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
- (NSString *)HEXString;

+ (UIColor *)colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue
                         alpha:(CGFloat)alpha;

+ (UIColor *)colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue;

+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

/// 随机颜色
+ (UIColor *)randomColor;

@end
