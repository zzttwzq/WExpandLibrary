//
//  NSObject+Whandler.m
//  Pods
//
//  Created by 吴志强 on 2018/7/9.
//

#import "NSObject+Whandler.h"
#import <objc/runtime.h>

@implementation NSObject (Whandler)
#pragma mark - 动态获取对象信息
/**
 获取当前对象的属性名称数组

 @return NSArray 性名称数组
 */
-(NSArray *)getPropertyNames;
{
    //属性名称数组
    NSMutableArray *props = [NSMutableArray array];

    //属性列表变量
    unsigned int outCount,i;

    //获取属性列表对象
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);

    for (i = 0; i<outCount; i++) {

        objc_property_t property = properties[i];

        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];

        [props addObject:propertyName];
    }

    free(properties);

    return props;
}


/**
 获取当前对象的属性名称和值

 @return NSDictionary 包含属性名称和值的字典
 */
-(NSDictionary *)getPropertiesAndValues;
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount,i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);

    for (i = 0; i<outCount; i++) {

        objc_property_t property = properties[i];

        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];

        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {

            [props setObject:propertyValue forKey:propertyName];
        }
    }

    free(properties);
    return props;
}


/**
 获取当前对象的属性名称和值（属性名称都是小写）

 @param isLowercase 是否是小写，如果no 就是大写
 @return NSDictionary 包含小写属性名称和值的字典
 */
-(NSDictionary *)getPropertiesAndValuesWithLowercase:(BOOL)isLowercase;
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount,i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);

    for (i = 0; i<outCount; i++) {

        objc_property_t property = properties[i];

        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];

        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {

            [props setObject:propertyValue forKey:[propertyName lowercaseString]];
        }
    }

    free(properties);
    return props;
}


/**
 获取当前对象的属性和对应的类型

 @return 返回一个包含属性名称和类型的字典
 */
-(NSDictionary *)getPropertiesAndTypes;
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    u_int count;
    objc_property_t * properties  = class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {

        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];

        const char* char_f2 = property_getAttributes(property);
        NSString *propertyType = [NSString stringWithUTF8String:char_f2];

        [dic setObject:propertyType forKey:propertyName];
    }
    free(properties);

    return dic;
}


/**
 获取类方法

 @return 类方法的名称数组
 */
+(NSArray *)getInstenceMethods;
{
    NSMutableArray *array = [NSMutableArray array];

    unsigned int outCount = 0;
    Method *methods = class_copyMethodList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {

        SEL sel = method_getName(methods[i]);

        NSString *string = [NSString stringWithFormat:@"%s",sel_getName(sel)];

        [array addObject:string];
    }
    free(methods);

    return array;
}


#pragma mark - 赋值类操作
/**
 安全的动态设置对象数据（如果要设置的数据包含父类的属性，会出现设置不了的情况）

 @param dict 要设置的字典
 */
- (void) safeSetWithDict:(NSDictionary *)dict;
{
    NSArray *propArray = [self getPropertyNames];

    //避免报错
    if ([dict isKindOfClass:[NSDictionary class]]) {

        for (NSString *key in dict) {

            if ([propArray containsObject:key]) {

                NSString *valueClassString = [NSString stringWithFormat:@"%@",[dict[key] class]];
                if ([valueClassString containsString:@"__NSCFNumber"]) {

                    [self setValue:dict[key] forKey:key];
                }
                else if ([valueClassString containsString:@"__NSCFString"]||
                         [valueClassString containsString:@"NSTaggedPointerString"]) {

                    [self setValue:dict[key] forKey:key];
                }
                else if ([valueClassString containsString:@"__NSCFBoolean"]) {

                    [self setValue:dict[key] forKey:key];
                }
                else if ([valueClassString containsString:@"NSNull"]) {

//                    [self setValue:nil forKey:key];
                }
                else if (dict[key] &&
                    ![dict[key] isKindOfClass:[NSNull class]]) {

                    [self setValue:dict[key] forKey:key];
                }
                else if (![dict[key] isEqualToString:@"<null>"]) {

                    [self setValue:dict[key] forKey:key];
                }
            }
            else{

                [self DEBUGWithTarget:self message:[NSString stringWithFormat:@"没有这个key:%@",key]];
            }
        }
    }else{

        [self DEBUGWithTarget:self message:@"请传入字典！"];
    }
}


/**
 显示调试信息

 @param target 对象
 @param message 消息
 */
- (void) DEBUGWithTarget:(id)target
                 message:(NSString *)message;
{
    DEBUG_LOG(target, message);
}

// 重写setValue:forUndefinedKey:方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    WLOG(@"key = %@, value = %@", key, value);
}

@end
