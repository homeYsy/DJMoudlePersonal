//
//  UIScreen+Helpers.h
//  DJBase
//
//  Created by CSS on 2019/5/31.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (Helpers)

/// 屏幕尺寸
+ (CGSize)screenSize;

/// 是否是竖屏
+ (BOOL)isPortrait;

/// 屏幕宽度
+ (CGFloat)screenWidth;

/// 屏幕高度
+ (CGFloat)screenHeight;

/// 缩放系数
+ (CGFloat)screenScale;

/// 状态栏高度
+ (CGFloat)statusBarHeight;

/// 是否是全面屏手机
+ (BOOL)isFullScheenPhone;

/// 底部安全区域高度
+ (CGFloat)bottomSafeAreaHeight;

@end
