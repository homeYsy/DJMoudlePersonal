//
//  UpdatePopView.h
//  BI
//
//  Created by zhangsp on 2017/12/7.
//  Copyright © 2017年 DJKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateClickBlock)(void);
typedef void (^CancelClickBlock)(void);
@protocol UpdatePopupDelegate <NSObject>
- (void)didUpdateButton;
@end
@interface UpdatePopView : UIView

@property (nonatomic, weak) id<UpdatePopupDelegate> delegate;

//初始化
- (id)initWithStyle:(NSString *)message cancelText:(NSString *)cancelText delegate:(id<UpdatePopupDelegate>)delegate;

/**
 初始化

 @param message 更新内容
 @param cancelText 是否强制更新 1:强制更新 0:不强制
 @param updateClickBlock 更新block
 @return self
 */
- (id)initWithStyle:(NSString *)message cancelText:(NSString *)cancelText updateBlock:(UpdateClickBlock)updateClickBlock;


/**
 初始化
 
 @param message 更新内容
 @param cancelText 是否强制更新 1:强制更新 0:不强制
 @param updateClickBlock 更新block
 @param cancelClickBlock 关闭弹框block
 @return self
 */
- (id)initWithStyle:(NSString *)message cancelText:(NSString *)cancelText updateBlock:(UpdateClickBlock)updateClickBlock cancelBlock:(CancelClickBlock)cancelClickBlock;
/**
 初始化
 
 @param titleText 更新标题
 @param message 更新内容
 @param cancelText 是否强制更新 1:强制更新 0:不强制
 @param updateClickBlock 更新block
 @param cancelClickBlock 关闭弹框block
 @return self
 */
- (id)initWithStyleTitle:(NSString*)titleText message:(NSString *)message cancelText:(NSString *)cancelText updateBlock:(UpdateClickBlock)updateClickBlock cancelBlock:(CancelClickBlock)cancelClickBlock;
//显示视图
- (void)show;
// 点击更新
@property (nonatomic, copy) UpdateClickBlock updateClickBlock;
// 点击关闭
@property (nonatomic, copy) CancelClickBlock cancelClickBlock;
@end
