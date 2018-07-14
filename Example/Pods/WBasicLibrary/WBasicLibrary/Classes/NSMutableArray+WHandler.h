//
//  NSMutableArray+WHandler.h
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import <Foundation/Foundation.h>
#import "MicroDefinetion.h"

@interface NSMutableArray (WHandler)

/**
 安全的取出数组内容

 @param index 下标
 @return 返回数组内容
 */
- (id) safeObjectAtIndex:(NSInteger)index;

@end
