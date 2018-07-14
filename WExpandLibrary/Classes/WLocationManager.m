//
//  WLocationManager.m
//  AFNetworking
//
//  Created by 吴志强 on 2018/3/6.
//

#import "WLocationManager.h"

@interface WLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation WLocationManager

/**
 创建单利

 @return 返回单利
 */
+ (instancetype)getInstance;
{
    static WLocationManager *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{

        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}


/**
 开始更新位置
 */
-(void)startUpdateLocation;
{
    [self.locationManager startUpdatingLocation];
}


/**
 停止更新位置
 */
-(void)stopUpdateLocation;
{
    [self.locationManager stopUpdatingHeading];
}


/**
 开启定位监测

 @param block 回调
 */
-(void)monitorLocationWithBlock:(LocationBlock)block;
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 50;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;

    [_locationManager requestAlwaysAuthorization];
    [_locationManager requestWhenInUseAuthorization];
    if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用

        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (status == kCLAuthorizationStatusAuthorizedWhenInUse ||
            status == kCLAuthorizationStatusAuthorizedAlways) {

            [self startUpdateLocation]; // 开始定位

            self.location = ^(CLPlacemark *newPlace) {

                block(newPlace);
            };
        }else {

            block(nil);
        }
    }else{
        
        block(nil);
    }
}

// 定位成功时调用
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations API_AVAILABLE(ios(6.0), macos(10.9));
{
    CLLocation *location = [locations firstObject];

    //1.获取用户位置的对象
    CLLocationCoordinate2D coordinate = location.coordinate;
    self.longitude = coordinate.longitude;
    self.latitude = coordinate.latitude;

    // 保存 Device 的现语言 (英语 法语 ，，，)
    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
                                            objectForKey:@"AppleLanguages"];
    // 强制 成 简体中文
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil]
                                              forKey:@"AppleLanguages"];

    //2.解析地理位置
    CLGeocoder *geo = [[CLGeocoder alloc] init];
    [geo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {

        if (error == nil) {

            CLPlacemark *pl = [placemarks firstObject];
            if (self.location){

                self.city = pl.locality;
                self.location(pl);
            }
        }else{

            self.city = nil;
            if (self.location){
                self.location(nil);
            }
        }

        // 还原Device 的语言
        [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];

    }];
}

/**
 使用api解析定位经纬度

 @param block 返回定位结果
 */
-(void)getPlaceWithAMAP:(LocationBlock)block;
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"78edb11fdb50003fede3a860c4234783" forKey:@"key"];
    [dic setObject:[NSString stringWithFormat:@"%f,%f",[WLocationManager getInstance].longitude,[WLocationManager getInstance].latitude] forKey:@"location"];
    [dic setObject:@"100" forKey:@"radius"];
    [WNetwork
     postTaskWithURL:@"https://restapi.amap.com/v3/geocode/regeo?parameters" params:dic hostType:HostType_Main enableLoading:YES setHeaderfield:^(NSMutableURLRequest * _Nonnull request) {

     } result:^(NSDictionary * _Nullable dic, NSError * _Nullable error) {


//         block();
     }];
}

-(void)showMessage:(NSString *)message
{
    [MessageTool showToast:message];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;
{

}

@end
