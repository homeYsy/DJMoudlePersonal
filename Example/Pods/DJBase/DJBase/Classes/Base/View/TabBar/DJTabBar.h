//
//  DJTabBar.h
//  DJBase
//  TabBar控件
//  Created by CSS on 2019/5/20.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJCenterButton.h"
@class DJButton;
@class DJTabBar;

@protocol DJTabBarDelegate <NSObject>
@optional
/*! 中间按钮点击会通过这个代理通知你通知 */
- (void)tabbar:(DJTabBar *)tabbar clickForCenterButton:(DJCenterButton *)centerButton;
/*! 默认返回YES，允许所有的切换，不过你通过TabBarController来直接设置SelectIndex来切换的是不会收到通知的。 */
- (BOOL)tabBar:(DJTabBar *)tabBar willSelectIndex:(NSInteger)index;
/*! 通知已经选择的控制器下标。 */
- (void)tabBar:(DJTabBar *)tabBar didSelectIndex:(NSInteger)index;
@end

@interface DJTabBar : UIView
/** tabbar按钮显示信息 */
@property(copy, nonatomic) NSArray<UITabBarItem *> *items;
/** 其他按钮 */
@property (strong , nonatomic) NSMutableArray <DJButton*>*btnArr;
/** 中间按钮 */
@property (strong , nonatomic) DJCenterButton *centerBtn;
/** 委托 */
@property(weak , nonatomic) id<DJTabBarDelegate>delegate;
@end
