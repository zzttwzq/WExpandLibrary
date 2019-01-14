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

//******************************** 快捷方法 *************************************//
/**
 跳转到设置界面

 @param type 跳转到界面的类型 :wifi 相册 蓝牙 网络 定位
 */
+ (void) pushToSettingWithType:(NSString *)type;


/**
 判断系统语言是否为中文

 @return 返回结果
 */
+ (BOOL) systemLanguageIsChinese;


/**
 从一个范围内返回一个随机数

 @param from 开始范围
 @param to 结束范围
 @return 随机数
 */
+ (int) getRandomNumber:(int)from to:(int)to;


/**
 判断ver1 是否大于 ver2 最多支持3位

 @param Ver1 版本1
 @param Ver2 版本2
 @return 返回是否需要升级 1:大于 0:等于 -1:小于 -10:其他
 */
+(int)compareWithVer1:(NSString *)Ver1 Ver2:(NSString *)Ver2;

@end
