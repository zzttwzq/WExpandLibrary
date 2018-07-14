//
//  WPlistManager.m
//  美丽吧
//
//  Created by 吴志强 on 2018/2/5.
//  Copyright © 2018年 刘学通. All rights reserved.
//

#import "WPlistManager.h"

@interface WPlistManager ()

@property (nonatomic,copy) NSString *filePath;
@property (nonatomic,strong) NSMutableDictionary *fileDict;
@property (nonatomic,copy) NSString *fileName;

@end

@implementation WPlistManager

/**
  获取plist管理器的实力对象

  @param name plist文件的名字
  @return 实例化的管理器对象
 */
+(WPlistManager *)plistWithName:(NSString *)name;
{
    WPlistManager *plistManager = [WPlistManager new];
    plistManager.fileName = name;
    [plistManager getDictWithFileName:name];

    return plistManager;
}


/**
 获取plist管理器的实例对象

 @param dict 数据字典
 @param fileName 要保存的文件名
 @return 实例化的管理器对象
 */
+(WPlistManager *)plistWithDict:(NSDictionary *)dict
                   withFileName:(NSString *)fileName;
{
    WPlistManager *plist = [WPlistManager new];
    plist.fileName = fileName;
    plist.fileDict = [NSMutableDictionary dictionaryWithDictionary:dict];

    NSString *path = [WFileManager createFileBasePath:WFileBasePath_Document fileName:fileName content:nil replace:YES];

    [plist wirteToFile];

    return plist;
}


/**
 获取plist文件对应的字典

 @param fileName 文件名
 @return 返回字典
 */
- (NSDictionary *) getDictWithFileName:(NSString *)fileName;
{
    if (!_fileDict) {

        _filePath = [WFileManager getFilePathWithFileName:fileName];
        _fileDict = [NSMutableDictionary dictionaryWithContentsOfFile:_filePath];
    }

    return _fileDict;
}


/**
 获取plist文件对应的字典

 @return 返回字典
 */
- (NSDictionary *) getDict;
{
    return _fileDict;
}


/**
 写入文件
 */
- (void) wirteToFile
{
    [_fileDict writeToFile:_fileName atomically:YES];
}


/**
 获取对应的值

 @param key 键
 @return 值
 */
- (id) getItemWithKey:(NSString *)key;
{
    for (NSString *dictKey in _fileDict) {

        if ([dictKey isEqualToString:key]) {

            return _fileDict[key];
        }
    }

    return nil;
}


/**
 更新对应的值

 @param key 键
 @param value 值
 */
- (void) updateItemWithKey:(NSString *)key
                     value:(id)value;
{
    WEAK_SELF(WPlistManager);
    [WThreadTool startTaskWithBlock:^{

        for (NSString *dictKey in weakSelf.fileDict) {

            if ([dictKey isEqualToString:key]) {

                [weakSelf.fileDict setObject:value forKey:key];
            }
        }

        [self wirteToFile];
    }];
}


/**
 增加值

 @param key 键
 @param value 值
 */
- (void) addItemWithKey:(NSString *)key
                  value:(id)value;
{
    WEAK_SELF(WPlistManager);
    [WThreadTool startTaskWithBlock:^{

        for (NSString *dictKey in weakSelf.fileDict) {

            if ([dictKey isEqualToString:key]) {

                [weakSelf.fileDict setObject:value forKey:key];
            }
        }
        [self wirteToFile];
    }];
}


/**
 删除对应的值

 @param key 对应的key
 */
- (void) deleteItemWithKey:(NSString *)key;
{
    WEAK_SELF(WPlistManager);
    [WThreadTool startTaskWithBlock:^{

        for (NSString *dictKey in weakSelf.fileDict) {

            if ([dictKey isEqualToString:key]) {

                [weakSelf.fileDict removeObjectForKey:key];
            }
        }
        [self wirteToFile];
    }];
}

@end
