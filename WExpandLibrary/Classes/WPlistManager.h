//
//  WPlistManager.h
//  美丽吧
//
//  Created by 吴志强 on 2018/2/5.
//  Copyright © 2018年 刘学通. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFileManager.h"
#import <WBasicLibrary/WBasicHeader.h>

@interface WPlistManager : NSObject

/**
 获取plist管理器的实例对象

 @param name plist文件的名字
 @return 实例化的管理器对象
 */
+(WPlistManager *)plistWithName:(NSString *)name;


/**
 获取plist管理器的实例对象

 @param dict 数据字典
 @param fileName 要保存的文件名
 @return 实例化的管理器对象
 */
+(WPlistManager *)plistWithDict:(NSDictionary *)dict
                   withFileName:(NSString *)fileName;


/**
 获取plist文件对应的字典

 @return 返回字典
 */
- (NSDictionary *) getDict;


/**
 获取对应的值

 @param key 键
 @return 值
 */
- (id) getItemWithKey:(NSString *)key;


/**
 更新对应的值

 @param key 键
 @param value 值
 */
- (void) updateItemWithKey:(NSString *)key
                     value:(id)value;


/**
 增加值

 @param key 键
 @param value 值
 */
- (void) addItemWithKey:(NSString *)key
                  value:(id)value;


/**
 删除对应的值

 @param key 对应的key
 */
- (void) deleteItemWithKey:(NSString *)key;
@end
