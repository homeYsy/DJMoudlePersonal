//
//  djUtilsMacros.h
//  DJBase
//  全局工具类宏定义
//  Created by CSS on 2019/5/16.
//  Copyright © 2019年 djkj. All rights reserved.
//

#ifndef djUtilsMacros_h
#define djUtilsMacros_h

#pragma mark - View宏定义
//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//property 属性快速声明 别用宏定义了，使用代码块+快捷键实现吧

// 当前系统版本
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]
//当前语言
#define CurrentLanguage (［NSLocale preferredLanguages] objectAtIndex:0])

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

//颜色
#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KGray2Color [UIColor lightGrayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor redColor]
#define kRandomColor    KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)        //随机色生成
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define HexColor(A) [UIColor colorWithHexString:A]

//字体
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]
#define AdjustFont(A) [UIFont adjustFontSize:A]


//定义UIImage对象
#define ImageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]
#define IMAGE_NAMED(name) [UIImage imageNamed:name]

//数据验证
#define StrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f) ? f:@"")
#define HasString(str,key) ([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f) StrValid(f)
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)
//打印当前方法名
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)



#pragma mark - 工具类宏定义
//打开URL
#define OPEN_URL(url)                                           [APPLICATION openURL:(url)]
#define OPEN_STRING_URL(url)                                    [APPLICATION openURL:[NSURL URLWithString:([url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]])]]
#define CALL_NUMBER(number)                                     [APPLICATION openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:[number stringByReplacingOccurrencesOfString:@" " withString:@""]]]]

// 文件路径
#define PATH_DOCUMENTS                                          [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_LIBRARY                                            [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_PRIVATE_STORAGE                                    [[PATH_LIBRARY stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:@"PrivateStorage"]
#define PATH_FOR_RESOURCE(file, ext)                            (file ? [MAIN_BUNDLE pathForResource:(file) ofType:ext] : nil)
#define PATH_FOR_RESOURCE_IN_DIRECTORY(file, ext, directory)    (file ? [MAIN_BUNDLE pathForResource:(file) ofType:ext inDirectory:directory] : nil)
#define TEMPORARY_FILE_PATH                                     [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%f", [NSDate timeIntervalSinceReferenceDate]]]
#define REMOVE_ITEM_AT_PATH(path)                               [FILE_MANAGER removeItemAtPath:path error:nil]
#define FILE_EXISTS_AT_PATH(path)                               [FILE_MANAGER fileExistsAtPath:path]


// 加载Xib
#define LOAD_NIB_NAMED(nibName)                                 do{[MAIN_BUNDLE loadNibNamed:nibName owner:self options:nil];}while(0)

// 移除通知
#define NOTIFICATION_CENTER_REMOVE                              [NOTIFICATION_CENTER removeObserver:self]

//  nil to [NSNull null]
#define nilToNSNull(value)                                      (value ? value : [NSNull null])
#define NSNullToNil(value)                                      ((id)value == [NSNull null] ? nil : value)

// 类型判断
#define isKindOf(x, cls)                [(x) isKindOfClass:[cls class]]         // 判断实例类型(含父类)
#define isMemberOf(x, cls)              [(x) isMemberOfClass:[cls class]]       // 判断实例类型(不含父类)

#pragma mark - 快捷宏定义
// 单例对象
#define NOTIFICATION_CENTER                         [NSNotificationCenter defaultCenter]
#define FILE_MANAGER                                [NSFileManager defaultManager]
#define MAIN_BUNDLE                                 [NSBundle mainBundle]
#define MAIN_THREAD                                 [NSThread mainThread]
#define MAIN_SCREEN                                 [UIScreen mainScreen]
#define USER_DEFAULTS                               [NSUserDefaults standardUserDefaults]
#define APPLICATION                                 [UIApplication sharedApplication]
#define CURRENT_DEVICE                              [UIDevice currentDevice]
#define MAIN_RUN_LOOP                               [NSRunLoop mainRunLoop]
#define GENERAL_PASTEBOARD                          [UIPasteboard generalPasteboard]
#define KEY_WINDOW                                  [[UIApplication sharedApplication] keyWindow]

// 网络
#define NETWORK_ACTIVITY                            [APPLICATION networkActivityIndicatorVisible]

// 归档
#define OBJECT2DATA(object)   [NSKeyedArchiver archivedDataWithRootObject:object]
#define DATA2OBJECT(data)     [NSKeyedUnarchiver unarchiveObjectWithData:data]

// Application信息
#define APPLICATION_NAME                            [MAIN_BUNDLE objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define APPLICATION_VERSION                         [MAIN_BUNDLE objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define APPLICATION_BUILD_VERSION                   [MAIN_BUNDLE objectForInfoDictionaryKey:@"CFBundleVersion"]
#define APPLICATION_BUNDLE_ID                       [MAIN_BUNDLE objectForInfoDictionaryKey:@"CFBundleIdentifier"]

// USER_DEFAULTS
#define USER_DEFAULTS                               [NSUserDefaults standardUserDefaults]
#define USER_DEFAULTS_SET_OBJECT_FOR_KEY(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}
#define USER_DEFAULTS_OBJECT_FOR_KEY(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]
#define USER_DEFAULTS_REMOVE_OBJECT_FOR_KEY(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#pragma mark - 日志宏定义
//-------------------打印日志-------------------------
//DEBUG模式下打印日志
#ifdef DEBUG
#define DLog(...)      printf("\n***********************start****************************\n[%s] %s [第%d行]\n%s\n*********************end********************************\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define DLog(...)
#endif

#pragma mark - 设备宏定义
// 屏幕信息
#define IS_RETINA_SCREE                          (MAIN_SCREEN.scale > 1.0)
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)

// 设备类型
#define IS_IPHONE         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPAD           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 手机型号
#define IS_SIMULATOR (TARGET_IPHONE_SIMULATOR == 1 ? 1 : 0)
#define IS_IPHONEXR (SCREEN_WIDTH == 414.f && SCREEN_HEIGHT == 896.f ? YES : NO)
#define IS_IPHONEX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_6 ([[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6_PLUS ([[UIScreen mainScreen] bounds].size.height == 736.0f)
#define IS_IPHONE_6_PLUS_UP ([[UIScreen mainScreen] bounds].size.height > 736.0f)

// 设备信息
#define DEVICE_MODEL                                [CURRENT_DEVICE model]
#define DEVICE_LOCALIZED_MODEL                      [CURRENT_DEVICE localizedModel]
#define DEVICE_PLATFORM                             [CURRENT_DEVICE platform]
#define DEVICE_SYSTEM_NAME                          [CURRENT_DEVICE systemName]
#define DEVICE_SYSTEM_VERSION                       [CURRENT_DEVICE systemVersion]

// 系统版本
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)              ([[CURRENT_DEVICE systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_IS_IOS4_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"4.0")
#define SYSTEM_VERSION_IS_IOS5_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")
#define SYSTEM_VERSION_IS_IOS6_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")
#define SYSTEM_VERSION_IS_IOS7_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define SYSTEM_VERSION_IS_IOS8_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define SYSTEM_VERSION_IS_IOS9_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")
#define SYSTEM_VERSION_IS_IOS10_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")
#define SYSTEM_VERSION_IS_IOS11_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")

// 设备尺寸信息
#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define NAVIGATION_BAR_HEIGHT 44
#define STATUS_BAR_ANDNAVIGATION_BAR_HEIGHT (IS_IPHONE_X ? 88.f : 64.f)
#define TABBAR_HEIGHT                (IS_IPHONE_X ? (49.f+34.f) : 49.f)
#define SAFE_BOTTOM_MARGIN_V         (IS_IPHONE_X ? 34.f : 0.f)
#define SAFE_BOTTOM_MARGIN_H         (IS_IPHONE_X ? 21.f : 0.f)
#define SAFE_LEFTORRIGHT_MARGIN_H         (IS_IPHONE_X ? 44.f : 0.f)
#define SAFE_INSETS(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

// 尺寸
#define StatusBarHeight ((IS_IPHONEX || IS_IPHONEXR) ? 44.f : 20.f)
#define SafeAreaBottomHeight (IS_IPHONEX || IS_IPHONEXR ? 34 : 0)
#define TabbarHeight    (49.f + SafeAreaBottomHeight)
#define NavigationBarHeight (44.f + StatusBarHeight)

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

#pragma mark - 强弱引用宏定义
// 强弱引用
#define WeakSelf          __weak __typeof(self) weakSelf = self;
#define StrongSelf        __strong __typeof(weakSelf)strongSelf = weakSelf;

#pragma mark - 颜色宏定义
#define UIColorFromHexWithAlpha(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]
#define UIColorFromHex(hexValue)            UIColorFromHexWithAlpha(hexValue,1.0)
#define UIColorFromRGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(r,g,b)               UIColorFromRGBA(r,g,b,1.0)

#pragma mark - 通知宏定义
// Add
#define ADD_OBSERVER_WITH_OBJECT(_selector, _name, _object) \
([[NSNotificationCenter defaultCenter] addObserver:self selector:_selector name:_name object:_object])
#define ADD_OBSERVER(_selector,_name) \
ADD_OBSERVER_WITH_OBJECT(_selector, _name, nil)

// Post
#define POST_NOTIFICATION_WITH_OBJECT_AND_INFO(_name, _object, _info) \
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_object userInfo:(_info)])
#define POST_NOTIFICATION(_name) \
POST_NOTIFICATION_WITH_OBJECT_AND_INFO(_name, nil, nil)
#define POST_NOTIFICATION_WITH_OBJECT(_name, _object) \
POST_NOTIFICATION_WITH_OBJECT_AND_INFO(_name, _object, nil)
#define POST_NOTIFICATION_WITH_INFO(_name, _info) \
POST_NOTIFICATION_WITH_OBJECT_AND_INFO(_name, nil, _info)

// Remove
#define REMOVE_OBSERVER(_name) \
([[NSNotificationCenter defaultCenter] removeObserver:self name:_name object:nil])
#define REMOVE_ALL_OBSERVERS(_self) \
([[NSNotificationCenter defaultCenter] removeObserver:_self])

#endif /* djUtilsMacros_h */
