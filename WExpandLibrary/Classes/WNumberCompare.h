//
//  WNumberCompare.h
//  Pods
//
//  Created by 吴志强 on 2018/3/6.
//

#import <Foundation/Foundation.h>

@interface WNumberCompare : NSObject

#pragma mark - 比较
/**
 比较字符串1 是否大于字符串2

 @param d1 字符串1
 @param d2 字符串2
 @return 返回bool
 */
+(BOOL)numDayu:(NSString *)d1 d2:(NSString *)d2;

/**
 比较 字符串1 是否大于等于 字符串2

 @param d1 字符串1
 @param d2 字符串2
 @return 返回bool
 */
+(BOOL)numDayuDengyu:(NSString *)d1 d2:(NSString *)d2;

/**
 比较 字符串1 是否小于 字符串2

 @param d1 字符串1
 @param d2 字符串2
 @return 返回bool
 */
+(BOOL)numXiaoyu:(NSString *)d1 d2:(NSString *)d2;

/**
 比较 字符串1 是否大于等于 字符串2

 @param d1 字符串1
 @param d2 字符串2
 @return 返回bool
 */
+(BOOL)numXiaoyuDengyu:(NSString *)d1 d2:(NSString *)d2;

#pragma mark - 计算

/**
 两个字符串相加

 @param d1 字符串1
 @param d2 字符串2
 @return 返回累加后的字符串
 */
+(NSString *)numadd:(NSString *)d1 d2:(NSString *)d2;

/**
 字符串相减

 @param d1 字符串1
 @param d2 字符串2
 @return 返回相减字符串
 */
+(NSString *)numjian:(NSString *)d1 d2:(NSString *)d2;

/**
 字符串除

 @param d1 字符串1
 @param d2 字符串2
 @return 返回相除后的字符串
 */
+(NSString *)numchu:(NSString *)d1 d2:(NSString *)d2;

/**
 字符串相乘

 @param d1 字符串1
 @param d2 字符串2
 @return 返回字符串相乘
 */
+(NSString *)numcheng:(NSString *)d1 d2:(NSString *)d2;
@end
