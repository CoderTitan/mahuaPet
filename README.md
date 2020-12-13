# mahuaPet




- 这段时间内一直学习`Flutter`, 自行设计完成了一个实战项目`mahua_pet`
- 项目中用到了`flutter`中的大部分的组件, 界面也涉及了很多功能(可能很多地方还有待完善)
- 项目目前也还是处在开发待完成阶段, 主要内容差不多已经完成
- 下面是一些UI界面展示, 后面推见一些比较好的开源项目
- 验证码登录和密码登录都可以登录, 账号: 123 密码: 123
- 个人博客地址: https://www.titanjun.top/

## 部分界面展示

### 首页
    
    
动态的展示导航栏的显示和隐藏



![image](https://titanjun.oss-cn-hangzhou.aliyuncs.com/mahua/home_0.png?x-oss-process=style/titanjun)
    




### 日历模块


展示日历的记录, 每日记录生成图片和保存图片


![image](https://titanjun.oss-cn-hangzhou.aliyuncs.com/mahua/calendar_0.png?x-oss-process=style/titanjun)






### 发现


类似朋友圈的内容展示, 图片浏览和保存图片


![image](https://titanjun.oss-cn-hangzhou.aliyuncs.com/mahua/find_0.png?x-oss-process=style/titanjun)




动态详情模块, 动态的评论和删除评论

![image](https://titanjun.oss-cn-hangzhou.aliyuncs.com/mahua/detail_0.png?x-oss-process=style/titanjun)







### 多语言国际化

部分页面适配了韩语和英语


![image](https://titanjun.oss-cn-hangzhou.aliyuncs.com/mahua/language_0.png?x-oss-process=style/titanjun)




### 颜色主题和暗黑模式

部分页面支持手动的修改项目主题色, 黑色主题(暗黑模式)适配

![image](https://titanjun.oss-cn-hangzhou.aliyuncs.com/mahua/theme_0.png?x-oss-process=style/titanjun)





## 用到的插件


### dio

> https://pub.dartlang.org/packages/dio

Dart社区提供的http请求库，不仅支持常见的网络请求，还支持Restful API、FormData、拦截器、请求取消、Cookie管理、文件上传/下载、超时等操作



### provider

> https://pub.dev/packages/provider

`Flutter`官方推荐的状态管理插件, [简单的应用状态管理](https://flutter.cn/docs/development/data-and-backend/state-mgmt/simple)


### flutter_redux

> https://pub.dev/packages/flutter_redux

`flutter`版的`redux`


### pull_to_refresh

> https://pub.dev/packages/pull_to_refresh

一个提供上拉加载和下拉刷新的组件,同时支持`Android`和`ios`



### flutter_staggered_grid_view

> https://pub.dev/packages/flutter_staggered_grid_view

一个支持瀑布流布局, 支持交错和可扩展的网格布局的组件



### flutter_easyloading

> https://pub.dev/packages/flutter_easyloading

支持多种样式的toast提示组件, 支持自定义


### carousel_slider

> https://pub.dev/packages/carousel_slider

轮播图组件, 支持缩放切换


### table_calendar

> https://pub.dev/packages/table_calendar

日历组件, 可定制性比较高, 支持语言国际化


### photo_view


> https://pub.dev/packages/photo_view


可定制的图片查看器, 支持手势缩放, 动画展示等


### shimmer

> https://pub.dev/packages/shimmer

提供闪光效果的组件, 表述不清晰, 看提供效果图

![image](https://github.com/hnvn/flutter_shimmer/blob/master/screenshots/loading_list.gif?raw=true)
![image](https://github.com/hnvn/flutter_shimmer/blob/master/screenshots/slide_to_unlock.gif?raw=true)



### cached_network_image

> https://pub.dev/packages/cached_network_image

用来加载和缓存网络图像


### image_picker

> https://pub.dev/packages/image_picker

用于从Android和iOS图像库中选择图像的库，支持使用相机拍摄新照片。
  
  

### image_gallery_saver

> https://pub.dev/packages/image_gallery_saver

保存视频和图片到手机相册



### video_player

> https://pub.dev/packages/video_player

flutter官方推荐的视频播放组件


### permission_handler

> https://pub.dev/packages/permission_handler


用于Android和iOS的相关隐私权限判断


### shared_preferences


> https://pub.dev/packages/shared_preferences


用于基本数据的缓存处理



### device_info

> https://pub.dev/packages/device_info

用于获取用户设备信息


### location

> https://pub.dev/packages/location


获取定位信息, 可以获取位置更改时的回调
  
  
 

## 值得推荐的插件


### 适配相关

#### native_widgets

> https://pub.dev/packages/native_widgets

支持自动根据平台自动使用对应风格组件，Android将使用Material风格，iOS将使用Cupertino风格


### 日期时间

#### flutter_picker


> https://pub.dev/packages/flutter_picker


一个日期，时间，日期时间，icon，自定义数据的选择器，可以居中弹窗，也可以在底部弹出


### MarkDown

#### markdown

> https://pub.dev/packages/markdown

用Dart编写的便携式Markdown库。它可以在客户端和服务器上将Markdown解析为HTML


### 颜色选择

#### flutter_colorpicker

> https://pub.dev/packages/flutter_colorpicker

一个HSV(HSB)/HSL颜色选择器



### 加密算法

#### crypto

> https://pub.dev/packages/crypto

crypto算法库支持的算法: 
- SHA-1
- SHA-224
- SHA-256
- SHA-384
- SHA-512
- MD5
- HMAC (i.e. HMAC-MD5, HMAC-SHA1, HMAC-SHA256)


#### pointycastle

> https://pub.dev/packages/pointycastle


用于加密和解密的Dart库, 实现了AES RSA 公私钥加解密等加密算法


### 解压缩

#### archive

> https://pub.dev/packages/archive

为各种存档和压缩格式提供编码器和解码器，如zip，tar，bzip2，gzip和zlib


### 数据库

#### sqflite

> https://pub.dev/packages/sqflite

SQLite的Flutter插件，一个自包含的高可靠性嵌入式SQL数据库引擎



### 分享统计支付

#### share

> https://pub.dev/packages/share

支持分享的flutter插件


#### flutter_umeng_analytics

> https://pub.dev/packages/flutter_umeng_analytics

友盟的分享和统计库


#### flutter_qq

> https://pub.dev/packages/flutter_qq

集成了QQ登录、QQ分享、QQ空间分享等功能的库


#### flutter_wechat

> https://pub.dev/packages/flutter_wechat

集成了微信，支持微信登录、分享、支付等功能的库


#### flutter_alipay

> https://pub.dev/packages/flutter_alipay

支付宝支付的功能


## 学习资料和项目

推荐一些不错的学习网站和项目学习

### awesome-flutter-cn

> https://github.com/crazycodeboy/awesome-flutter-cn

一个Flutter的学习资料库, 里面提供了很多的学习资料

### flutter-go

> https://github.com/alibaba/flutter-go

由阿里巴巴前端技术团队开发的Flutter 开发者帮助 APP，包含 flutter 常用 140+ 组件的demo 演示与中文文档


### Widget整理

> http://laomengit.com/flutter/widgets/widgets_structure.html

整理的330+组件的详细用法，不仅包含UI组件，还包含了功能性的组件


### Morec

> https://github.com/Mayandev/morec

一个非常精美的 Flutter 版电影客户端，利用豆瓣现有的 Api，打造了一个完整的电影展示 App


### flutter_hrlweibo


> https://github.com/huangruiLearn/flutter_hrlweibo


仿微博最新版本,还原微博80%的界面,总共涉及到了几十个界面和接口,用到了flutter中的大部分组件


### flutter-netease-music

> https://github.com/boyan01/flutter-netease-music

仿网易云音乐，完成大部分功能的APP


### flutter_shuqi

> https://github.com/huanxsd/flutter_shuqi

一个用Flutter写的书旗小说客户端, 所有功能都是用Dart写的，iOS和Android的代码复用率达到了100%


### gsy_github_app_flutter

> https://github.com/CarGuo/GSYGithubAPP

一款跨平台的开源Github客户端App，项目涉及各种常用控件、网络、数据库、设计模式、主题切换、多语言、Redux等


---

