//
//  WFileManager.h
//  Pods
//
//  Created by 吴志强 on 2018/3/6.
//

/*
 iphone沙箱模型的有四个文件夹，分别是什么，永久数据存储一般放在什么位置，得到模拟器的路径的简单方式是什么.

 >手动保存的文件在documents文件里
 >Nsuserdefaults保存的文件在tmp文件夹里

 1、Documents 目录：您应该将所有的应用程序数据文件写入到这个目录下。这个目录用于存储用户数据或其它应该定期备份的信息。

 2、AppName.app 目录：这是应用程序的程序包目录，包含应用程序的本身。由于应用程序必须经过签名，所以您在运行时不能对这个目录中的内容进行修改，否则可能会使应用程序无法启动。

 3、Library 目录：这个目录下有两个子目录：Caches 和 Preferences

     Preferences 目录：包含应用程序的偏好设置文件。您不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好.

     Caches 目录：用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息。

 4、tmp 目录：这个目录用于存放临时文件，保存应用程序再次启动过程中不需要的信息。
 */


#import <Foundation/Foundation.h>
#import "Definitions.h"

typedef NS_ENUM(NSInteger,WFileBasePath) {
    WFileBasePath_Document,
    WFileBasePath_Bundle,
    WFileBasePath_Home,
    WFileBasePath_Caches,
    WFileBasePath_Tmp,
};

@interface WFileManager : NSObject

#pragma mark - 文件主路径
/**
 获取家目录路径

 @return 返回家目录路径
 */
+(NSString *)getHomePath;


/**
 获取Documents目录路径

 @return 返回Documents目录路径
 */
+(NSString *)getDocumentPath;


/**
 获取Caches目录路径的方法

 @return 返回Caches目录路径的方法
 */
+(NSString *)getCachesPath;


/**
 获取tmp目录路径

 @return 返回tmp目录路径
 */
+(NSString *)getTmpPath;



#pragma mark - 获取文件路径
/**
 获取文件路径

 @param basePath 主路径
 @param fileName 文件名
 @return 返回文件路径
 */
+ (NSString *) getFilePathWithBasePath:(WFileBasePath)basePath
                              fileName:(NSString *)fileName;


/**
 获取文件路径URL

 @param basePath 主路径
 @param fileName 文件名
 @return 返回文件路径URL
 */
+ (NSURL *) getFilePathURLWithBasePath:(WFileBasePath)basePath
                              fileName:(NSString *)fileName;


/**
 获取文件路径string (会从 document bundle home cache tmp)里按顺序查找

 @param fileName 文件名
 @return 返回文件路径字符串
 */
+ (NSString *) getFilePathWithFileName:(NSString *)fileName;


/**
 获取文件路径URL (会从 document bundle home cache tmp)里按顺序查找

 @param fileName 文件名
 @return 返回文件路径URL
 */
+ (NSURL *) getFileURLWithFileName:(NSString *)fileName;


/**
 获取文件字节数据data (会从 document bundle home cache tmp)里按顺序查找

 @param fileName 文件名称
 @return 返回文件字节数据
 */
+ (NSData *) getFileDataWithFileName:(NSString *)fileName;


/**
 获取文件内容字符串string (会从 document bundle home cache tmp)里按顺序查找

 @param fileName 文件名称
 @return 返回文件字符串
 */
+ (NSString *) getFileStringWithFileName:(NSString *)fileName;


#pragma mark - 文件操作
/**
 创建文件

 @param basePath 指定哪个文档
 @param fileName 文件名
 @param content 文件内容
 @param replace 是否覆盖原文件
 @return 返回文件的路径
 */
+(NSString *)createFileBasePath:(WFileBasePath)basePath
                       fileName:(NSString *)fileName
                        content:(id)content
                        replace:(BOOL)replace;


/**
 添加数据

 @param basePath 文件主目录
 @param fileName 文件名
 @param data 添加的数据
 */
+ (void) appendDataWithBasePath:(WFileBasePath)basePath
                       FileName:(NSString *)fileName
                           data:(NSData *)data;


/**
 添加文本shu j

 @param basePath 文件主目录
 @param fileName 文件名
 @param string 添加的字符串
 */
+ (void) appendDataWithBasePath:(WFileBasePath)basePath
                       FileName:(NSString *)fileName
                         string:(NSString *)string;


/**
 删除文件

 @param basePath 文件主路径
 @param fileName 文件名
 */
+(void)deleteFileBasePath:(WFileBasePath)basePath
                 fileName:(NSString *)fileName;

/**
 文件是否存在

 @param path 文件路径
 @return 返回是否存在
 */
+ (BOOL) fileExsit:(NSString *)path;


#pragma mark - 获取文件的大小

@end
