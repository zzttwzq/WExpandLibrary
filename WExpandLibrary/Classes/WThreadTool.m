//
//  WThreadTool.m
//  Pods
//
//  Created by 吴志强 on 2018/7/14.
//

#import "WThreadTool.h"

@interface WThreadTool ()
@property (nonatomic, strong) dispatch_source_t timer; //定时器
@property (nonatomic,copy) BlankBlock interCallBack;

@end

static WThreadTool *sharedInstance = nil;
static dispatch_once_t once;

@implementation WThreadTool
/**
 创建一个单利用户获取定时器的参数

 @return 返回创建播放view
 */
+ (WThreadTool *)getInstanceWithTotalTime:(NSTimeInterval)total
                                  pertime:(NSTimeInterval)pertime
                               startFrom0:(BOOL)startFrom0
                                 callBack:(floatCallBack)callBack;
{
    dispatch_once(&once, ^{

        sharedInstance = [WThreadTool startTimerWithTimeout:total
                                               timeInterVal:pertime
                                                 startFrom0:startFrom0
                                               countHandler:callBack
                                                   complete:nil];
    });

    return sharedInstance;
}


#pragma mark - GCD 应用
#pragma mark -------定时器应用
/**
 类方法开启一个定时器,时间间隔是1s 直接返回每次时间间隔的回调

 @param totalTime 总的时间
 @param countHandler 每秒回调
 @return 返回一个执行线程
 */
+(WThreadTool *)startTimerWithTotalTime:(NSTimeInterval)totalTime
                           countHandler:(floatCallBack)countHandler;
{
    WThreadTool *tool = [WThreadTool new];
    countHandler(totalTime);

    [tool startTimer:1 timeout:totalTime decrease:YES mainThread:^(float count) {

        countHandler(count);
    }
          backThread:nil
           compolete:nil];

    return tool;
}


/**
 类方法开启一个定时器,时间间隔是1s，可以设置时间长度，累加还是累减，有主线程和完成回调

 @param timeout 到期时间
 @param startFrom0 是否从0开始
 @param countHandler 每秒回调
 @param complete 完成回调
 @return 返回一个执行线程
 */
+(WThreadTool *)startTimerWithTimeout:(NSTimeInterval)timeout
                           startFrom0:(BOOL)startFrom0
                         countHandler:(floatCallBack)countHandler
                             complete:(StateBlock)complete;
{
    WThreadTool *tool = [WThreadTool new];

    [tool startTimer:1 timeout:timeout decrease:!startFrom0 mainThread:^(float count) {

        countHandler(count);
    }
          backThread:nil
           compolete:^(BOOL state) {

               complete(YES);
           }];

    return tool;
}


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
{
    WThreadTool *tool = [WThreadTool new];
    [tool startTimer:timeInterVal timeout:timeout decrease:!startFrom0 mainThread:^(float count) {

        countHandler(count);
    }
          backThread:nil
           compolete:^(BOOL state) {

               complete(YES);
           }];

    return tool;
}


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
{
    __block int count = 0;
    if (decrease) {
        count = timeout;
    }

        // 获得队列
    dispatch_queue_t queue = dispatch_get_main_queue();

        // 创建一个定时器(dispatch_source_t本质还是个OC对象)
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

        // 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
        // GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
        // 何时开始执行第一个任务
        // dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC) 比当前时间晚3秒
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(perTime * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(perTime * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);

        //设置回调
    dispatch_source_set_event_handler(self.timer, ^{

            //通知主线程
        dispatch_async(dispatch_get_main_queue(), ^{

            if (mainThread) {
                mainThread(count);
            }
        });

            //通知后台线程
        dispatch_async(dispatch_get_global_queue(0, 0), ^{

            if (backThread) {
                backThread(count);
            }
        });

            //累加count
        if (decrease) {

            count -= perTime;
            if (count == 0) {

                    //取消定时器
                [self cancelTimer];

                    //完成回调
                dispatch_async(dispatch_get_main_queue(), ^{

                    if (compolete) {
                        compolete(YES);
                    }
                });
            }
        }else{

            count += perTime;
            if (count == timeout) {

                    //取消定时器
                [self cancelTimer];

                    //完成回调
                dispatch_async(dispatch_get_main_queue(), ^{

                    if (compolete) {
                        compolete(YES);
                    }
                });
            }
        }
    });

        // 启动定时器
    dispatch_resume(self.timer);
}


/**
 取消定时器
 */
-(void)cancelTimer
{
        //取消定时器
    dispatch_cancel(self.timer);
    self.timer = nil;
}

#pragma mark -------多线程应用

/**
 获取主队列
 */
+(dispatch_queue_t)getMainQueue;
{
        // 主队列的获取方法
    return dispatch_get_main_queue();
}


/**
 重新创建一个队列(同步队列一般是主队列)

 @param queueType 队列类型（chuan x）
 */
+(dispatch_queue_t)getQueueWithType:(WThreadQueueType)queueType;
{
    if (queueType == WThreadType_SERIAL) {

            //串行队列的创建方法(主动创建)
        return dispatch_queue_create("net.zzttwzq.top", DISPATCH_QUEUE_SERIAL);

            //或者使用主队列
            //        return dispatch_get_main_queue();
    }else{

            // 并发队列的创建方法(主动创建)
        return dispatch_queue_create("net.zzttwzq.top", DISPATCH_QUEUE_CONCURRENT);

            //获取使用全局并发主队列
            //        return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
}


/**
 创建一个线程

 @param excutionType 执行的类型（同步，异步）
 @param queue 要执行的对象队列
 @param excutionBlock 执行的操作
 */
+(void)startTaskWithType:(WThreadSExcutionType)excutionType
                   queue:(dispatch_queue_t)queue
           excutionBlock:(BlankBlock)excutionBlock;
{
    if (excutionType == WThreadType_SYNC) {

        dispatch_sync(queue, ^{

            excutionBlock();
        });
    }else{

        dispatch_async(queue, ^{

            excutionBlock();
        });
    }
}
#pragma mark - NSThread 应用
/**
 开启线程执行一个操作

 @param block 传入要执行的操作
 */
+(void)startTaskWithBlock:(BlankBlock)block;
{
    if (@available(iOS 10.0, *)) {

        NSThread *thread = [[NSThread alloc] initWithBlock:block];
        [thread start];
    } else {

        WThreadTool *tool = [WThreadTool new];
        NSThread *thread = [[NSThread alloc] initWithTarget:tool selector:@selector(callback) object:nil];

        tool.interCallBack = ^{
            block();
        };
        [thread start];
    }
}

-(void)callback
{
    if (_interCallBack) {
        _interCallBack();
    }
}

@end
