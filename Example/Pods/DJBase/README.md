## iOS 基础框架
#### 功能介绍

1. 基础类:导航栏、控制器、选项卡
2. 网络类
3. 常用工具类:Categorys、数据库、日志
4. 常用控件
5. 全局宏:工具宏、URL宏、颜色、字体宏、第三方框架相关宏定义
6. 常用CocoaPods引入

#### 安装方式
**CocoaPods安装**

> 要使用CocoaPods将DJFramework集成到您的Xcode项目中，请在以下位置指定Podfile：

source 'https://github.com/CocoaPods/Specs.git'       #官方仓库地址

source 'http://192.168.0.169/App/SpecsRepo_iOS.git'        #私有仓库地址

platform :ios, '8.0'

target 'TargetName' do

pod ‘DJFramework’

end
