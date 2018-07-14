//
//  WFileManager.m
//  Pods
//
//  Created by 吴志强 on 2018/3/6.
//

/*
 IOS管理文件和目录

 1、常见的NSFileManager文件方法

 -(NSData *)contentsAtPath:path　　//从一个文件读取数据

 -(BOOL)createFileAtPath: path contents:(NSData *)data attributes:attr　　//向一个文件写入数据

 -(BOOL)removeItemAtPath:path error:err　　//删除一个文件

 -(BOOL)moveItemAtPath：from toPath:to error:err　　//重命名或者移动一个文件（to不能是已存在的）

 -(BOOL)copyItemAtPath:from toPath:to error:err　　//复制文件（to不能是已存在的）

 -(BOOL)contentsEqualAtPath:path andPath:path2　　//比较两个文件的内容

 -(BOOL)fileExistAtPath:path　　//测试文件是否存在

 -(BOOL)isReadableFileAtPath:path　　//测试文件是否存在，并且是否能执行读操作

 -(BOOL)isWriteableFileAtPath:path　　//测试文件是否存在，并且是否能执行写操作

 -(NSDictionary *)attributesOfItemAtPath:path error:err　　//获取文件的属性

 -(BOOL)setAttributesOfItemAtPath:attr error:err　　//更改文件的属性

 2.使用目录

 -(NSString *)currentDirectoryPath　　//获取当前目录

 -(BOOL)changeCurrentDirectoryPath:path　　//更改当前目录

 -(BOOL)copyItemAtPath:from toPath:to error:err　　//复制目录结构（to不能是已存在的）

 -(BOOL)createDirectoryAtPath:path withIntermediateDirectories:(BOOL)flag attribute:attr　　//创建一个新目录

 -(BOOL)fileExistAtPath:path isDirectory:(BOOL*)flag　　//测试文件是不是目录（flag中储存结果YES/NO）

 -(NSArray *)contentsOfDirectoryAtPath:path error:err　　//列出目录内容

 -(NSDirectoryEnumerator *)enumeratorAtPath:path　　//枚举目录的内容

 -(BOOL)removeItemAtPath:path error:err　　//删除空目录

 -(BOOL)moveItemAtPath:from toPath:to error:err 　　//重命名或移动一个目录（to不能是已存在的）

 3、常用路径工具方法

 +(NSString *)pathWithComponens:components　　//根据components中的元素构造有效路径

 -(NSArray *)pathComponents　　//析构路径，获得组成此路径的各个部分

 -(NSString *)lastPathComponent　　//提取路径的最后一个组成部分

 -(NSString *)pathExtension　　//从路径的最后一个组成部分中提取其扩展名

 -(NSString *)stringByAppendingPathComponent:path　　//将path添加到现有路径的末尾

 -(NSString *)stringByAppendingPathExtension:ext　　//将指定的扩展名添加到路径的最后一个组成部分

 -(NSString *)stringByDeletingLastPathComponent　　//删除路径的最后一个组成部分

 -(NSString *)stringByDeletingPathExtension　　//从文件的最后一部分删除扩展名

 -(NSString *)stringByExpandingTileInPath　　　//将路径中代字符扩展成用户主目录（~）或指定用户的主目录（~user）

 -(NSString *)stringByresolvingSymlinksInPath　　//尝试解析路径中的符号链接

 -(NSString *)stringByStandardizingPath　　//通过尝试解析~、..（父目录符号）、.（当前目录符号）和符号链接来标准化路径

 4、常用的路径工具函数

 NSString* NSUserName(void)　　//返回当前用户的登录名

 NSString* NSFullUserName(void)　　//返回当前用户的完整用户名

 NSString* NSHomeDirectory(void)　　//返回当前用户主目录的路径

 NSString* NSHomeDirectoryForUser(NSString* user)　　//返回用户user的主目录

 NSString* NSTemporaryDirectory(void)　　//返回可用于创建临时文件的路径目录

 作者：Lydia_qing
 链接：https://www.jianshu.com/p/c763d7a81c43
 來源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

#import "WFileManager.h"

@interface WFileManager ()

@property (nonatomic,strong) NSFileManager *fileManager;

@end

@implementation WFileManager

#pragma mark - 文件主路径
/**
 获取家目录路径

 @return 返回家目录路径
 */
+(NSString *)getHomePath;
{
   return NSHomeDirectory();
}

/**
 获取Documents目录路径

 @return 返回Documents目录路径
 */
+(NSString *)getDocumentPath;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    if (paths.count > 0) {
        return [paths objectAtIndex:0];
    }
    return nil;
}


/**
 获取Caches目录路径的方法

 @return 返回Caches目录路径的方法
 */
+(NSString *)getCachesPath;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    if (paths.count > 0) {
        return [paths objectAtIndex:0];
    }
    return nil;
}


/**
 获取tmp目录路径

 @return 返回tmp目录路径
 */
+(NSString *)getTmpPath;
{
    return NSTemporaryDirectory();
}


#pragma mark - 获取文件路径
/**
 获取文件路径

 @param basePath 主路径
 @param fileName 文件名
 @return 返回文件路径
 */
+ (NSString *) getFilePathWithBasePath:(WFileBasePath)basePath
                            fileName:(NSString *)fileName;
{
    //获取文档目录
    NSString *path = @"";
    NSString *fileFullPath;

    //获取主路径
    if (fileName.length != 0) {

        NSArray *fileInfoArray = [fileName componentsSeparatedByString:@"."];

        NSString *name = fileInfoArray[0];
        NSString *type = @"";

        if (basePath == WFileBasePath_Home) {

            path = [path stringByAppendingString:[WFileManager getHomePath]];
        }
        else if (basePath == WFileBasePath_Document) {

            path = [path stringByAppendingString:[WFileManager getDocumentPath]];
        }
        else if (basePath == WFileBasePath_Tmp) {

            path = [path stringByAppendingString:[WFileManager getTmpPath]];
        }
        else if (basePath == WFileBasePath_Caches) {

            path = [path stringByAppendingString:[WFileManager getCachesPath]];
        }

        if (fileInfoArray.count > 1) {

            type = fileInfoArray[1];

            if (basePath == WFileBasePath_Bundle) {

                path = [[NSBundle mainBundle] pathForResource:name ofType:type];
            }
        }

        //添加文件名和文件类型
        if (basePath != WFileBasePath_Bundle) {

            fileFullPath = [NSString stringWithFormat:@"%@/%@.%@",path,name,type];
        }else{

            if (type.length == 0) {

                fileFullPath = [NSString stringWithFormat:@"%@/%@.%@",path,name,type];
            }else{

                fileFullPath = path;
            }
        }

        return fileFullPath;

    }else{

        WLOG(@"<WFileManager :> 文件名为空");
    }

    return nil;
}


/**
 获取文件路径URL

 @param basePath 主路径
 @param fileName 文件名
 @return 返回文件路径URL
 */
+ (NSURL *) getFilePathURLWithBasePath:(WFileBasePath)basePath
                              fileName:(NSString *)fileName;
{
    NSString *filePath = [self getFilePathWithBasePath:basePath fileName:fileName];

    if (filePath) {
        return [NSURL fileURLWithPath:filePath];
    }

    return nil;
}


/**
 获取文件路径string (会从 document bundle home cache tmp)里按顺序查找

 @param fileName 文件名
 @return 返回文件路径字符串
 */
+ (NSString *) getFilePathWithFileName:(NSString *)fileName;
{
    NSArray *pathArray = @[@(WFileBasePath_Document),@(WFileBasePath_Bundle),@(WFileBasePath_Home),@(WFileBasePath_Caches),@(WFileBasePath_Tmp)];

    for (NSNumber *domainPath  in pathArray) {

        NSString *pathString = [WFileManager getFilePathWithBasePath:[domainPath integerValue] fileName:fileName];

        if (pathString) {

            if ([self fileExsit:pathString]) {

                return pathString;
            }
        }
    }

    WLOG(@"<WFileManager :> 文件不存在");
    return nil;
}


/**
 获取文件路径URL (会从 document bundle home cache tmp)里按顺序查找

 @param fileName 文件名
 @return 返回文件路径URL
 */
+ (NSURL *) getFileURLWithFileName:(NSString *)fileName;
{
    NSString *filePath = [self getFilePathWithFileName:fileName];

    if (filePath) {
        return [NSURL fileURLWithPath:filePath];
    }

    WLOG(@"<WFileManager :> 文件不存在");
    return nil;
}


/**
 获取文件字节数据data (会从 document bundle home cache tmp)里按顺序查找

 @param fileName 文件名称
 @return 返回文件字节数据
 */
+ (NSData *) getFileDataWithFileName:(NSString *)fileName;
{
    NSURL *fileURL = [WFileManager getFileURLWithFileName:fileName];
    return [NSData dataWithContentsOfURL:fileURL];
}


/**
 获取文件内容字符串string (会从 document bundle home cache tmp)里按顺序查找

 @param fileName 文件名称
 @return 返回文件字符串
 */
+ (NSString *) getFileStringWithFileName:(NSString *)fileName;
{
    NSURL *fileURL = [WFileManager getFileURLWithFileName:fileName];
    NSData *fileData = [NSData dataWithContentsOfURL:fileURL];
    return [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
}


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
{
    NSFileManager *fileManager = [NSFileManager new];

    //获取文件路径并验证文件是否存在
    NSString *filePath = [self getFilePathWithBasePath:basePath fileName:fileName];

    //获取要添加的内容数据
    NSData *newData;
    if ([content isKindOfClass:[NSString class]]) {
        newData = [content dataUsingEncoding:NSUTF8StringEncoding];
    }
    else if ([content isKindOfClass:[NSData class]]){
        newData = content;
    }
    else if ([content isKindOfClass:[NSDictionary class]]){
        newData =  [NSJSONSerialization dataWithJSONObject:content options:NSJSONWritingPrettyPrinted error:nil];
    }

    if (replace) {

        if ([fileManager createFileAtPath:filePath contents:newData attributes:nil]) {

            return filePath;
        }else{

            WLOG(@"<WFileManager :> 文件创建失败！");
        }
    }else{

        NSMutableData *oldData = [NSMutableData dataWithData:[NSData dataWithContentsOfURL:[NSURL fileURLWithPath:filePath]]];
        NSMutableData *totalData = [NSMutableData dataWithData:oldData];
        [totalData appendData:newData];

        if ([fileManager createFileAtPath:filePath contents:totalData attributes:nil]) {

            return filePath;
        }else{

            WLOG(@"<WFileManager :> 文件创建失败！");
        }
    }

    return nil;
}


/**
 添加数据

 @param basePath 文件主目录
 @param fileName 文件名
 @param data 添加的数据
 */
+ (void) appendDataWithBasePath:(WFileBasePath)basePath
                       FileName:(NSString *)fileName
                         data:(NSData *)data;
{
    [self createFileBasePath:basePath fileName:fileName content:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] replace:NO];
}


/**
 添加数据

 @param basePath 文件主目录
 @param fileName 文件名
 @param string 添加的字符串
 */
+ (void) appendDataWithBasePath:(WFileBasePath)basePath
                       FileName:(NSString *)fileName
                         string:(NSString *)string;
{
    [self createFileBasePath:basePath fileName:fileName content:string replace:NO];
}


/**
 删除文件

 @param basePath 文件主路径
 @param fileName 文件名
 */
+(void)deleteFileBasePath:(WFileBasePath)basePath
                 fileName:(NSString *)fileName;
{
    NSFileManager *fileManager = [NSFileManager new];

    //获取文件路径并验证文件是否存在
    NSString *filePath = [self getFilePathWithBasePath:basePath fileName:fileName];
    if ([self fileExsit:filePath]) {

        NSError *error;
        if (![fileManager removeItemAtPath:filePath error:&error]) {

            WLOG(@"<WFileManager :> 文件创建失败！%@",error.description);
        }
    }
}


/**
 文件是否存在

 @param path 文件路径
 @return 返回是否存在
 */
+ (BOOL) fileExsit:(NSString *)path;
{
    NSFileManager *filemanager = [[NSFileManager alloc] init];
    if ([filemanager fileExistsAtPath:path]) {

        //添加文件名和文件扩展名
        return YES;
    }

    return NO;
}
@end
