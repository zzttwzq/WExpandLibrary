


    //
//  WDevice.m
//  AFNetworking
//
//  Created by 吴志强 on 2018/5/10.
//

#import "WDevice.h"


@interface WDevice ()

@property (nonatomic,copy)viewOrientationChanged orientationChange;

@end

@implementation WDevice

#pragma mark - 获取系统信息
/**
 获取实例对象

 @return 返回实例对象
 */
+ (WDevice *)shareInstance;
{
    static WDevice *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


/**
 获取所有相关IP信息

 @return 返回IP信息
 */
+ (NSDictionary *)getIPAddressInfo;
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];

        // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
            // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
            // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}


/**
 获取设备当前网络IP地址

 @param preferIPv4 是否是ipve4
 @return 返回IP地址
 */
+ (NSString *)getIPAddressForIPV4:(BOOL)preferIPv4;
{
    NSArray *searchArray = preferIPv4 ?
    @[ /*IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6,*/ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ /*IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4,*/ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;

    NSDictionary *addresses = [self getIPAddressInfo];

    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
     address = addresses[key];
     if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}


/**
 判断热点是否开启

 @return 返回是否开启热点
 */
+ (BOOL)HotSpotIsOpened;
{
    NSDictionary *dict = [self getIPAddressInfo];
    if ( dict ) {
        NSArray *keys = dict.allKeys;
        for ( NSString *key in keys) {
            if ( key && [key containsString:@"bridge"])
                return YES;
        }
    }
    return NO;
}


/**
 获取系统音量

 @return 返回系统音量
 */
+(float)getSystemVolume;
{
    return [[AVAudioSession sharedInstance] outputVolume];
}


/**
 获取屏幕亮度

 @return 返回屏幕亮度
 */
+(float)getScreenBrightness;
{
    return [UIScreen mainScreen].brightness;
}


/**
 屏幕方向改变

 @param change 改变的方向
 */
+(void)viewOrientationChange:(viewOrientationChanged)change;
{
    //设备旋转通知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];


    WDevice *device = [WDevice new];
    device.orientationChange = ^(UIDeviceOrientation orientation) {

        change(orientation);
    };


    [[NSNotificationCenter defaultCenter] addObserver:device
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}

- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    UIDevice *device = [UIDevice currentDevice] ;

    switch (device.orientation) {
        case UIDeviceOrientationFaceUp:
            NSLog(@"屏幕朝上平躺");
            break;

        case UIDeviceOrientationFaceDown:
            NSLog(@"屏幕朝下平躺");
            break;

        case UIDeviceOrientationUnknown:
            NSLog(@"未知方向");
            break;

        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"home键在右");

            break;

        case UIDeviceOrientationLandscapeRight:
            NSLog(@"home键在左");

            break;

        case UIDeviceOrientationPortrait:
            NSLog(@"home键在下");

            break;

        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"home键在上");
            break;

        default:
            NSLog(@"无法辨识");
            break;
    }
}


#pragma mark - 设置系统状态
/**
 设置状态条为白色

 @param isWhite yes 白色  no 黑色
 */
+(void)setStatueBarColorWihte:(BOOL)isWhite;
{
    if (isWhite) {

        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }else{

        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}


/**
 设置系统屏幕亮度

 @param brightness 屏幕亮度
 */
+(void)setScreenBrightness:(CGFloat)brightness;
{
    [[UIScreen mainScreen] setBrightness:brightness];
}


/**
 设置系统音量大小

 @param value 音量大小
 */
+(void)setSystemVolume:(CGFloat)value;
{

    
}


/**
 自动息屏

 @param shut 是否自动息屏， 默认是yes
 */
+(void)auotShutScreen:(BOOL)shut;
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:shut];
}


/**
 显示状态条

 @param show 显示
 */
+(void)showStatueBar:(BOOL)show;
{
    if (show) {

            //设置WindowLevel与状态栏平级，起到隐藏状态栏的效果
        [[[UIApplication sharedApplication] keyWindow] setWindowLevel:UIWindowLevelNormal];
    }else{

            //设置WindowLevel与状态栏平级，起到隐藏状态栏的效果
        [[[UIApplication sharedApplication] keyWindow] setWindowLevel:UIWindowLevelStatusBar];
    }
}


/**
 是否打开设备红外线

 @param enable 打开
 */
+(void)openDeviceProximityMonitoring:(BOOL)enable;
{
    //这个功能是开启红外感应
    [[UIDevice currentDevice] setProximityMonitoringEnabled:enable];
}


/**
 设备是否靠近用户

 @param block 返回回调， yes 就是已经靠近用户 no 远离用户
 */
+(void)deviceToUserDistenceChanged:(StateBlock)block;
{
    [self openDeviceProximityMonitoring:YES];

    [WDevice shareInstance].deviceDistenceChanged = ^(BOOL state) {

        block(state);
    };
    //添加监听
    [[NSNotificationCenter defaultCenter] addObserver:[WDevice shareInstance]
                                             selector:@selector(sensorStateChange:)
                                                 name:@"UIDeviceProximityStateDidChangeNotification"
                                               object:nil];

}


//处理监听触发事件
-(void)sensorStateChange:(NSNotificationCenter *)notification;
{
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗（省电啊）
    if ([[UIDevice currentDevice] proximityState] == YES){

        NSLog(@"Device is close to user");
        self.deviceDistenceChanged(YES);
    }
    else{

        NSLog(@"Device is not close to user");
        self.deviceDistenceChanged(NO);
    }
}


/**
 是否使用扬声器

 @param isSpeaker 使用扬声器
 */
+(void)playSoundWithSpeaker:(BOOL)isSpeaker;
{
    if (isSpeaker) {

        //切换为扬声器播放
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];

    }else{

        if ([[[AVAudioSession sharedInstance] category] isEqualToString:AVAudioSessionCategoryPlayback]){

            //切换为听筒播放
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        }
    }
}


/**
 打开闪光灯

 @param open 是否打开
 */
+(void)openCameraLight:(BOOL)open;
{
    // 根据brightnessValue的值来打开和关闭闪光灯
    AVCaptureDevice*device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    BOOL result = [device hasTorch];// 判断设备是否有闪光灯
    if(open &&
       result) {

        // 打开闪光灯
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];//开
        [device unlockForConfiguration];
    }else if(open) {

        // 关闭闪光灯
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];//关
        [device unlockForConfiguration];
    }
}


/**
 打开系统振动

 @param seconds 振动的事件
 */
+(void)openSystemVibrateFor:(NSTimeInterval)seconds;
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);// 震动
    [ThreadTools startTimerWithTotalTime:2 countHandler:^(float count) {

        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);// 震动
    }];
}


/**
 打开一个简易的系统提示音 包括振动
 */
+(void)openSimpleSystemAlertSound;
{
    AudioServicesPlaySystemSound(1007); //这个声音是是类似于QQ声音的
}
@end
