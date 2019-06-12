//
//  BaseViewController.h
//  DJBase
//  UIViewController 父类
//  Created by CSS on 2019/5/15.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import <MJRefresh/MJRefresh.h>
#import "MBProgressHUD+Custom.h"
#import "UIViewController+APPViewRequest.h"

@interface BaseViewController : UIViewController

#pragma mark - 控件绑定
//tableView
@property(nonatomic, weak) IBOutlet UITableView *tableView;
//collectionView
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;


#pragma mark - 导航栏
/** 是否显示返回按钮,默认情况是YES */
@property(nonatomic, assign) BOOL isShowLeftBack;
/** 是否隐藏导航栏 */
@property(nonatomic, assign) BOOL isHidenNaviBar;


#pragma mark -  下拉刷新、上拉加载
/** 下拉刷新、上拉加载 */
- (void)refreshTableView;
/** 停止刷新 */
- (void)tableViewStopRefreshing;
/** 开始刷新 */
- (void)refreshTableViewIsRefreshing;


#pragma mark - 空白页
//是否显示空数据页面  默认为显示
@property(nonatomic, assign) BOOL isShowEmptyData;

//空数据页面的title -- 可不传，默认为：暂无任何数据
@property(nonatomic, strong) NSString *noDataTitle;
//空数据页面的图片 -- 可不传，默认图片为：NoData
@property(nonatomic, strong) NSString *noDataImgName;

//显示副标题的时候，需要赋值副标题，否则不显示
@property(nonatomic, strong) NSString *noDataDetailTitle;

//按钮标题、图片 --不常用
@property(nonatomic, strong) NSString *btnTitle;
@property(nonatomic, strong) NSString *btnImgName;

//空白页按钮事件
-(void)buttonEvent;


#pragma mark - 添加导航栏左右按钮
/**
 导航栏添加文本按钮

 @param titles  文本数组
 @param isLeft  是否是左边 非左即右
 @param target  目标
 @param action  点击方法
 @param tags    tags数组 回调区分用
 */
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

/**
 导航栏添加图标按钮

 @param imageNames  图标数组
 @param isLeft      是否是左边 非左即右
 @param target      目标
 @param action      点击方法
 @param tags        tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

/**
 *  默认返回按钮的点击事件，默认是返回，子类可重写
 */
- (void)backBtnClicked;

@end
