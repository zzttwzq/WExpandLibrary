//
//  NSString+WHandler.h
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import <Foundation/Foundation.h>
#import "WBasicHeader.h"

@interface NSString (WHandler)

#pragma mark - 字符串长度、空、类型 判断
/**
 判断字符串是否为空

 @return 返回是否
 */
- (BOOL) isBlank;


/**
 判断是否为纯数字

 @return 返回结果
 */
- (BOOL) isPureInt;


/**
 中文字符串的长度，中文占1位

 @return 返回长度
 */
- (int) unicodeCount;


/**
 获取不包含中文的字符串长度

 @return 获取不包含中文的字符串长度
 */
- (int) asciiCount;


/**
 字符串总长度,中文占1位

 @return 获取包含中文的字符串长度
 */
- (int) totalCount;


#pragma mark - 字符串加密
/**
 sha1编码

 @return 返回编码的字符串
 */
- (NSString *) SHA1;


/**
 md5编码

 @return 返回md5编码的字符串
 */
- (NSString *) MD5;


#pragma mark - 字符串过滤、截取
/**
 过滤html 字符串

 @return 过滤完成的字符串
 */
- (NSString *)escapeHTMLSpecialString;


/**
 字符串截取

 @param index 开始位置（不指定就是从0开始）
 @param length 截取长度
 @return 返回截取后的字符串
 */
-(NSString *)getStringAtIndex:(int)index
                       length:(int)length;


/**
 字符串是否包含emoji表情

 @return 返回是否包含
 */
- (BOOL) containEmoji;


/**
 去除字符串的emoji表情字符

 @return 返回去除后的字符串
 */
- (instancetype) removeEmoji;


/**
 获取字符串(或汉字)首字母

 @return 获取首字母
 */
- (NSString *) firstCharacter;


#pragma mark - 字符串大小计算
/**
 获取字符串的尺寸

 @param font 要显示的字号
 @param maxSize 最大尺寸
 @return 返回字符串的
 */
- (CGSize) sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


#pragma mark - 判断字符串
/**
 判断是否是手机号

 @return 是否是手机号
 */
- (BOOL) validMobile;


/**
 判断是否是邮箱

 @return 是否是邮箱
 */
- (BOOL) validEmail;


/**
 检查密码

 @return 密码是否包含数字和字母
 */
- (BOOL) validPassWord;


/**
 检查身份证

 @return 身份证是否正确
 */
- (BOOL) validIDCard;


/**
 判断密码是否过于简单

 @return 返回值
 */
- (BOOL) needChangePass;

@end
