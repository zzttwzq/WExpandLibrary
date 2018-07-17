//
//  WJosnTool.m
//  Pods
//
//  Created by 吴志强 on 2018/7/17.
//

#import "WJosnTool.h"

@implementation WJosnTool

#pragma mark - 工具方法
/**
 字典转json

 @param dic 要转换的字典
 @return 转换成json的字符串
 */
+(NSString * _Nullable)dicToJSON:(NSDictionary * _Nullable)dic;
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


/**
 json字符串转字典

 @param string json字符串
 @return 转换成模型
 */
+(NSDictionary * _Nullable)jsonStringToDic:(NSString * _Nullable)string;
{
    if (string == nil ||
        ![string isKindOfClass:[NSString class]]) {

        return nil;
    }

    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];

    if(err)
        {
        NSLog(@"json解析失败：%@",err);
        return nil;
        }
    return dic;
}


@end
