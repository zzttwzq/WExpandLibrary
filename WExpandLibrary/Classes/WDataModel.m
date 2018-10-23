
    //
//  WDataModel.m
//  AFNetworking
//
//  Created by 吴志强 on 2018/2/10.
//

#import "WDataModel.h"

@implementation WDataModel

    //打印对象属性
/**
 把数组的数据转换成对象属性

 @param array 要打印的数组
 */
+(void)printPropertyWithArray:(NSArray *)array;
{
    if (array.count != 0) {

        NSDictionary *dics = array[0];

        WLOG(@"%@",dics);

        NSString *string = @"";
        for (NSString *key in [dics allKeys]) {

            NSString *valueClassString = [NSString stringWithFormat:@"%@",[dics[key] class]];
            if ([valueClassString containsString:@"__NSCFNumber"]) {

                if ([[key lowercaseString] containsString:@"id"] ||
                    [[key lowercaseString] containsString:@"num"]||
                    [[key lowercaseString] containsString:@"date"]) {

                    string = [string stringByAppendingString:[NSString stringWithFormat:@"\n@property(nonatomic,assign)NSInteger %@;",key]];
                }
                else{

                    string = [string stringByAppendingString:[NSString stringWithFormat:@"\n@property(nonatomic,assign)double %@;",key]];
                }
            }
            else if ([valueClassString containsString:@"__NSCFString"]||
                     [valueClassString containsString:@"NSTaggedPointerString"]) {

                string = [string stringByAppendingString:[NSString stringWithFormat:@"\n@property(nonatomic,copy)NSString *%@;",key]];
            }
            else if ([valueClassString containsString:@"NSNull"]) {

                string = [string stringByAppendingString:[NSString stringWithFormat:@"\n@property(nonatomic,) *%@;",key]];
            }
            else if ([valueClassString containsString:@"__NSCFBoolean"]) {

                string = [string stringByAppendingString:[NSString stringWithFormat:@"\n@property(nonatomic,assign)BOOL %@;",key]];
            }
        }

        WLOG(@"\n%@",string);
    }
    else{

        WLOG(@"数据为空！！！");
    }
}


/**
 将模型转换成对象

 @param array 要处理的数据
 @return 返回当前包含当前对象的数组
 */
+ (NSArray *) listWithArray:(NSArray *)array;
{
    NSMutableArray *tmpArray = [NSMutableArray array];

    if (array) {

        for (NSDictionary *consumptionDic in array) {

            id obj = [[NSClassFromString(NSStringFromClass([self class])) alloc] init];
            [obj setObjectWithDict:consumptionDic];
            [tmpArray addObject:obj];
        }
    }

    return tmpArray;
}

@end
