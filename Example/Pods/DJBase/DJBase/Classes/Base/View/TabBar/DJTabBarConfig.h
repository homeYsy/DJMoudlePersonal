//
//  DJTabBarConfig.h
//  DJBase
//  TabBar配置
//  Created by 信息中心001 on 2019/5/19.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJTabBarConfig : NSObject
/** 设置文字颜色 */
@property (strong , nonatomic) UIColor *textColor;
/** 设置文字选中颜色 */
@property (strong , nonatomic) UIColor *selectedTextColor;
/** 背景颜色 */
@property(strong , nonatomic) UIColor *backgroundColor;
/** 指定的初始化控制器 */
@property(assign , nonatomic) NSInteger selectIndex;
/** 是否存在bar底部分割线 */
@property(assign , nonatomic) BOOL haveBorder;
/** bar底部分割线的高度 */
@property(assign , nonatomic) CGFloat borderHeight;
/** bar的底部分割线颜色 */
@property(strong , nonatomic) UIColor *bordergColor;
/** 中间按钮所在位置 */
@property (nonatomic,assign) NSInteger centerBtnIndex;

/**
 *  外观配置的单例对象
 */
+ (instancetype)shared;
@end

NS_ASSUME_NONNULL_END
