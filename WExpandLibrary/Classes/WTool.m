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

/**
 自动息屏

 @param shut 是否自动息屏， 默认是yes
 */
+(void)auotShutScreen:(BOOL)shut;
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:shut];
}

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



/**
 判断密码是否过于简单

 @param pass 要判断的密码
 @return 返回值
 */
+(BOOL)needChangePass:(NSString *)pass;
{
    NSArray *array = @[@"123456",@"111111",@"654321",@"123123",@"222222"];
    if ([array containsObject:pass]) {

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
 判断是否是iphonex

 @return 返回判断值
 */
+(BOOL)isiPhoneX;
{
    if (ScreenHeight == 812) {

        return YES;
    }

    return NO;
}

/**
 数组排序 降序 4 3 2 1

 @param array 要排序的数组
 @return 排完序的数组
 */
+ (NSArray *)sortArrayDesc:(NSArray *)array;
{
        //对数组进行排序
    return [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {

        return [obj2 compare:obj1]; //降序

    }];
}

/**
 数组排序 升序 1 2 3 4

 @param array 要排序的数组
 @return 排完序的数组
 */
+ (NSArray *)sortArrayAsc:(NSArray *)array;
{
        //对数组进行排序
    return [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {

        return [obj1 compare:obj2]; //升序

    }];
}


/**
 返回导航栏高度

 @return 返回高度
 */
+(NSInteger)getNavbarHeight;
{
    float height = 64;
    if ([WTool isiPhoneX]) {

        height = 88;
    }

    if ([WDevice HotSpotIsOpened]) {

        height += 20;
    }

    return height;
}

/**
 返回底部高度

 @return 返回高度
 */
+(NSInteger)getBottomHeight;
{
    float height = 0;
    if (isIPHoneX) {

        height = 30;
    }

    return height;
}


/**
 数出字符个数，中文只占一个

 @param string 要计算的字符
 @return 返回字符个数
 */
+(int)countCharNum:(NSString *)string;
{
    int count = 0;
    int count1 =0;

    for (int i =0; i<string.length;i++){

        unichar c = [string characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5){

            count ++;
        }else{

            count1 ++;
        }
    }

    return count+count1;
}


///**
// 创建静态字符串
//
// @param string 静态字符串
// @return 返回静态字符串
// */
//+(NSString *)createStaticString:(NSString *)string;
//{
//    static NSString *strings = string;
//    return strings;
//}
@end
