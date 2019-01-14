//
//  QuickCode.h
//  Pods
//
//  Created by 吴志强 on 2018/10/23.
//

#ifndef QuickCode_h
#define QuickCode_h

/**
 app启动环境配置，包括数据库配置，路由配置，网络配置，进入页面判定，引导图配置

 @param storageConfigClassName 数据库配置
 @param routerConfigClassName 路由配置
 @param networkConfigClassName 网络配置
 @param userClassName 用户类名
 @param tabbarClassName tabbar类名
 @param loginClassName 登录类名
 @param iphonexLanuchScreen iphonex启动页图片数组
 @param iphoneScreen iphone启动页图片数组
 @return 无
 */
#define appLanuchConfig(ShareConfigClassName,HUDConfigClassName,storageConfigClassName,routerConfigClassName,networkConfigClassName,userClassName,tabbarClassName,loginClassName) \
\
if (@available(ios 11.0, *)) {[UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} \
\
self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];\
\
\
[NSClassFromString(ShareConfigClassName) configShare]; \
\
[NSClassFromString(HUDConfigClassName) configHUD]; \
\
[NSClassFromString(storageConfigClassName) configLocalStorage]; \
\
[NSClassFromString(routerConfigClassName) configGlobalRouters]; \
\
[NSClassFromString(networkConfigClassName) configNetworking]; \
\
\
\
if ([NSClassFromString(userClassName) isUserLogined]) {self.window.rootViewController = [NSClassFromString(tabbarClassName) new];}\
\
else{self.window.rootViewController = [NSClassFromString(loginClassName) new];} \
\
[self.window makeKeyAndVisible];\


#endif /* QuickCode_h */
