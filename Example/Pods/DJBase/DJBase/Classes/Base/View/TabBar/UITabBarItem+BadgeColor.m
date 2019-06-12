//
//  UITabBarItem+BadgeColor.m
//  DJBase
//
//  Created by 信息中心001 on 2019/5/19.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "UITabBarItem+BadgeColor.h"

static const char itemBadgeColor_Key;

@implementation UITabBarItem (BadgeColor)
@dynamic badgeColor;

- (void)setBadgeColor:(UIColor *)badgeColor{
    [self willChangeValueForKey:@"badgeColor"];
    objc_setAssociatedObject(self, &itemBadgeColor_Key, badgeColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"badgeColor"];
}

- (UIColor *)badgeColor{
    return objc_getAssociatedObject(self, &itemBadgeColor_Key);
}

@end
