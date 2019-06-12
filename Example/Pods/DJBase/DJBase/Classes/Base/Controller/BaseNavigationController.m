//
//  BaseNavigationController.m
//  DJBase
//  BaseNavigationController 父类
//  Created by CSS on 2019/5/15.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import "djUtilsMacros.h"
#import "djFontAndColorMacros.h"
#import "UIView+Helpers.h"
#import "UIImage+Helpers.h"
#import "UIColor+Helpers.h"

#pragma mark - 声明
@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

#pragma mark - 实现
@implementation BaseNavigationController

//APP生命周期中 只会执行一次
+ (void)initialize {
    //导航栏主题 title文字属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    //导航背景色
    [navBar setBarTintColor:CNavBgColor];
    //导航文字颜色
    [navBar setTintColor:CNavBgFontColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:CNavBgFontColor, NSFontAttributeName : [UIFont boldSystemFontOfSize:17]}];
    [navBar setBackgroundImage:[UIImage imageWithColor:CNavBgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //去掉阴影线
    [navBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.interactivePopGestureRecognizer.delegate = nil;
    self.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark - UIGestureRecognizerDelegate
/** 决定是否出发手势 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.childViewControllers.count > 1;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

/** 解决tableView拖动问题 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return ![gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {// 非根控制器
        //只有一个控制器的时候禁止手势，防止卡死现象
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    
    [super pushViewController:viewController animated:YES];
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem*)item {
    return YES;
}

/** 当控制器pop完成之后做一次判断，根视图禁止手势 */
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    //只有一个控制器的时候禁止手势，防止卡死现象
    if (self.childViewControllers.count == 1) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[BaseViewController class]]) {
        BaseViewController *vc = (BaseViewController *)viewController;
        if (vc.isHidenNaviBar) {
            vc.view.top = 0;
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        }else {
            vc.view.top = kTopHeight;
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
        
    }
}

@end
