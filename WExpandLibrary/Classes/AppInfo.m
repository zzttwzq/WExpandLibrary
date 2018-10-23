//
//  AppInfo.m
//  Expecta
//
//  Created by 吴志强 on 2018/2/8.
//

#import "AppInfo.h"

@implementation AppInfo

/**
 获取实例对象

 @return 返回实例对象
 */
+ (AppInfo *)getInstance;
{
    static AppInfo *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{

        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


/**
 获取app信息并存到全局中
 */
+(void)getAppInfo;
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *IDFV =[[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *upperStr = [IDFV uppercaseStringWithLocale:[NSLocale currentLocale]];


    [AppInfo getInstance].app_name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    [AppInfo getInstance].app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [AppInfo getInstance].app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    [AppInfo getInstance].deviceNo = upperStr;
    [AppInfo getInstance].sys_Version = [[UIDevice currentDevice] systemVersion];

    float ScreenHeight = [UIScreen mainScreen].bounds.size.height;
    if (ScreenHeight == 480) {

        [AppInfo getInstance].screenType = WScreenType_4;
    }else if (ScreenHeight == 568) {

        [AppInfo getInstance].screenType = WScreenType_5;
    }else if (ScreenHeight == 667) {

        [AppInfo getInstance].screenType = WScreenType_6;
    }else if (ScreenHeight == 736) {

        [AppInfo getInstance].screenType = WScreenType_6p;
    }else if (ScreenHeight == 812) {

        [AppInfo getInstance].screenType = WScreenType_x;
    }

//    [WNetwork netWorkOnChange:^(NSDictionary *dic) {
//
//        if ([AppInfo getInstance].netChanged) {
//            [AppInfo getInstance].netChanged(YES);
//        }
//        SHOW_INFO_MESSAGE(dic[@"msg"]);
//    }];
}

@end
