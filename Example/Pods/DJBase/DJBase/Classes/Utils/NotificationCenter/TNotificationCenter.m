//
//  TNotificationCenter.m
//  DJBase
//  通知中心
//  Created by CSS on 2019/5/20.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "TNotificationCenter.h"

@implementation TNotificationCenter

/**
 *  调用TSwitch通知 进行UITabBar选项卡切换 0-表示第一个选项卡
 *
 *  @param selectIndex      跳转的选项卡编号
 */
+ (void)toSelect:(NSString *)selectIndex postNotificationName:(NSString *)name {
    [self toSelect:selectIndex isRefresh:NO postNotificationName:name];
}

/**
 *  调用TSwitch通知 切换并刷新跳转页面数据
 *
 *  @param selectIndex      跳转的选项卡编号
 *  @param isRefresh        是否刷新
 */
+(void)toSelect:(NSString *)selectIndex isRefresh:(BOOL)isRefresh postNotificationName:(NSString *)name {
    [self toSelect:selectIndex toViewController:nil isRefresh:isRefresh postNotificationName:name];
    
}

/**
 *  调用TSwitch通知 切换并刷新跳转页面数据
 *
 *  @param selectIndex      跳转的选项卡编号
 *  @param vc               跳转后需要跳转页面  请注意 有局限只能是
 *  @param isRefresh        是否刷新
 */
+(void)toSelect:(NSString *)selectIndex toViewController:(UIViewController *)vc isRefresh:(BOOL)isRefresh postNotificationName:(NSString *)name {
    [self toSelect:selectIndex toViewController1:vc toViewController2:nil isRefresh:isRefresh postNotificationName:name];
}

/**
 *  调用TSwitch通知 切换并刷新跳转页面数据
 *
 *  @param selectIndex      跳转的选项卡编号
 *  @param vc1              跳转后需要跳转页面
 *  @param vc2              跳转后需要跳转页面
 *  @param isRefresh        是否刷新
 */
+(void)toSelect:(NSString *)selectIndex toViewController1:(UIViewController *)vc1 toViewController2:(UIViewController *)vc2 isRefresh:(BOOL)isRefresh postNotificationName:(NSString *)name {
    NSDictionary *dict = [NSDictionary new];
    [dict setValue:selectIndex forKey:@"select"];
    if (vc1 != nil) {
        [dict setValue:vc1 forKey:@"vc1"];
    }
    if (vc2 != nil) {
        [dict setValue:vc2 forKey:@"vc2"];
    }
    [dict setValue:isRefresh?@"1":@"0" forKey:@"refresh"];
    [[NSNotificationCenter defaultCenter]postNotificationName:name object:dict];
}

/**
 调用TSwitch通知 切换并刷新跳转页面数据
 
 @param selectIndex     跳转的选项卡编号
 @param isJump          是否跳转到选项卡编号
 @param isRootVC        是否回到顶节点
 @param isRootRefresh   是否顶节点刷新
 @param childrenVC      多层vc
 */
+ (void)toSelect:(NSInteger)selectIndex isJump:(BOOL)isJump isRootVC:(BOOL)isRootVC isRootRefresh:(BOOL)isRootRefresh childrenVC:(NSArray *)childrenVC postNotificationName:(NSString *)name {
    NSDictionary *dict = [NSDictionary new];
    [dict setValue:[NSNumber numberWithInteger:selectIndex] forKey:@"select"];
    [dict setValue:[NSNumber numberWithBool:isJump] forKey:@"isJump"];
    [dict setValue:[NSNumber numberWithBool:isRootVC] forKey:@"isRootVC"];
    [dict setValue:[NSNumber numberWithBool:isRootRefresh] forKey:@"isRootRefresh"];
    [dict setValue:childrenVC forKey:@"childrenVC"];
    [[NSNotificationCenter defaultCenter]postNotificationName:name object:dict];
}

@end
