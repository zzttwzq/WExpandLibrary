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

#import "NSDate+Whandler.h"          //日期分类
#import "NSObject+Whandler.h"        //运行时分类
#import "UIView+WHandler.h"          //view扩展分类
#import "UIColor+Whandler.h"         //color扩展分类
#import "NSData+AES256_.h"           //data的分类
#import "NSData+Base64_.h"           //data的分类
#import "NSString+WHandler.h"        //字符串的分类
#import "NSMutableArray+WHandler.h"  //数组的分类
#import "UILabel+WHandler.h"         //标签的分类
#import "UIImage+WHandler.h"         //image的分类
#import "UIViewController+BasicHandler.h"
#import "UIViewController+WebHandler.h"
#import "UIViewController+TableHandler.h"


//==================================== 常用的宏定义 ==========================================
#pragma mark - 常用的宏定义
//==================================== 常用的宏定义 ==========================================
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//#define NavBarHeight [WTool getNavbarHeight]
//#define BottomHeight [WTool getBottomHeight]
//#define isIPHoneX [WTool isiPhoneX]

#ifdef DEBUG
#define WLOG(...) NSLog(__VA_ARGS__);
#define WLOG_METHOD NSLog(@"%s", __func__);
#else
#define WLOG(...);
#define WLOG_METHOD;
#endif

//显示调试消息
#define DEBUG_LOG(TARGET,MESSAGE) WLOG(@"<!警告!> %@ %@",TARGET,MESSAGE)

#define VIEW_WITH_RECT(x,y,width,height) [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)]
#define LABEL_WITH_RECT(x,y,width,height) [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)]
#define IMAGE_WITH_RECT(x,y,width,height) [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)]

//是否要显示导航页
#define SHOWNAVPAGE @"SHOWNAVPAGE"

//升级成功提示
#define UPDATE_LATER @"UPDATE_LATER"



//================================== 常用方法 ==============================================
#pragma mark - 常用的宏定义
//================================== 常用方法 ==============================================
#define NavBarHeight [WTool getNavbarHeight]
#define BottomHeight [WTool getBottomHeight]
#define isIPHoneX [WTool isiPhoneX]

//获取颜色
#define RGBA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define COLORWITHHEX(HEX) [UIColor colorWithHexString:[NSString stringWithFormat:@"#%@",HEX]]
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



//================================== 显示消息 ==============================================
#pragma mark - 常用的宏定义
//================================== 显示消息 ==============================================
#define SHOW_SUCCESS_MESSAGE(_MESSAGE_) [WMessage showSuccessMessage:_MESSAGE_];
#define SHOW_INFO_MESSAGE(_MESSAGE_) [WMessage showInfoMessage:_MESSAGE_];
#define SHOW_ERROR_MESSAGE(_MESSAGE_) [WMessage showErrorMessage:_MESSAGE_];



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


#endif /* Definetion_h */
