//
//  Definetion.h
//  Pods
//
//  Created by 吴志强 on 2018/7/9.
//

#ifndef MicroDefinetion_h
#define MicroDefinetion_h

//系统框架
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - 常用分类
//系统框架
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sqlite3.h>

//================================== 屏幕尺寸 ==============================================
#pragma mark - 屏幕尺寸
//================================== 屏幕尺寸 ==============================================

#define ScreenWidth             [UIScreen mainScreen].bounds.size.width
#define ScreenHeight            [UIScreen mainScreen].bounds.size.height

#define Adjust_Width(x) ScreenWidth / 375 * x
#define Adjust_Heght(y) (kScreen_Height == 812.0 ? 667.0 : kScreen_Height) / 667 * y
#define Adjust_Font(float) [UIFont systemFontOfSize:float * (ScreenHeight == 812.0 ? 667.0 : ScreenHeight) / 667.0]

#define IS_IPHONE_4             [WDevice is_Iphone_4]
#define IS_IPHONE_5             [WDevice is_Iphone_5]
#define IS_IPHONE_6             [WDevice is_Iphone_6]
#define IS_IPHONE_6p            [WDevice is_Iphone_6p]
#define IS_IPHONE_X             [WDevice is_Iphone_x]

#define Height_NavContentBar    44.0f
#define Height_StatusBar        (IS_IPHONE_X==YES)?44.0f: 20.0f
#define Height_NavBar           [WDevice getNavbarHeight]
#define Height_TabBar           (IS_IPHONE_X==YES)?83.0f: 49.0f
#define Height_Bottom           (IS_IPHONE_X==YES)?34.0f: 0.0f

#ifdef DEBUG

    #define WLOG(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

    #define WJSON_LOG(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:__VA_ARGS__ options:kNilOptions error:nil] encoding:NSUTF8StringEncoding] UTF8String]);

    #define WLOG_METHOD         NSLog(@"%s", __func__);
#else

    #define WLOG(...);
    #define WJSON_LOG;
    #define WLOG_METHOD;
#endif

//显示调试消息
#define DEBUG_LOG(TARGET,MESSAGE) WLOG(@"<! 警告 !> %@ %@",TARGET,MESSAGE)

//================================== 常用方法 ==============================================
#pragma mark - 常用的方法
//================================== 常用方法 ==============================================

#define KeyWindow               [UIApplication sharedApplication].keyWindow
#define keyViewController       [UIApplication sharedApplication].keyWindow.rootViewController

#define VIEW_WITH_RECT(x,y,width,height) [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
#define LABEL_WITH_RECT(x,y,width,height) [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
#define IMAGE_WITH_RECT(x,y,width,height) [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
#define TEXTFIELD_WITH_RECT(x,y,width,height) [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
#define BUTTON_WITH_RECT(x,y,width,height) [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];

#define VIEW [[UIView alloc] init];
#define LABEL [[UILabel alloc] init];
#define IMAGE [[UIImageView alloc] init];
#define TEXTFIELD [[UITextField alloc] init];
#define BUTTON [UIButton buttonWithType:UIButtonTypeCustom];

//获取颜色
#define RGBA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define COLORWITHHEX(HEX) [UIColor colorWithHexString:[NSString stringWithFormat:@"#%@",HEX]]
#define RandomColor RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define WINDOW_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]

//弱引用
#define WEAK_SELF(Class) typeof(Class *)weakSelf = self;

//拨打电话
#define CALL_PHONE_NUM(NUM) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:/%@",NUM]]];

//发送通知
#define POST_NOTIFICATION(NAME) [[NSNotificationCenter defaultCenter] postNotificationName:NAME object:nil];

//注册通知
#define REGISTER_NOTIFICATION(SELECTOR,NAME) [[NSNotificationCenter defaultCenter] addObserver:self selector:SELECTOR name:NAME object:nil];

//移除通知
#define REMOVE_NOTIFICATION(NAME) [[NSNotificationCenter defaultCenter] removeObserver:self name:NAME object:nil]

//弧度转角度
#define RADIANS_TO_DEGREES(radians) (radians * (180.0 / M_PI))

#define IMAGE_NAMED(A) [UIImage imageNamed:A]

#define URL_WITH_STRING(A) [NSURL URLWithString:A]

#define iOSVersion  [[[UIDevice currentDevice] systemVersion] floatValue]

#define UserDefault [NSUserDefaults standardUserDefaults]

#define RandomWithRange(A,B) [WTool getRandomNumber:A to:B]

//================================== block回调 ==============================================
#pragma mark - 常用的宏定义
//================================== block回调 ==============================================
//返回空的回调
typedef void (^BlankBlock)(void);
//返回状态
typedef void (^StateBlock)(BOOL state);
//返回字符串
typedef void (^StringBlock)(NSString * _Nullable string);
//返回int 数据
typedef void (^CountBlock)(int count);
//返回float 数据
typedef void (^floatCallBack)(float update);
//图片回调
typedef void (^ImageBlock)(UIImage * _Nullable image);
//按钮回调
typedef void (^BtnBlock)(UIButton * _Nullable btn);
//按钮回调
typedef void (^Array_Block)(NSArray *array);
//按钮回调
typedef void (^ButtonBlock)(UIButton *btn);

//是否要显示导航页
#define SHOWNAVPAGE @"SHOWNAVPAGE"

//升级成功提示
#define UPDATE_LATER @"UPDATE_LATER"

#endif /* Definetion_h */
