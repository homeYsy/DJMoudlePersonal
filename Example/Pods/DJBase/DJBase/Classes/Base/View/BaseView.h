//
//  BaseView.h
//  DJBase
//  UIView 父类
//  Created by CSS on 2019/5/13.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+APPViewRequest.h"

@interface BaseView : UIView

//==================================== 加载 ====================================//
/// 加载第一个nib
+ (instancetype)loadFirstNib:(CGRect)frame;

/// 加载最后一个nib
+ (instancetype)loadLastNib:(CGRect)frame;

/// 从代码创建view
+ (instancetype)loadCode:(CGRect)frame;

/// 加载指定nib
+ (instancetype)loadNib:(NSInteger)index frame:(CGRect)frame;

/// 初始化UI
- (void)initUI;

@end
