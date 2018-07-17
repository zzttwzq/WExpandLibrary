//
//  WJosnTool.h
//  Pods
//
//  Created by 吴志强 on 2018/7/17.
//

#import <Foundation/Foundation.h>

@interface WJosnTool : NSObject

/**
 字典转json

 @param dic 要转换的字典
 @return 转换成json的字符串
 */
+(NSString * _Nullable)dicToJSON:(NSDictionary * _Nullable)dic;


/**
 json字符串转字典

 @param string json字符串
 @return 转换成模型
 */
+(NSDictionary * _Nullable)jsonStringToDic:(NSString * _Nullable)string;


@end
