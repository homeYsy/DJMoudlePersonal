//
//  UINavigationBar+BackgoundColor.h
//  CPS
//
//  Created by zhangsp on 2017/8/28.
//  Copyright © 2017年 zhangsp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BackgoundColor)


-(void)djSetBackgroundColor:(UIColor *)backgroundColor;
-(void)djHideShadowImageOrNot:(BOOL)bHidden;

- (void)dj_setBackgroundColor:(UIColor *)backgroundColor;
- (void)dj_setElementsAlpha:(CGFloat)alpha;
- (void)dj_setTranslationY:(CGFloat)translationY;
- (void)dj_reset;

// 导航栏 从上到下渐变
-(void)dj_setGradientBackgroundColor:(UIColor *)backgroundColor;
@end
