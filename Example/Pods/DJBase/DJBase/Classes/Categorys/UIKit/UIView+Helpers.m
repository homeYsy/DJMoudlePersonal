//
//  UIView+Helpers.m
//  DJBase
//
//  Created by CSS on 2019/5/31.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "UIView+Helpers.h"

@implementation UIView (Helpers)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += [view left];
    }
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += [view top];
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += [view left];
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += [view top];
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame {
    return CGRectMake([self screenViewX], [self screenViewY], [self width], [self height]);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y = 0;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += [view left];
        y += [view top];
    }
    return CGPointMake(x, y);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController *)viewController {
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

- (UIImage *)imageFromView {
    CGSize size = self.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image = [UIImage imageWithCGImage:image.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    return image;
}

- (CGRect)convertRectWithWindow {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [self convertRect:self.bounds toView:window];
    return rect;
}

/// 背景色
+ (UIView*)createWithBackgroundColor:(UIColor*)color {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor=color;
    return view;
}

/// 增加遮罩 alpha为遮罩透明度
- (void)addMaskViewWithAlpha:(CGFloat)alpha {
    [self layoutIfNeeded];
    UIView *view = [UIView createWithBackgroundColor:[UIColor colorWithWhite:0 alpha:alpha]];
    view.frame = self.bounds;
    [self addSubview:view];
}

/// 添加边界线
- (void)addLineWithDirection:(LineDirection)direction Color:(UIColor *)color Width:(CGFloat)width {
    UIView *line = [UIView new];
    line.backgroundColor = color;
    [self addSubview:line];
    if (direction & LineDirectionTop) {
        line.frame = CGRectMake(0, 0, self.width, width);
    }
    
    if (direction & LineDirectionBottom) {
        line.frame = CGRectMake(0, self.height-width, self.width, width);
    }
    
    if (direction & LineDirectionLeft) {
        line.frame = CGRectMake(0, 0, width, self.height);
    }
    
    if (direction & LineDirectionRight) {
        line.frame = CGRectMake(0, self.width-width, width, self.height);
    }
}


/**
 添加阴影
 
 @param color 阴影颜色
 @param offset 阴影偏移量
 @param radius 阴影圆角
 */
- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

// 设置圆角
- (void)setCornerWithRadius:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

// 设置圆角及边框
- (void)setCornerWithRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    [self setCornerWithRadius:radius];
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

/// 设置部分圆角
- (void)setCorners:(UIRectCorner)rectCorner cornerRadii:(CGFloat)cornewRadii {
    [self layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornewRadii, cornewRadii)];
    CAShapeLayer *maskLayout = [[CAShapeLayer alloc]init];
    maskLayout.frame = self.bounds;
    maskLayout.path = maskPath.CGPath;
    self.layer.mask = maskLayout;
}


/**
 为视图添加从左到右的两种颜色渐变
 @param startColor 开始颜色
 @param endColor 结束颜色
 */
- (void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    [self addGradientWithColors:@[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor] locations:@[@(0.0),@(1.0)]];
}

/**
 为视图添加从左到右的带圆角的两种颜色渐变
 @param startColor 开始颜色
 @param endColor 结束颜色
 @param cornerRadius 圆角大小
 */
- (void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius {
    [self addGradientWithColors:@[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor] locations:@[@(0.0),@(1.0)] cornerRadius:cornerRadius];
}

/**
 为视图添加从左到右的带部分圆角的两种颜色渐变
 @param startColor 开始颜色
 @param endColor 结束颜色
 @param rectCorners 圆角位置
 @param cornewRadii 圆角大小
 */
- (void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor rectCorners:(UIRectCorner)rectCorners cornerRadii:(CGFloat)cornewRadii {
    [self addGradientWithColors:@[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor] locations:@[@(0.0),@(1.0)] rectCorners:rectCorners cornerRadii:cornewRadii];
}

/**
 为视图添加从左到右的渐变色
 @param colors 颜色数组（@[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor]）
 @param locations 位置数组（@[@0.3, @0.5, @1.0]）
 */
- (void)addGradientWithColors:(NSArray *)colors locations:(NSArray *)locations {
    [self layoutIfNeeded];
    for (NSInteger i = self.layer.sublayers.count - 1; i>=0; i--) {
        CALayer *layer = self.layer.sublayers[i];
        if ([layer isKindOfClass:[CAGradientLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.bounds;
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

/**
 为视图添加从左到右带圆角的渐变色
 @param colors 颜色数组（@[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor]）
 @param locations 位置数组（@[@0.3, @0.5, @1.0]）
 @param cornerRadius 圆角大小
 */
- (void)addGradientWithColors:(NSArray *)colors locations:(NSArray *)locations cornerRadius:(CGFloat)cornerRadius {
    [self layoutIfNeeded];
    for (NSInteger i = self.layer.sublayers.count - 1; i>=0; i--) {
        CALayer *layer = self.layer.sublayers[i];
        if ([layer isKindOfClass:[CAGradientLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.bounds;
    gradientLayer.cornerRadius = cornerRadius;
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

/**
 为视图添加从左到右带圆角的渐变色
 
 @param colors 颜色数组（@[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor]）
 @param locations 位置数组（@[@0.3, @0.5, @1.0]）
 @param rectCorners 圆角位置
 @param cornewRadii 圆角大小
 */
- (void)addGradientWithColors:(NSArray *)colors locations:(NSArray *)locations rectCorners:(UIRectCorner)rectCorners cornerRadii:(CGFloat)cornewRadii {
    [self layoutIfNeeded];
    for (NSInteger i = self.layer.sublayers.count - 1; i>=0; i--) {
        CALayer *layer = self.layer.sublayers[i];
        if ([layer isKindOfClass:[CAGradientLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.bounds;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorners cornerRadii:CGSizeMake(cornewRadii, cornewRadii)];
    CAShapeLayer *maskLayout = [[CAShapeLayer alloc]init];
    maskLayout.frame = self.bounds;
    maskLayout.path = maskPath.CGPath;
    gradientLayer.mask = maskLayout;
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
}


/// 取消所有页面的第一响应者
+ (void)hideKeyBoard {
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        for (UIView *view in window.subviews) {
            [view dismissAllKeyBoard];
        }
    }
}

/// 取消当前视图下的所有第一响应者
- (BOOL)dismissAllKeyBoard {
    if ([self isFirstResponder]) {
        [self resignFirstResponder];
        return YES;
    }
    for (UIView *subView in self.subviews) {
        if ([subView dismissAllKeyBoard]) {
            return YES;
        }
    }
    return NO;
}

@end
