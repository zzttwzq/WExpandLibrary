//
//  WDataModel.h
//  AFNetworking
//
//  Created by 吴志强 on 2018/2/10.
//

#import <Foundation/Foundation.h>
#import "Definitions.h"

@interface WDataModel : NSObject

//打印对象属性
/**
 把数组的数据转换成对象属性

 @param array 要打印的数组
 */
+(void)printPropertyWithArray:(NSArray *)array;



/**
 将模型转换成对象

 @param array 要处理的数据
 @return 返回当前包含当前对象的数组
 */
+(NSArray *)modelWithArray:(NSArray *)array;
@end
