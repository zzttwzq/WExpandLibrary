//
//  NSArray+WHander.h
//  AFNetworking
//
//  Created by 吴志强 on 2019/1/14.
//

#import <Foundation/Foundation.h>
#import "MicroDefinetion.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (WHander)

/**
 安全的取出数组内容

 @param index 下标
 @return 返回数组内容
 */
- (id) safeObjectAtIndex:(NSInteger)index;


/**
 数组排序 降序 4 3 2 1
 */
- (void) desc;


/**
 数组排序 升序 1 2 3 4
 */
- (void) asc;

@end

NS_ASSUME_NONNULL_END
