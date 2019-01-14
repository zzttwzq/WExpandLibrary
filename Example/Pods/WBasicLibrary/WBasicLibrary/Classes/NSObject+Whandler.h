//
//  NSObject+Whandler.h
//  Pods
//
//  Created by 吴志强 on 2018/7/9.
//

#import <Foundation/Foundation.h>
#import "MicroDefinetion.h"

@interface NSObject (Whandler)

#pragma mark - 动态获取对象信息
/**
 获取当前对象的属性名称数组

 @return NSArray 性名称数组
 */
-(NSArray *)getPropertyNames;


/**
 获取当前对象的属性名称和值

 @return NSDictionary 包含属性名称和值的字典
 */
-(NSDictionary *)getPropertiesAndValues;


/**
 获取当前对象的属性名称和值（属性名称都是小写）

 @param isLowercase 是否是小写，如果no 就是大写
 @return NSDictionary 包含小写属性名称和值的字典
 */
-(NSDictionary *)getPropertiesAndValuesWithLowercase:(BOOL)isLowercase;


/**
 获取当前对象的属性和对应的类型

 @return 返回一个包含属性名称和类型的字典
 */
-(NSDictionary *)getPropertiesAndTypes;


/**
 获取类方法

 @return 类方法的名称数组
 */
+(NSArray *)getInstenceMethods;


#pragma mark - 赋值类操作
/**
 安全的动态设置对象数据（如果要设置的数据包含父类的属性，会出现设置不了的情况）

 @param dict 要设置的字典
 */
- (void) safeSetWithDict:(NSDictionary *)dict;


/**
 显示调试信息

 @param target 对象
 @param message 消息
 */
- (void) DEBUGWithTarget:(id)target
                 message:(NSString *)message;

@end
