//
//  NSString+Helpers.h
//  DJBase
//
//  Created by CSS on 2019/5/31.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Helpers)

/**
 判断是否为空串
 */
+ (BOOL)isEmpty:(NSString*)text;

///判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string;

/// 判断是否为浮点型
+ (BOOL)isPureFloat:(NSString *)string;

/**
 *  判断string是否为整数
 *  @param value 浮点型值
 *  @return 是整数则返回yes，否则返回no
 */
+ (BOOL)isPureIntFromFloat:(CGFloat)value;

/**
 *正则表达式,判断中文
 *@return 是否手机号码格式
 **/
- (BOOL)isChinese;

/**
 *   正则表达式,判断信用卡逾期时间
 *
 *   @return  是否逾期时间格式
 */
- (BOOL)isLateTime;

/**
 *  正则表达式，判断座机
 *
 *  @return 是否座机格式
 */
- (BOOL)isLandLineNumber;

/**
 *   判断修改密码的正则
 */
- (BOOL)isChangePassWord;

/**
 *  将float型数据以string返回
 *  @param value 浮点型值
 *  @return 返回格式化后的float数据
 */
+ (NSString *)formatStrWithFloat:(CGFloat)value;

/// 无空格字符串
- (NSString*)noneSpaseString;

/// 校验手机号
+ (BOOL)validateMobile:(NSString *)mobile;

/// 校验email
+ (BOOL)validateEmail:(NSString *)email;

/// 身份证号
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

/// 昵称 3-10个汉字、字母或者相互组合
+ (BOOL)validNickName:(NSString *)nickName;

/// 校验密码
+ (BOOL)validPassward:(NSString *)passward;

/// 真实姓名 2-6个汉字
+ (BOOL)validRealName:(NSString *)realName;

/// 金额判断
+ (BOOL)validateMoney:(NSString *)money;

/// 判断是否包含特殊字符
+ (BOOL)isIncludeSpecialCharact:(NSString *)str;

/**
 *  转换时间：上午 － 09:00:00，下午 － 14:00:00
 *
 *  @return 转换后的字符串数字
 */
- (NSString *)convertTimeToNumber;

/**
 *  转换时间
 *
 *  @return 转换后的时间：上午、下午
 */
- (NSString *)convertNumberToTime;

/// string转array
- (NSArray *)stringToNSArray;

/// 将数字转为每隔3位整数由逗号“,”分隔的字符串
- (NSString *)separateNumberUseComma;

/// 用*代替range范围的文本 常用于手机号显示
- (NSString *)replaceWithScureInRange:(NSRange)range;

/// MD5加密-16位
- (NSString *)md5;

/// MD5加密-32位
- (NSString *)md5_32;

/// app版本号
+ (NSString *)appVersion;

/// app名称
+ (NSString *)appName;

/// app bundle id
+ (NSString *)appBundleID;

/// 比较版本号
- (BOOL)hasNewVersion;

/**
 *  @param font 字体
 *
 *  @return 返回高度
 */
- (CGSize)sizeForNoticeFont:(UIFont*)font;

/// 计算尺寸
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size lineSpace:(CGFloat)lineSpace mode:(NSLineBreakMode)lineBreakMode;

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size;

- (CGFloat)widthForFont:(UIFont *)font;

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpace;

+ (NSString *)stringWithUUID;

/// 字典转JsonString
+ (NSString *)convertToJsonString:(NSDictionary *)dict;

+ (NSString *)deviceModel;

@end
