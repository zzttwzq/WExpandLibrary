//
//  WCheckAuthor.h
//  wzqproject
//
//  Created by 吴志强 on 2017/11/6.
//  Copyright © 2017年 吴志强. All rights reserved.
//

#import <WBasicLibrary/WBasicHeader.h>

#import <CoreLocation/CoreLocation.h>
#import <Photos/Photos.h>
#import <CoreTelephony/CTCellularData.h>
#import <AddressBook/AddressBook.h>
#import <EventKit/EventKit.h>
#import <LocalAuthentication/LocalAuthentication.h>

//@import AssetsLibrary;
//@import AddressBook;
//@import EventKit;
//@import CoreTelephony;

/*

 日历 Privacy - Calendars Usage Description 需要您的授权来访问日历
 相机 Privacy - Camera Usage Description    需要访问您的相机来设置您的头像。
 蓝牙 Privacy - Bluetooth Peripheral Usage Description 需要您的授权来访问蓝牙
 麦克风 Privacy - Microphone Usage Description 需要访问您的麦克风来发送您的语音消息。
 通讯录 Privacy - Contacts Usage Description 需要您的授权来访问通讯录
 相册 Privacy - Photo Library Usage Description 需要访问您的相册来设置您的头像。
 后台定位 Privacy - Location Always Usage Description 需要您的授权来定位
 前台定位 Privacy - Location When In Use Usage Description 需要您的授权来定位


 CLLocationManager *manager= [[CLLocationManager alloc] init];
 [manager requestAlwaysAuthorization];
 [manager requestWhenInUseAuthorization];
 */

@interface WCheckAuthor : NSObject
/**
 显示提示消息

 @param alert 提示
 @param viewController 要显示消息的vc
 */
+(void)showAlert:(NSString *)alert viewController:(UIViewController *)viewController;


#pragma mark - 检查权限
/**
 检查麦克风权限

 @return 返回权限状态
 */
+(AVAuthorizationStatus)checkAudioAuthorization;


/**
 检查摄像头权限

 @return 返回权限状态
 */
+(AVAuthorizationStatus)checkCameraAuthorization;


/**
 检查相册权限

 @return 返回权限状态
 */
+(PHAuthorizationStatus)checkPhotoAuthorization;


/**
 检查定位权限

 @return 返回权限状态
 */
+(CLAuthorizationStatus)checkLocationAuthorization;


/**
 检查推送通知权限

 @return 返回权限状态
 */
+(UIUserNotificationType)checkNotificationAuthorization;


/**
 检查通讯录权限

 @return 返回权限状态
 */
+(ABAuthorizationStatus)checkContactAuthorization;


/**
 检查蜂窝网络权限

 @return 返回权限状态
 */
+(CTCellularDataRestrictedState)checkCellularDataAuthorization;



/**
 检查touchid是否可用

 @return 返回是否可用
 */
+(BOOL)checkTouchIDState;

#pragma mark - 获取权限
/**
 获取麦克风权限

 @param viewController 要显示的控制器
 @param handler 回调
 */
+(void)requestAudioWithviewController:(UIViewController *)viewController handler:(StateBlock)handler ;


/**
 获取摄像头权限

 @param handler 回调
 */
+(void)requestCameraWithviewController:(UIViewController *)viewController handler:(StateBlock)handler;


/**
 获取相册权限

 @param handler 回调
 */
+(void)requestPhotoWithviewController:(UIViewController *)viewController handler:(StateBlock)handler;


/**
 获取定位权限权限

 @param handler 回调
 */
+(void)requestLocationWithviewController:(UIViewController *)viewController handler:(StateBlock)handler;


/**
 获取推送通知权限

 @param handler 回调
 */
+(void)requestNotificationWithviewController:(UIViewController *)viewController handler:(StateBlock)handler;


/**
 获取通讯录权限

 @param handler 回调
 */
+(void)requestContactWithviewController:(UIViewController *)viewController handler:(StateBlock)handler;


/**
 获取蜂窝网络权限

 @param handler 回调
 */
+(void)requestCellularDataWithviewController:(UIViewController *)viewController handler:(StateBlock)handler;
@end
