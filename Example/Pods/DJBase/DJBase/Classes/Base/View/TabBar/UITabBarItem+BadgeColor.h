//
//  UITabBarItem+BadgeColor.h
//  DJBase
//
//  Created by 信息中心001 on 2019/5/19.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBarItem (BadgeColor)
@property (nonatomic, readwrite, copy, nullable) UIColor *badgeColor;
@end

NS_ASSUME_NONNULL_END
