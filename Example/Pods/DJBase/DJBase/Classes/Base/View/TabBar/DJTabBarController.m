//
//  DJTabBarController.m
//  DJBase
//  TabBarController
//  Created by CSS on 2019/5/20.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "DJTabBarController.h"
#if  __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_10_0
#import "UITabBarItem+BadgeColor.h"
#endif

@interface DJTabBarController ()
/** center button of place ( -1:none center button >=0:contain center button) */
@property(assign , nonatomic) NSInteger centerPlace;
/** Whether center button to bulge */
@property(assign , nonatomic,getter=is_bulge) BOOL bulge;
/** items */
@property (nonatomic,strong) NSMutableArray <UITabBarItem *>*items;
/** 安全区域 */
@property(nonatomic,assign) CGFloat safeBottomInsets;
@end

@implementation DJTabBarController{int tabBarItemTag;BOOL firstInit;}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.centerPlace = -1;
    
    //Observer Device Orientation
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OrientationDidChange) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

/**
 *  Initialize selected
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!firstInit)
    {
        firstInit = YES;
        NSInteger index = [DJTabBarConfig shared].selectIndex;
        if (index < 0) {
            self.selectedIndex = (self.centerPlace != -1 && self.items[self.centerPlace].tag != -1)
            ? self.centerPlace
            : 0;
        }else if (index >= self.viewControllers.count){
            self.selectedIndex = self.viewControllers.count-1;
        }
        else{
            self.selectedIndex = index;
        }
    }
}

/**
 *  Add other button for child’s controller
 */
- (void)addChildController:(id)Controller title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    UIViewController *vc = [self findViewControllerWithobject:Controller];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    vc.tabBarItem.tag = tabBarItemTag++;
    [self.items addObject:vc.tabBarItem];
    [self addChildViewController:Controller];
}

/**
 *  Add center button
 */
- (void)addCenterController:(id)Controller bulge:(BOOL)bulge title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    _bulge = bulge;
    if (Controller) {
        [self addChildController:Controller title:title imageName:imageName selectedImageName:selectedImageName];
        self.centerPlace = tabBarItemTag-1;
    }else{
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title
                                                          image:[UIImage imageNamed:imageName]
                                                  selectedImage:[UIImage imageNamed:selectedImageName]];
        item.tag = -1;
        [self.items addObject:item];
        self.centerPlace = tabBarItemTag;
    }
}

/**
 *  Device Orientation func
 */
- (void)OrientationDidChange{
    self.tabbar.frame = [self tabbarFrame];
}

- (CGRect)tabbarFrame{
    return CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49,
                      [UIScreen mainScreen].bounds.size.width, 49);
}

/**
 *  getter
 */
- (DJTabBar *)tabbar{
    if (self.items.count && !_tabbar) {
        _tabbar = [[DJTabBar alloc]initWithFrame:[self tabbarFrame]];
        [_tabbar setValue:self forKey:@"controller"];
        [_tabbar setValue:[NSNumber numberWithBool:self.bulge] forKey:@"bulge"];
        [_tabbar setValue:[NSNumber numberWithInteger:self.centerPlace] forKey:@"centerPlace"];
        _tabbar.items = self.items;
        
        //remove tabBar
        for (UIView *loop in self.tabBar.subviews) {
            [loop removeFromSuperview];
        }
        self.tabBar.hidden = YES;
        [self.tabBar removeFromSuperview];
    }
    return _tabbar;
}
- (NSMutableArray <UITabBarItem *>*)items{
    if(!_items){
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)InitializeTabbar{
    [_tabbar setValue:[NSNumber numberWithBool:self.bulge] forKey:@"bulge"];
    [_tabbar setValue:[NSNumber numberWithInteger:self.centerPlace] forKey:@"centerPlace"];
    _tabbar.items = self.items;
}


/**
 *  Update current select controller
 */
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    if (selectedIndex >= self.viewControllers.count){
        @throw [NSException exceptionWithName:@"selectedTabbarError"
                                       reason:@"No controller can be used,Because of index beyond the viewControllers,Please check the configuration of tabbar."
                                     userInfo:nil];
    }
    [super setSelectedIndex:selectedIndex];
    UIViewController *viewController = [self findViewControllerWithobject:self.viewControllers[selectedIndex]];
    [self.tabbar removeFromSuperview];
    [viewController.view addSubview:self.tabbar];
    viewController.extendedLayoutIncludesOpaqueBars = YES;
    [self.tabbar setValue:[NSNumber numberWithInteger:selectedIndex] forKeyPath:@"selectButtoIndex"];
}


/**
 Layout tabBar for superView
 */
- (void)setLayoutTabBar:(UIView *)layoutTabBar {
    self.safeBottomInsets = 0;
    if (@available(iOS 11.0, *)) {
        self.safeBottomInsets = self.view.safeAreaInsets.bottom;
    }
    
    CGFloat additionalHeight = self.view.frame.origin.y;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    CGRect rect = CGRectMake(0,
                             h-49-self.safeBottomInsets-layoutTabBar.frame.origin.y - additionalHeight,
                             layoutTabBar.frame.size.width,
                             49+self.safeBottomInsets);
    self.tabbar.frame = rect;
}

/**
 *  Catch viewController
 */
- (UIViewController *)findViewControllerWithobject:(id)object{
    while ([object isKindOfClass:[UITabBarController class]] || [object isKindOfClass:[UINavigationController class]]){
        object = ((UITabBarController *)object).viewControllers.firstObject;
    }
    return object;
}

/**
 *  hidden tabbar and do animated
 */
- (void)setDJTabBarHidden:(BOOL)hidden animated:(BOOL)animated{
    NSTimeInterval time = animated ? 0.3 : 0.0;
    if (self.tabbar.isHidden) {
        self.tabbar.hidden = NO;
        [UIView animateWithDuration:time animations:^{
            self.tabbar.transform = CGAffineTransformIdentity;
        }];
    }else{
        CGFloat h = self.tabbar.frame.size.height;
        [UIView animateWithDuration:time-0.1 animations:^{
            self.tabbar.transform = CGAffineTransformMakeTranslation(0,h);
        }completion:^(BOOL finished) {
            self.tabbar.hidden = YES;
        }];
    }
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

@end
