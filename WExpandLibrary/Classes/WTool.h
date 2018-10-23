//
//  WTool.h
//  wzqFundation
//
//  Created by 吴志强 on 2017/11/3.
//  Copyright © 2017年 吴志强. All rights reserved.
//

#import <WBasicLibrary/WBasicHeader.h>
#import "WDevice.h"

@interface WTool : NSObject

//******************************** 屏幕相关 *************************************//
/**
 判断是否是iphonex

 @return 返回判断值
 */
+(BOOL)isiPhoneX;


/**
 返回导航栏高度

 @return 返回高度
 */
+(NSInteger)getNavbarHeight;


/**
 返回底部高度

 @return 返回高度
 */
+(NSInteger)getBottomHeight;


//******************************** 快捷方法 *************************************//
/**
 跳转到设置界面

 @param type 跳转到界面的类型 :wifi 相册 蓝牙 网络 定位
 */
+(void)pushToSettingWithType:(NSString *)type;


/**
 判断系统语言是否为中文

 @return 返回结果
 */
+ (BOOL)systemLanguageIsChinese;


/**
 判断密码是否过于简单

 @param pass 要判断的密码
 @return 返回值
 */
+(BOOL)needChangePass:(NSString *)pass;


/**
 从一个范围内返回一个随机数

 @param from 开始范围
 @param to 结束范围
 @return 随机数
 */
+(int)getRandomNumber:(int)from to:(int)to;



/**
 数组排序 降序 4 3 2 1

 @param array 要排序的数组
 @return 排完序的数组
 */
+ (NSArray *)sortArrayDesc:(NSArray *)array;


/**
 数组排序 升序 1 2 3 4

 @param array 要排序的数组
 @return 排完序的数组
 */
+ (NSArray *)sortArrayAsc:(NSArray *)array;


/**
 数出字符个数，中文只占一个

 @param string 要计算的中英文混合字符串
 @return 返回字符个数
 */
+(int)countCharNum:(NSString *)string;


/**
 判断ver1 是否大于 ver2 最多支持3位

 @param Ver1 版本1
 @param Ver2 版本2
 @return 返回是否需要升级 1:大于 0:等于 -1:小于 -10:其他
 */
+(int)compareWithVer1:(NSString *)Ver1 Ver2:(NSString *)Ver2;

///**
// 创建静态字符串
//
// @param string 静态字符串
// @return 返回静态字符串
// */
//+(NSString *)createStaticString:(NSString *)string;
@end
