

//
//  WCheckAuthor.m
//  wzqproject
//
//  Created by 吴志强 on 2017/11/6.
//  Copyright © 2017年 吴志强. All rights reserved.
//

#import "WCheckAuthor.h"

@implementation WCheckAuthor
/**
 显示提示消息

 @param alert 提示
 @param viewController 要显示消息的vc
 */
+(void)showAlert:(NSString *)alert viewController:(UIViewController *)viewController;
{
    [MessageTool showAlertWithTarget:viewController
                                title:@""
                             message:alert
                             actions:@[@"取消",@"去设置"]
                              colors:@[[UIColor colorWithHexString:@"a8a8a8"],[UIColor colorWithHexString:@"c7322b"]] comfirmAction:^(UIAlertAction *action) {

                                  if ([action.title isEqualToString:@"去设置"]){

                                      NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                      if ([ [UIApplication sharedApplication] canOpenURL:url]){

                                          [[UIApplication sharedApplication] openURL:url];
                                      }
                                  }
                              }];
}

#pragma mark - 检查权限状态
/**
 检查麦克风权限

 @return 返回权限状态
 */
+(AVAuthorizationStatus)checkAudioAuthorization;
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:

            return AVAuthorizationStatusNotDetermined;
        case AVAuthorizationStatusRestricted:

            //显示消息
            [MessageTool showToast:@"未授权，家长限制"];
            return AVAuthorizationStatusRestricted;
        case AVAuthorizationStatusDenied:

            return AVAuthorizationStatusDenied;
        case AVAuthorizationStatusAuthorized:

            return AVAuthorizationStatusAuthorized;
        default:
            return 0;
    }
    return 0;
}


/**
 检查摄像头权限

 @return 返回权限状态
 */
+(AVAuthorizationStatus)checkCameraAuthorization;
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:

            return AVAuthorizationStatusNotDetermined;
        case AVAuthorizationStatusRestricted:

            //显示消息
            [MessageTool showToast:@"未授权，家长限制"];
            return AVAuthorizationStatusRestricted;
        case AVAuthorizationStatusDenied:

            return AVAuthorizationStatusDenied;
        case AVAuthorizationStatusAuthorized:

            return AVAuthorizationStatusAuthorized;
        default:
            return 0;
    }
    return 0;
}


/**
 检查相册权限

 @return 返回权限状态
 */
+(PHAuthorizationStatus)checkPhotoAuthorization;
{
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthorStatus) {
        case PHAuthorizationStatusAuthorized:

            return PHAuthorizationStatusAuthorized;

        case PHAuthorizationStatusDenied:

            return PHAuthorizationStatusDenied;

        case PHAuthorizationStatusNotDetermined:

            return PHAuthorizationStatusNotDetermined;

        case PHAuthorizationStatusRestricted:

            //显示消息
            [MessageTool showToast:@"未授权，家长限制"];
            return PHAuthorizationStatusRestricted;

        default:
            break;
    }
}


/**
 检查定位权限

 @return 返回权限状态
 */
+(CLAuthorizationStatus)checkLocationAuthorization;
{
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    if (!isLocation) {

        [MessageTool showToast:@"请打开定位！！！"];
        return 100;
    }
    CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
    switch (CLstatus) {
        case kCLAuthorizationStatusAuthorizedAlways:

            return kCLAuthorizationStatusAuthorizedAlways;

        case kCLAuthorizationStatusAuthorizedWhenInUse:

            return kCLAuthorizationStatusAuthorizedWhenInUse;

        case kCLAuthorizationStatusDenied:

            return kCLAuthorizationStatusDenied;

        case kCLAuthorizationStatusNotDetermined:

            return kCLAuthorizationStatusNotDetermined;

        case kCLAuthorizationStatusRestricted:

            return kCLAuthorizationStatusRestricted;

        default:
            break;
    }
}


/**
 检查推送通知权限

 @return 返回权限状态
 */
+(UIUserNotificationType)checkNotificationAuthorization;
{
    UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    switch (settings.types) {
        case UIUserNotificationTypeNone:

            return UIUserNotificationTypeNone;

        case UIUserNotificationTypeAlert:

            return UIUserNotificationTypeAlert;

        case UIUserNotificationTypeBadge:

            return UIUserNotificationTypeBadge;

        case UIUserNotificationTypeSound:

            return UIUserNotificationTypeSound;

        default:
            break;
    }
}


/**
 检查通讯录权限

 @return 返回权限状态
 */
+(ABAuthorizationStatus)checkContactAuthorization;
{
    ABAuthorizationStatus ABstatus = ABAddressBookGetAuthorizationStatus();
    switch (ABstatus) {
        case kABAuthorizationStatusAuthorized:

            return kABAuthorizationStatusAuthorized;

        case kABAuthorizationStatusDenied:

            return kABAuthorizationStatusDenied;

        case kABAuthorizationStatusNotDetermined:

            return kABAuthorizationStatusNotDetermined;

        case kABAuthorizationStatusRestricted:

            return kABAuthorizationStatusRestricted;

        default:
            break;
    }
}


/**
 检查日历权限

 @return 返回权限状态
 */
+(EKAuthorizationStatus)checkEventAuthorization;
{
    EKAuthorizationStatus EKstatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
    switch (EKstatus) {
        case EKAuthorizationStatusAuthorized:

            return EKAuthorizationStatusAuthorized;

        case EKAuthorizationStatusDenied:

            return EKAuthorizationStatusDenied;

        case EKAuthorizationStatusNotDetermined:

            return EKAuthorizationStatusNotDetermined;

        case EKAuthorizationStatusRestricted:

            return EKAuthorizationStatusRestricted;

        default:
            break;
    }
}

/**
 检查备忘录权限

 @return 返回权限状态
 */
+(EKAuthorizationStatus)checkReminderAuthorization;
{
    EKAuthorizationStatus EKstatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeReminder];
    switch (EKstatus) {
        case EKAuthorizationStatusAuthorized:

            return EKAuthorizationStatusAuthorized;

        case EKAuthorizationStatusDenied:

            return EKAuthorizationStatusDenied;

        case EKAuthorizationStatusNotDetermined:

            return EKAuthorizationStatusNotDetermined;

        case EKAuthorizationStatusRestricted:

            return EKAuthorizationStatusRestricted;

        default:
            break;
    }
}


/**
 检查蜂窝网络权限

 @return 返回权限状态
 */
+(CTCellularDataRestrictedState)checkCellularDataAuthorization;
{
    if (@available(iOS 9.0, *)) {
        CTCellularData *cellularData = [[CTCellularData alloc]init];
        CTCellularDataRestrictedState state = cellularData.restrictedState;
        switch (state) {
            case kCTCellularDataRestricted:

                return kCTCellularDataRestricted;

            case kCTCellularDataNotRestricted:

                return kCTCellularDataNotRestricted;

            case kCTCellularDataRestrictedStateUnknown:

                return kCTCellularDataRestrictedStateUnknown;
        }
    } else {

        return kCTCellularDataRestrictedStateUnknown;
    }
    return kCTCellularDataRestrictedStateUnknown;
}

/**
 检查touchid是否可用

 @return 返回是否可用
 */
+(BOOL)checkTouchIDState;
{
    // @brief 步骤1：检查Touch ID是否可用
    /// @brief 创建指纹验证对象
    LAContext *context = [[LAContext alloc] init];

    /// @brief 使用canEvaluatePolicy方法判断当前用户手机是否支持指纹验证
    return [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:nil];
}
#pragma mark - 获取权限
/**
 获取麦克风权限

 @param handler 回调
 */
+(void)requestAudioWithviewController:(UIViewController *)viewController handler:(StateBlock)handler ;
{
    AVAuthorizationStatus state = [self checkAudioAuthorization];
    if (state == AVAuthorizationStatusNotDetermined) {

        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {//麦克风权限

            if (!granted) {

                [MessageTool showToast:@"用户取消授权!"];
            }else{

                if (handler) {
                    handler(granted);
                }
            }
        }];
    }else if (state == AVAuthorizationStatusDenied) {

        [self showAlert:@"app需要您授权麦克风权限来录制您的声音。" viewController:viewController];
    }else if (state == AVAuthorizationStatusAuthorized) {

        if (handler) {
            handler(YES);
        }
    }
}


/**
 获取摄像头权限

 @param handler 回调
 */
+(void)requestCameraWithviewController:(UIViewController *)viewController handler:(StateBlock)handler;
{
    AVAuthorizationStatus state = [self checkCameraAuthorization];
    if (state == AVAuthorizationStatusNotDetermined) {

        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {//相机权限

            if (!granted) {

                [MessageTool showToast:@"用户取消授权!"];
            }else{

                if (handler) {
                    handler(granted);
                }
            }
        }];
    }else if (state == AVAuthorizationStatusDenied) {

        [self showAlert:@"app需要您授权来访问摄像头。" viewController:viewController];
    }else if (state == AVAuthorizationStatusAuthorized) {

        if (handler) {
            handler(YES);
        }
    }
}


/**
 获取相册权限权限

 @param handler 回调
 */
+(void)requestPhotoWithviewController:(UIViewController *)viewController handler:(StateBlock)handler;
{
    PHAuthorizationStatus state = [self checkPhotoAuthorization];
    if (state == PHAuthorizationStatusNotDetermined) {

        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {

            if (!status) {

                [MessageTool showToast:@"用户取消授权!"];
            }else{

                if (handler) {
                    handler(status);
                }
            }
        }];
    }else if (state == PHAuthorizationStatusDenied) {

        [self showAlert:@"app需要您授权来访问相册。" viewController:viewController];
    }else if (state == PHAuthorizationStatusAuthorized) {

        if (handler) {
            handler(YES);
        }
    }
}


/**
 获取定位权限

 @param handler 回调
 */
+(void)requestLocationWithviewController:(UIViewController *)viewController handler:(StateBlock)handler;
{
    CLAuthorizationStatus state = [self checkLocationAuthorization];
    if (state == kCLAuthorizationStatusNotDetermined) {

        if (handler) {
            handler(YES);
        }
    }else if (state == kCLAuthorizationStatusDenied) {

        [self showAlert:@"app需要您授权来获取定位。" viewController:viewController];
    }else if (state == kCLAuthorizationStatusAuthorizedAlways||
              state == kCLAuthorizationStatusAuthorizedWhenInUse) {

        if (handler) {
            handler(YES);
        }
    }
}


/**
 获取推送通知权限

 @param handler 回调
 */
+(void)requestNotificationWithviewController:(UIViewController *)viewController handler:(StateBlock)handler;
{
    UIUserNotificationType state = [self checkNotificationAuthorization];
    if (state == UIUserNotificationTypeNone) {

        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }else {

        if (handler) {
            handler(YES);
        }
    }
}


/**
 获取通讯录权限

 @param handler 回调
 */
+(void)requestContactWithviewController:(UIViewController *)viewController handler:(StateBlock)handler;
{
    ABAuthorizationStatus state = [self checkContactAuthorization];
    if (state == kABAuthorizationStatusNotDetermined) {

        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {

            if (granted){

                if (handler) {
                    handler(YES);
                }
                CFRelease(addressBook);
            }else{

                [MessageTool showToast:@"用户取消授权!"];
                CFRelease(addressBook);
            }
        });

    }else if (state == kABAuthorizationStatusDenied) {

        [self showAlert:@"app需要您授权来读取您的通讯录。" viewController:viewController];
    }else if (state == kABAuthorizationStatusAuthorized) {

        if (handler) {
            handler(YES);
        }
    }
}


/**
 获取日历权限

 @param handler 回调
 */
+(void)requestEventWithviewController:(UIViewController *)viewController handler:(StateBlock)handler;
{
    EKAuthorizationStatus state = [self checkEventAuthorization];
    if (state == kABAuthorizationStatusNotDetermined) {

        EKEventStore *store = [[EKEventStore alloc]init];
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {

            if (granted) {

                if (handler) {
                    handler(YES);
                }
            }else{

                [MessageTool showToast:@"用户取消授权!"];
            }
        }];
    }else if (state == kABAuthorizationStatusDenied) {

        [self showAlert:@"app需要您授权来读取您的日历事件。" viewController:viewController];
    }else if (state == kABAuthorizationStatusAuthorized) {

        if (handler) {
            handler(YES);
        }
    }
}


/**
 获取备忘录权限

 @param handler 回调
 */
+(void)requestReminderWithviewController:(UIViewController *)viewController handler:(StateBlock)handler;
{
    EKAuthorizationStatus state = [self checkReminderAuthorization];
    if (state == kABAuthorizationStatusNotDetermined) {

        EKEventStore *store = [[EKEventStore alloc]init];
        [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {

            if (granted) {

                if (handler) {
                    handler(YES);
                }
            }else{

                [MessageTool showToast:@"用户取消授权!"];
            }
        }];
    }else if (state == kABAuthorizationStatusDenied) {

        [self showAlert:@"app需要您授权来读取您的备忘录事件。" viewController:viewController];
    }else if (state == kABAuthorizationStatusAuthorized) {

        if (handler) {
            handler(YES);
        }
    }
}


/**
 获取蜂窝网络权限

 @param handler 回调
 */
+(void)requestCellularDataWithviewController:(UIViewController *)viewController handler:(StateBlock)handler;
{
    CTCellularDataRestrictedState state = [self checkCellularDataAuthorization];
    if (state == kCTCellularDataRestricted) {

        [self showAlert:@"app需要您授权来读取您的备忘录事件。" viewController:viewController];
    }else if (state == kCTCellularDataNotRestricted) {

        if (handler) {
            handler(YES);
        }
    }
}
@end
