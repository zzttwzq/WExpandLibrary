//
//  WDevice.h
//  AFNetworking
//
//  Created by 吴志强 on 2018/5/10.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import "WThreadTool.h"
#import <WBasicLibrary/WBasicHeader.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@interface WDevice : NSObject
@property (nonatomic,copy) StateBlock deviceDistenceChanged; //设备距离变化代理

#pragma mark - 获取系统信息
/**
 判断是否是iphonex

 @return 返回判断值
 */
+ (BOOL) is_Iphone_4;


/**
 判断是否是iphonex

 @return 返回判断值
 */
+ (BOOL) is_Iphone_5;


/**
 判断是否是iphonex

 @return 返回判断值
 */
+ (BOOL) is_Iphone_6;


/**
 判断是否是iphonex

 @return 返回判断值
 */
+ (BOOL) is_Iphone_6p;


/**
 判断是否是iphonex

 @return 返回判断值
 */
+ (BOOL) is_Iphone_x;


/**
 返回导航栏高度

 @return 返回高度
 */
+(NSInteger)getNavbarHeight;

#pragma mark - 获取系统信息
/**
 获取实例对象

 @return 返回实例对象
 */
+ (WDevice *)shareInstance;

/**
 判断热点是否开启

 @return 返回是否开启热点
 */
+ (BOOL)HotSpotIsOpened;


/**
 获取设备当前网络IP地址

 @param preferIPv4 是否是ipve4
 @return 返回IP地址
 */
+ (NSString *)getIPAddressForIPV4:(BOOL)preferIPv4;


/**
 获取所有相关IP信息

 @return 返回IP信息
 */
+ (NSDictionary *)getIPAddressInfo;


/**
 获取系统音量

 @return 返回系统音量
 */
+(float)getSystemVolume;


/**
 获取屏幕亮度

 @return 返回屏幕亮度
 */
+(float)getScreenBrightness;


/**
 屏幕方向改变

 @param change 改变的方向
 */
//+(void)viewOrientationChange:(viewOrientationChanged)change;

/**
 获取设备uuid

 @return 获取设备uuid
 */
+ (NSString *) getDeviceUUID;

#pragma mark - 设置系统状态
/**
 自动息屏

 @param shut 是否自动息屏， 默认是yes
 */
+ (void) auotShutScreen:(BOOL)shut;


/**
 设置状态条为白色

 @param isWhite yes 白色  no 黑色
 */
+ (void) setStatueBarColorWihte:(BOOL)isWhite;


/**
 设置系统屏幕亮度

 @param brightness 屏幕亮度
 */
+ (void) setScreenBrightness:(CGFloat)brightness;


/**
 显示状态条

 @param show 显示
 */
+ (void) showStatueBar:(BOOL)show;


/**
 是否打开设备红外线

 @param enable 打开
 */
+(void)openDeviceProximityMonitoring:(BOOL)enable;


/**
 设备是否靠近用户

 @param block 返回回调， yes 就是已经靠近用户 no 远离用户
 */
+(void)deviceToUserDistenceChanged:(StateBlock)block;


/**
 是否使用扬声器

 @param isSpeaker 使用扬声器
 */
+(void)playSoundWithSpeaker:(BOOL)isSpeaker;


/**
 打开闪光灯

 @param open 是否打开
 */
+(void)openCameraLight:(BOOL)open;


/**
 打开系统振动

 @param seconds 振动的事件
 */
+(void)openSystemVibrateFor:(NSTimeInterval)seconds;


/**
 打开一个简易的系统提示音
 */
+(void)openSimpleSystemAlertSound;
@end
