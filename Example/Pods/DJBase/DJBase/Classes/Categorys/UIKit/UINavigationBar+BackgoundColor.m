//
//  UINavigationBar+BackgoundColor.m
//  CPS
//
//  Created by zhangsp on 2017/8/28.
//  Copyright © 2017年 zhangsp. All rights reserved.
//

#import "UINavigationBar+BackgoundColor.h"
#import <objc/runtime.h>
#import "djUtilsMacros.h"

static char overlayKey;
CAGradientLayer *gradientLayer;
@implementation UINavigationBar (BackgroundColor)

-(UIView *)overlay{
    return objc_getAssociatedObject(self, &overlayKey);
}

-(void)setOverlay:(UIView *)overlay{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)djSetBackgroundColor:(UIColor *)backgroundColor{
    if (!self.overlay) {
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        UIView *backgroundView = [self DJGetBackgroundView];
        self.overlay = [[UIView alloc] initWithFrame:backgroundView.bounds];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [backgroundView insertSubview:self.overlay atIndex:0];
    }
    if (gradientLayer) {
        [gradientLayer removeFromSuperlayer];
        gradientLayer = nil;
    }
    self.overlay.backgroundColor = backgroundColor;
}
// 导航栏 从上到下渐变
-(void)dj_setGradientBackgroundColor:(UIColor *)backgroundColor{
    if (!self.overlay) {
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        UIView *backgroundView = [self DJGetBackgroundView];
        self.overlay = [[UIView alloc] initWithFrame:backgroundView.bounds];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [backgroundView insertSubview:self.overlay atIndex:0];
    }
    if (!gradientLayer) {
        //渐变
        gradientLayer = [CAGradientLayer layer];
        gradientLayer.startPoint = CGPointMake(0, 0);//（0，0）表示从左上角开始变化。默认值是(0.5,0.0)表示从x轴为中间，y为顶端的开始变化
        gradientLayer.endPoint = CGPointMake(0, 1);//（1，1）表示到右下角变化结束。默认值是(0.5,1.0)  表示从x轴为中间，y为低端的结束变化
        gradientLayer.colors = [NSArray arrayWithObjects:(id)backgroundColor.CGColor,(id)RGBA(255, 255, 255, 0.1).CGColor, nil];
        gradientLayer.frame = self.overlay.layer.bounds;
        gradientLayer.startPoint = CGPointMake(0,0);
        gradientLayer.endPoint = CGPointMake(0,1);
        [self.overlay.layer insertSublayer:gradientLayer atIndex:0];
        self.overlay.backgroundColor = RGBA(255, 255, 255, 0);
    }
    
}


-(UIView*)DJGetBackgroundView{
    //iOS10之前为 _UINavigationBarBackground, iOS10为 _UIBarBackground
    //_UINavigationBarBackground实际为UIImageView子类，而_UIBarBackground是UIView子类
    //之前setBackgroundImage直接赋值给_UINavigationBarBackground，现在则是设置后为_UIBarBackground增加一个UIImageView子控件方式去呈现图片
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        
        UIView *_UIBackground;
        NSString *targetName = @"_UIBarBackground";
        Class _UIBarBackgroundClass = NSClassFromString(targetName);
        
        for (UIView *subview in self.subviews) {
            if ([subview isKindOfClass:_UIBarBackgroundClass.class]) {
                _UIBackground = subview;
                break;
            }
        }
        return _UIBackground;
    }
    else {
        
        UIView *_UINavigationBarBackground;
        NSString *targetName = @"_UINavigationBarBackground";
        Class _UINavigationBarBackgroundClass = NSClassFromString(targetName);
        
        for (UIView *subview in self.subviews) {
            if ([subview isKindOfClass:_UINavigationBarBackgroundClass.class]) {
                _UINavigationBarBackground = subview;
                break;
            }
        }
        return _UINavigationBarBackground;
    }
}

#pragma mark - shadow view

-(void)djHideShadowImageOrNot:(BOOL)bHidden{
    UIView *bgView = [self DJGetBackgroundView];
    
    //shadowImage应该是只占一个像素，即1.0/scale
    for (UIView *subview in bgView.subviews) {
        
        if (CGRectGetHeight(subview.bounds) <= 1.0) {
            subview.hidden = bHidden;
        }
    }
}


// zwd
- (void)dj_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
    if (gradientLayer) {
        [gradientLayer removeFromSuperlayer];
        gradientLayer = nil;
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)dj_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)dj_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
        }
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
            obj.alpha = alpha;
        }
    }];
}

- (void)dj_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}


@end
