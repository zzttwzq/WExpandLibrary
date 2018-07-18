//
//  NSMutableArray+WHandler.m
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import "NSMutableArray+WHandler.h"

@implementation NSMutableArray (WHandler)

/**
 安全的取出数组内容

 @param index 下标
 @return 返回数组内容
 */
- (id) safeObjectAtIndex:(NSInteger)index;
{
    if (index < self.count) {
        return self[index];
    }

    NSString *string = [NSString stringWithFormat:@"数组越界 \n%@ \n%ld",self,(long)index];
    DEBUG_LOG(self, string);
    return nil;
}

@end
