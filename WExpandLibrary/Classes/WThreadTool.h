//
//  WThreadTool.h
//  Pods
//
//  Created by 吴志强 on 2018/7/14.
//

#import <WBasicLibrary/WBasicHeader.h>

typedef NS_ENUM(NSInteger,WThreadSExcutionType) {
    WThreadType_SYNC,                    //同步执行
    WThreadType_ASYNC,                   //异步执行
};

typedef NS_ENUM(NSInteger,WThreadQueueType) {
    WThreadType_SERIAL,                  //串行队列
    WThreadType_CONCURRENT,              //并行队列
};


@interface WThreadTool : NSObject

#pragma mark - GCD 应用
#pragma mark -------定时器应用
/**
 创建一个单利用户获取定时器的参数

 @return 返回创建播放view
 */
+ (WThreadTool *)getInstanceWithTotalTime:(NSTimeInterval)total
                                  pertime:(NSTimeInterval)pertime
                               startFrom0:(BOOL)startFrom0
                                 callBack:(floatCallBack)callBack;


/**
 类方法开启一个定时器,时间间隔是1s 直接返回每次时间间隔的回调

 @param totalTime 总的时间
 @param countHandler 每秒回调
 @return 返回一个执行线程
 */
+(WThreadTool *)startTimerWithTotalTime:(NSTimeInterval)totalTime
                           countHandler:(floatCallBack)countHandler;


    ///**
    // 类方法开启一个定时器,时间间隔是1s，可以设置时间长度，累加还是累减，有主线程和完成回调
    //
    // @param timeout 到期时间
    // @param startFrom0 是否从0开始
    // @param countHandler 每秒回调
    // @param complete 完成回调
    // @return 返回一个执行线程
    // */
    //+(ThreadTools *)startTimerWithTimeout:(NSTimeInterval)timeout
    //                           startFrom0:(BOOL)startFrom0
    //                         countHandler:(floatCallBack)countHandler
    //                             complete:(StateBlock)complete;


/**
 类方法开启一个定时器，能够预设时间间隔，时间长度，累加还是累减，有主线程和后台线程回调

 @param timeout 到期时间
 @param startFrom0 是否从0开始
 @param timeInterVal 时间间隔
 @param countHandler 每秒回调
 @param complete 完成回调
 @return 返回一个执行线程
 */
+(WThreadTool *)startTimerWithTimeout:(NSTimeInterval)timeout
                         timeInterVal:(NSTimeInterval)timeInterVal
                           startFrom0:(BOOL)startFrom0
                         countHandler:(floatCallBack)countHandler
                             complete:(StateBlock)complete;


/**
 开启一个定时器，可以自定义时间间隔，时间长度，累加还是累减，有主线程和后台线程回调

 @param perTime 间隔频率（s）
 @param timeout 总的时长
 @param decrease 是否减少
 @param mainThread 主现场回调
 @param backThread 后台线程回调
 @param compolete 完成回调
 */
-(void)startTimer:(NSTimeInterval)perTime
          timeout:(NSTimeInterval)timeout
         decrease:(BOOL)decrease
       mainThread:(floatCallBack)mainThread
       backThread:(floatCallBack)backThread
        compolete:(StateBlock)compolete;

/**
 取消定时器
 */
-(void)cancelTimer;

#pragma mark -------多线程应用
/**
 获取主队列
 */
+(dispatch_queue_t)getMainQueue;


/**
 重新创建一个队列(同步队列一般是主队列)

 @param queueType 队列类型（chuan x）
 */
+(dispatch_queue_t)getQueueWithType:(WThreadQueueType)queueType;


/**
 创建一个线程

 @param excutionType 执行的类型（同步，异步）
 @param queue 要执行的对象队列
 @param excutionBlock 执行的操作
 */
+(void)startTaskWithType:(WThreadSExcutionType)excutionType
                   queue:(dispatch_queue_t)queue
           excutionBlock:(BlankBlock)excutionBlock;

#pragma mark - NSThread 应用
/**
 开启线程执行一个操作

 @param block 传入要执行的操作
 */
+(void)startTaskWithBlock:(BlankBlock)block;


@end
