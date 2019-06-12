//
//  BaseView.m
//  DJBase
//  UIView 父类
//  Created by CSS on 2019/5/13.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "BaseView.h"

#pragma mark - 声明
@interface BaseView()

@end

#pragma mark - 实现
@implementation BaseView

#pragma mark - 加载
// 加载第一个nib
+ (instancetype)loadFirstNib:(CGRect)frame {
    BaseView *view = [self loadNib:0 frame:frame];
    [view initUI];
    return view;
}
// 加载最后一个nib
+ (instancetype)loadLastNib:(CGRect)frame {
    NSInteger index = [self getViews].count - 1;
    BaseView *view = [self loadNib:index frame:frame];
    [view initUI];
    return view;
}
// 从代码创建view
+ (instancetype)loadCode:(CGRect)frame {
    BaseView *view = [[[self class] alloc] initWithFrame:frame];
    [view initUI];
    return view;
}
// 加载指定nib
+ (instancetype)loadNib:(NSInteger)index frame:(CGRect)frame {
    NSString *name = NSStringFromClass(self);
    BaseView *view = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil][index];
    view.frame = frame;
    return view;
}

// 获取XIB中View个数
+ (NSArray *)getViews {
    NSString *name = NSStringFromClass(self);
    return [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil];
}

// 初始化UI
- (void)initUI {
    
}

@end
