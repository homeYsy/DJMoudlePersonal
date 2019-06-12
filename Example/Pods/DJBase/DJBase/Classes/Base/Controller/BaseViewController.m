//
//  BaseViewController.m
//  DJBase
//  UIViewController 父类
//  Created by CSS on 2019/5/15.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "BaseViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "djUtilsMacros.h"

#pragma mark - 声明
@interface BaseViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

#pragma mark - 实现
@implementation BaseViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //是否显示返回按钮  　　
    self.isShowLeftBack = YES;
    //是否显示空数据页面  默认为显示
    self.isShowEmptyData = YES;
    
    //tableView collectionView 加上刷新加载事件
    if(self.tableView) {
        [self addMjRefresh:self.tableView];
        [self addEmpty:self.tableView];
    }
    if(self.collectionView) {
        [self addMjRefresh:self.collectionView];
        [self addEmpty:self.collectionView];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog(@"当前控制器显示: %@",NSStringFromClass([self class]));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //循环遍历Nav,避免多个按钮同时点击
    for(UIView *temp in self.navigationController.navigationBar.subviews) {
        [temp setExclusiveTouch:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    DLog(@"当前控制器消失: %@",NSStringFromClass([self class]));
    
    //取消当前控制器的网络请求
    [[[AFNManager networkManager] operationQueue] cancelAllOperations];
}

#pragma mark - add
/** TableView collectionView 加上刷新加载 */
- (void)addMjRefresh:(UIScrollView *)scv {
    scv.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)];
    scv.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)];
}

/** TableView collectionView 加上空白页代理 */
- (void)addEmpty:(UIScrollView *)scv {
    scv.emptyDataSetSource = self;
    scv.emptyDataSetDelegate = self;
}

#pragma mark - 下拉刷新、上拉加载
/** 下拉刷新、上拉加载 */
- (void)refreshTableView {
    /// 当显示空白页时,将其隐藏掉;重新刷新将其显示.
    if (self.tableView.mj_footer.hidden) {
        self.tableView.mj_footer.hidden = NO;
    }
    self.tableView.tableFooterView = nil;
    
    DLog(@"请在子类重写方法:- (void)refreshTableView");
}

/** 停止刷新 */
- (void)tableViewStopRefreshing {
    if([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }else if([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
    
    if([self.collectionView.mj_header isRefreshing]){
        [self.collectionView.mj_header endRefreshing];
    }else if([self.collectionView.mj_footer isRefreshing]){
        [self.collectionView.mj_footer endRefreshing];
    }
}

/** 开始刷新 */
- (void)refreshTableViewIsRefreshing {
    if(self.tableView){
        [self.tableView.mj_header beginRefreshing];
    }
    if(self.collectionView){
        [self.collectionView.mj_header beginRefreshing];
    }
}


#pragma mark - 空白页
/** 设置图片 */
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.noDataImgName) {
        return [UIImage imageNamed:self.noDataImgName];
    }
    return [UIImage imageNamed:@"blank_icon_message"];
}

/** 设置标题 */
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = self.noDataTitle?self.noDataTitle:@"亲，您暂时没有任何消息!";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor grayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

/** 设置副标题 */
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = self.noDataDetailTitle;
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return self.noDataDetailTitle?[[NSAttributedString alloc] initWithString:text attributes:attributes]:nil;
}

/** 设置按钮标题 */
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor]
                                 };
    
    return self.btnTitle?[[NSAttributedString alloc] initWithString:self.btnTitle attributes:attributes]:nil;
}

/** 设置按钮图片 */
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return self.btnImgName?[UIImage imageNamed:self.btnImgName]:nil;
}

/** 按钮事件 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self buttonEvent];
}

/** 按钮事件 */
-(void)buttonEvent {
    DLog(@"请在子类重写方法:- (void)buttonEvent");
}

/** 是否响应交互 */
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

/** 是否显示 */
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.isShowEmptyData;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.tableView) {
        return -self.tableView.tableHeaderView.frame.size.height/2.0f;
    }
    if (self.collectionView) {
        return -self.collectionView.frame.size.height/2.0f;
    }
    return -self.tableView.tableHeaderView.frame.size.height/2.0f;
}


#pragma mark - 导航栏
/** 是否显示返回按钮,默认情况是YES */
- (void)setIsShowLeftBack:(BOOL)isShowLeftBack {
    _isShowLeftBack = isShowLeftBack;
    NSInteger VCCount = self.navigationController.viewControllers.count;
    //下面判断的意义是 当VC所在的导航控制器中的VC个数大于1 或者 是present出来的VC时，才展示返回按钮，其他情况不展示
    if (isShowLeftBack && (VCCount > 1 || self.navigationController.presentingViewController != nil)) {
        [self addNavigationItemWithImageNames:@[@"common_icon_back"] isLeft:YES target:self action:@selector(backBtnClicked) tags:nil];
    } else {
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem * NULLBar = [[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = NULLBar;
    }
}

/**
 *  默认返回按钮的点击事件，默认是返回，子类可重写
 */
- (void)backBtnClicked {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 导航栏添加文本按钮
 
 @param titles  文本数组
 @param isLeft  是否是左边 非左即右
 @param target  目标
 @param action  点击方法
 @param tags    tags数组 回调区分用
 */
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags {
    NSMutableArray * items = [[NSMutableArray alloc] init];
    
    NSMutableArray * buttonArray = [NSMutableArray array];
    NSInteger i = 0;
    for (NSString * title in titles) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = SYSTEMFONT(16);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.tag = [tags[i++] integerValue];
        [btn sizeToFit];
        
        //设置偏移
        if (isLeft) {
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }else{
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        }
        
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
        [buttonArray addObject:btn];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

/**
 导航栏添加图标按钮
 
 @param imageNames  图标数组
 @param isLeft      是否是左边 非左即右
 @param target      目标
 @param action      点击方法
 @param tags        tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags {
    NSMutableArray * items = [[NSMutableArray alloc] init];
    NSInteger i = 0;
    for (NSString * imageName in imageNames) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        if (isLeft) {
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }else{
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        }
        
        btn.tag = [tags[i++] integerValue];
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
        
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
