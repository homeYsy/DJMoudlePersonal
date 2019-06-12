//
//  DJBadgeView.h
//  DJBase
//  红点提醒/数字提醒
//  Created by 信息中心001 on 2019/5/19.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "DJTabBarConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJBadgeView : UIButton

/** remind number */
@property (copy , nonatomic) NSString *badgeValue;
/** remind color */
@property (copy , nonatomic) UIColor *badgeColor;

@end

NS_ASSUME_NONNULL_END
