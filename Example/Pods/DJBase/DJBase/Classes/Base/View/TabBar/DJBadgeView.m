//
//  DJBadgeView.m
//  DJBase
//  红点提醒/数字提醒
//  Created by 信息中心001 on 2019/5/19.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "DJBadgeView.h"

@implementation DJBadgeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        //set protection of image area
        UIImage *image = [UIImage imageNamed:@"TabBar.bundle/main_badge"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        [self setBackgroundImage:image forState:UIControlStateNormal];
        //set text of alignment
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //Observer Device Orientation
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OrientationDidChange) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    }
    return self;
}

/**
 *  Set remind number
 */
- (void)setBadgeValue:(NSString *)badgeValue
{
    if (![_badgeValue isEqualToString:badgeValue])
    {
        _badgeValue = badgeValue;
        [self setTitle:([badgeValue isEqualToString:@"remind"] ? nil : badgeValue)
              forState:UIControlStateNormal];
    }
}

/**
 *  Set color for remind Badge
 */
- (void)setBadgeColor:(UIColor *)badgeColor{
    if (badgeColor!=nil && ![_badgeColor isEqual:badgeColor]) {
        UIImage *image = [UIImage imageNamed:@"TabBar.bundle/main_badge"];
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        CGContextRef ref = UIGraphicsGetCurrentContext();
        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
        CGContextClipToMask(ref, rect, image.CGImage);
        [badgeColor setFill];
        CGContextFillRect(ref, rect);
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        [self setBackgroundImage:image forState:UIControlStateNormal];
        _badgeColor = badgeColor;
    }
}

- (void)OrientationDidChange{
    if (_badgeValue != nil) {
        [self performSelector:@selector(layoutSubviews) withObject:nil afterDelay:0.05];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    /**
     *  red dot remind
     */
    if ([_badgeValue isEqualToString:@"remind"]) {
        self.frame = CGRectMake(self.superview.frame.size.width/2+7, 4,
                                self.currentBackgroundImage.size.width/2,
                                self.currentBackgroundImage.size.height/2);
        return;
    }
    
    /**
     *  number remind
     */
    if ([_badgeValue integerValue] <= 0) {
        _badgeValue = nil;
        self.hidden = YES;
        return;
    }
    
    
    int n = 0;
    self.hidden = NO;
    if ([_badgeValue integerValue]>100) {
        n = 10;
        [self setTitle:@"99+" forState:UIControlStateNormal];
    }
    else{
        n = [_badgeValue integerValue] > 9 ? 8 : 0; //number beyond 9 to broaden
        [self setTitle:_badgeValue forState:UIControlStateNormal];
    }
    
    self.frame = CGRectMake(self.superview.frame.size.width/2+5, 1,
                            self.currentBackgroundImage.size.width+n,
                            self.currentBackgroundImage.size.height);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

@end
