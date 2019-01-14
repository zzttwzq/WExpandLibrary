//
//  NSArray+WHander.m
//  AFNetworking
//
//  Created by 吴志强 on 2019/1/14.
//

#import "NSArray+WHander.h"

@implementation NSArray (WHander)

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


/**
 数组排序 降序 4 3 2 1
 */
- (void) desc;
{
    [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {

        return [obj2 compare:obj1]; //降序
    }];
}


/**
 数组排序 升序 1 2 3 4
 */
- (void) asc;
{
    [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {

        return [obj1 compare:obj2]; //升序
    }];
}


@end
