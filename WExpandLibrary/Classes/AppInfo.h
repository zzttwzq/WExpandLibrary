//
//  AppInfo.h
//  Expecta
//
//  Created by 吴志强 on 2018/2/8.
//

#import <UIKit/UIKit.h>

//设备类型
typedef NS_ENUM(NSInteger,WScreenType) {
    WScreenType_4,
    WScreenType_5,
    WScreenType_6,
    WScreenType_6p,
    WScreenType_x,
};

@interface AppInfo : NSObject
@property (nonatomic,copy)NSString *app_Version;
@property (nonatomic,copy)NSString *app_build;
@property (nonatomic,copy)NSString *app_name;
@property (nonatomic,assign)WScreenType screenType;
@property (nonatomic,copy)NSString *sys_Version;
@property (nonatomic,copy)NSString *deviceNo;
@property (nonatomic,assign) BOOL lastVersion;
//@property (nonatomic,assign) WNetStatue netState;
//@property (nonatomic,copy) StateBlock netChanged;

/**
 获取实例对象

 @return 返回实例对象
 */
+ (AppInfo *)getInstance;


/**
 获取app信息并存到全局中
 */
+(void)getAppInfo;

@end
