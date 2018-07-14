//
//  WNumberCompare.m
//  Pods
//
//  Created by 吴志强 on 2018/3/6.
//

#import "WNumberCompare.h"

@implementation WNumberCompare

#pragma mark - 比较

/**
 比较字符串1 是否大于字符串2

 @param d1 字符串1
 @param d2 字符串2
 @return 返回bool
 */
+(BOOL)numDayu:(NSString *)d1 d2:(NSString *)d2;
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:d1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:d2];

    NSComparisonResult result_clearrate_float = [num1 compare:num2];

    if (result_clearrate_float == NSOrderedDescending) {

        return YES;
    }
    return NO;
}


/**
 比较 字符串1 是否大于等于 字符串2

 @param d1 字符串1
 @param d2 字符串2
 @return 返回bool
 */
+(BOOL)numDayuDengyu:(NSString *)d1 d2:(NSString *)d2;
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:d1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:d2];

    NSComparisonResult result_clearrate_float = [num1 compare:num2];

    if (result_clearrate_float == NSOrderedDescending||
        result_clearrate_float == NSOrderedSame) {

        return YES;
    }
    return NO;
}


/**
 比较 字符串1 是否小于 字符串2

 @param d1 字符串1
 @param d2 字符串2
 @return 返回bool
 */
+(BOOL)numXiaoyu:(NSString *)d1 d2:(NSString *)d2;
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:d1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:d2];

    NSComparisonResult result_clearrate_float = [num1 compare:num2];

    if (result_clearrate_float == NSOrderedAscending) {

        return YES;
    }
    return NO;
}


/**
 比较 字符串1 是否大于等于 字符串2

 @param d1 字符串1
 @param d2 字符串2
 @return 返回bool
 */
+(BOOL)numXiaoyuDengyu:(NSString *)d1 d2:(NSString *)d2;
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:d1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:d2];

    NSComparisonResult result_clearrate_float = [num1 compare:num2];

    if (result_clearrate_float == NSOrderedAscending||
        result_clearrate_float == NSOrderedSame) {

        return YES;
    }
    return NO;
}

#pragma mark - 计算

/**
 两个字符串相加

 @param d1 字符串1
 @param d2 字符串2
 @return 返回累加后的字符串
 */
+(NSString *)numadd:(NSString *)d1 d2:(NSString *)d2;
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:d1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:d2];

    NSDecimalNumber *total = [num1 decimalNumberByAdding:num2];

    return [(NSDecimalNumber *)total stringValue];
}


/**
 字符串相减

 @param d1 字符串1
 @param d2 字符串2
 @return 返回相减字符串
 */
+(NSString *)numjian:(NSString *)d1 d2:(NSString *)d2;
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:d1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:d2];

    NSDecimalNumber *total = [num1 decimalNumberBySubtracting:num2];

    return [(NSDecimalNumber *)total stringValue];
}

/**
 字符串除

 @param d1 字符串1
 @param d2 字符串2
 @return 返回相除后的字符串
 */
+(NSString *)numchu:(NSString *)d1 d2:(NSString *)d2;
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:d1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:d2];

    NSDecimalNumber *total = [num1 decimalNumberByDividingBy:num2];

    return [(NSDecimalNumber *)total stringValue];
}


/**
 字符串相乘

 @param d1 字符串1
 @param d2 字符串2
 @return 返回字符串相乘
 */
+(NSString *)numcheng:(NSString *)d1 d2:(NSString *)d2;
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:d1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:d2];

    NSDecimalNumber *total = [num1 decimalNumberByMultiplyingBy:num2];

    return [(NSDecimalNumber *)total stringValue];
}
@end
