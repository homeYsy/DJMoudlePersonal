//
//  NSObject+Helpers.h
//  DJBase
//
//  Created by CSS on 2019/5/31.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Helpers)

/**
 延时触发
 @param sel 触发方法名
 @param delay 延时时间
 */
- (void)performSelector:(SEL)sel afterDelay:(NSTimeInterval)delay;


/**
 在一个类中交换两个实例方法的实现
 @param originalSel 原方法
 @param newSel 新方法
 @return 是否成功
 */
+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;


/**
 在一个类中交换两个类方法的实现
 @param originalSel 原方法
 @param newSel 新方法
 @return 是否成功
 */
+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;



/**
 将一个对象(strong, nonatomic)与”self“关联
 @param value 对象名称
 @param key 对应key
 */
- (void)setAssociateValue:(id)value withKey:(void *)key;

/**
 将一个对象(week, nonatomic)与”self“关联
 @param value 对象名称
 @param key 对应key
 */
- (void)setAssociateWeakValue:(id)value withKey:(void *)key;


/**
 删除self中所有关联的对象
 */
- (void)removeAssociatedValues;


/**
 根据key获取self中关联的对象
 @param key 对应的key
 @return key关联的值
 */
- (id)getAssociatedValueForKey:(void *)key;


/**
 获取类名字符串
 */
+ (NSString *)className;

/**
 获取类名字符串
 */
- (NSString *)className;

/// 获取随机数
+ (int)getRandomNumber:(int)from to:(int)to;

/// 判断一个对象是否为空
+ (BOOL)isEmpty:(_Nullable id)obj;

@end
