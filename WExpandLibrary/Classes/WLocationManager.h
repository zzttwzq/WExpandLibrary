//
//  WLocationManager.h
//  AFNetworking
//
//  Created by 吴志强 on 2018/3/6.
//

#import <WBasicLibrary/WBasicHeader.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^LocationBlock)(CLPlacemark * _Nullable placeMark);

@interface WLocationManager : NSObject
//************************* 定位 *************************//
//
@property (nonatomic,copy) LocationBlock location;

//经度
@property (nonatomic,assign) double longitude;

//纬度
@property (nonatomic,assign) double latitude;

///格式化地址
@property (nonatomic, copy) NSString *formattedAddress;

//国家
@property (nonatomic, copy) NSString *country;

//省/直辖市
@property (nonatomic, copy) NSString *province;

//市
@property (nonatomic, copy) NSString *city;

//区
@property (nonatomic, copy) NSString *district;

//城市编码
@property (nonatomic, copy) NSString *citycode;

//区域编码
@property (nonatomic, copy) NSString *adcode;

//街道名称
@property (nonatomic, copy) NSString *street;

//门牌号
@property (nonatomic, copy) NSString *number;

//兴趣点名称
@property (nonatomic, copy) NSString *POIName;

//所属兴趣点名称
@property (nonatomic, copy) NSString *AOIName;



/**
 创建单利

 @return 返回单利
 */
+ (instancetype)getInstance;


/**
 初始化定位管理

 @param block 回调
 */
-(void)monitorLocationWithBlock:(LocationBlock)block;


/**
 使用api解析定位经纬度

 @param block 返回定位结果
 */
-(void)getPlaceWithAMAP:(LocationBlock)block;


/**
 开始更新位置
 */
-(void)startUpdateLocation;


/**
 停止更新位置
 */
-(void)stopUpdateLocation;
@end
