//
//  DJButton.m
//  DJBase
//  其他按钮
//  Created by CSS on 2019/5/20.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "DJButton.h"
#import "DJBadgeView.h"

@interface DJButton()
/** remind number */
@property (weak , nonatomic) DJBadgeView * badgeView;
@end

@implementation DJButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[DJTabBarConfig shared].textColor forState:UIControlStateNormal];
        [self setTitleColor:[DJTabBarConfig shared].selectedTextColor forState:UIControlStateSelected];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    //适配iPhone X, 增加安全区域
    CGFloat height = self.superview.frame.size.height - [[self.superview valueForKeyPath:@"controller.safeBottomInsets"]floatValue];;
    if (self.titleLabel.text && ![self.titleLabel.text isEqualToString:@""]) {
        self.titleLabel.frame = CGRectMake(0, height-16, width, 16);
        self.imageView.frame = CGRectMake(0 , 0, width, 35);
    }
    else{
        self.imageView.frame = CGRectMake(0 , 0, width, height);
    }
}

/**
 *  Set red dot item
 */
- (void)setItem:(UITabBarItem *)item {
    self.badgeView.badgeValue = item.badgeValue;
    self.badgeView.badgeColor = item.badgeColor;
}

/**
 *  getter
 */
- (DJBadgeView *)badgeView {
    if (!_badgeView) {
        DJBadgeView * badgeView = [[DJBadgeView alloc] init];
        _badgeView = badgeView;
        [self addSubview:badgeView];
    }
    return _badgeView;
}


- (void)setHighlighted:(BOOL)highlighted{
}

@end
