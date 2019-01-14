//
//  WTool.m
//  wzqFundation
//
//  Created by 吴志强 on 2017/11/3.
//  Copyright © 2017年 吴志强. All rights reserved.
//

//工具方法
#import "WTool.h"

@interface WTool ()<UIAlertViewDelegate>

@end

@implementation WTool

#pragma mark - 其他
/**
 判断系统语言是否为中文

 @return 返回结果
 */
+ (BOOL)systemLanguageIsChinese;
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];



    if ([preferredLang isEqualToString:@"zh-Hans"]||[preferredLang isEqualToString:@"zh-Hant"]) {
        return YES;
    }
    return NO;
}


#pragma mark - 跳转到系统设置

/**
 跳转到设置界面

 About — prefs:root=General&path=About

 Accessibility — prefs:root=General&path=ACCESSIBILITY

 AirplaneModeOn— prefs:root=AIRPLANE_MODE

 Auto-Lock — prefs:root=General&path=AUTOLOCK

 Brightness — prefs:root=Brightness

 Date& Time — prefs:root=General&path=DATE_AND_TIME

 FaceTime — prefs:root=FACETIME

 General— prefs:root=General

 Keyboard — prefs:root=General&path=Keyboard

 iCloud — prefs:root=CASTLE  iCloud

 Storage & Backup — prefs:root=CASTLE&path=STORAGE_AND_BACKUP

 International — prefs:root=General&path=INTERNATIONAL

 Music — prefs:root=MUSIC

 Music Equalizer — prefs:root=MUSIC&path=EQ

 Music VolumeLimit— prefs:root=MUSIC&path=VolumeLimit

 Nike + iPod — prefs:root=NIKE_PLUS_IPOD

 Notes — prefs:root=NOTES

 Notification — prefs:root=NOTIFICATIONS_ID

 Phone — prefs:root=Phone

 Profile — prefs:root=General&path=ManagedConfigurationList

 Reset — prefs:root=General&path=Reset

 Safari — prefs:root=Safari  Siri — prefs:root=General&path=Assistant

 Sounds — prefs:root=Sounds

 SoftwareUpdate— prefs:root=General&path=SOFTWARE_UPDATE_LINK

 Store — prefs:root=STORE

 Twitter — prefs:root=TWITTER

 Usage — prefs:root=General&path=USAGE

 VPN — prefs:root=General&path=Network/VPN

 Wallpaper — prefs:root=Wallpaper

 Setting—prefs:root=INTERNET_TETHERING


 @param type 跳转到界面的类型
 */
+(void)pushToSettingWithType:(NSString *)type;
{
    NSString *string = @"";
    if ([type isEqualToString:@"wifi"]) {

        string = @"prefs:WIFI";
    }else if ([type isEqualToString:@"蓝牙"]) {

        string = @"prefs:General&path=Bluetooth";
    }else if ([type isEqualToString:@"定位"]) {

        string = @"prefs:LOCATION_SERVICES";
    }else if ([type isEqualToString:@"相册"]) {

        string = @"prefs:Photos";
    }else if ([type isEqualToString:@"网络"]) {

        string = @"prefs:General&path=Network";
    }else if ([type isEqualToString:@"网络"]) {

        string = @"prefs:Photos";
    }

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}


/**
 从一个范围内返回一个随机数

 @param from 开始范围
 @param to 结束范围
 @return 随机数
 */
+(int)getRandomNumber:(int)from to:(int)to;
{
    return (int)(from + (arc4random() % (to - from + 1)));
}


/**
 判断ver1 是否大于 ver2

 @param Ver1 版本1
 @param Ver2 版本2
 @return 返回是否需要升级 1:大于 0:等于 -1:小于 -10:其他
 */
+(int)compareWithVer1:(NSString *)Ver1 Ver2:(NSString *)Ver2;
{
    NSArray *array1 = [Ver1 componentsSeparatedByString:@"."];
    NSArray *array2 = [Ver2 componentsSeparatedByString:@"."];

    int ver1 = 0;
    int ver2 = 0;

        //版本1
    if (array1.count > 3) {

        ver1 = [array1[0] intValue]*1000000 + [array1[1] intValue]*10000 + [array1[2] intValue]*100 + [array1[3] intValue];
    }
    else if (array1.count > 2) {

        ver1 = [array1[0] intValue]*1000000 + [array1[1] intValue]*10000 + [array1[2] intValue];
    }
    else if (array1.count > 1){

        ver1 = [array1[0] intValue]*1000000 + [array1[1] intValue]*10000;
    }

        //版本2
    if (array2.count > 3) {

        ver2 = [array2[0] intValue]*1000000 + [array2[1] intValue]*10000 + [array2[2] intValue]*100 + [array2[3] intValue];
    }
    else if (array2.count > 2) {

        ver2 = [array2[0] intValue]*1000000 + [array2[1] intValue]*10000 + [array2[2] intValue];
    }
    else if (array2.count > 1){

        ver2 = [array2[0] intValue]*1000000 + [array2[1] intValue]*10000;
    }

        //比较
    if (ver1 > ver2) {

        return 1;
    }
    else if (ver1 == ver2){

        return 0;
    }
    else if (ver1 < ver2){

        return -1;
    }

    return -10;
}


@end
