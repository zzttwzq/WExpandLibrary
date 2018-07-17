//
//  WNetwork.h
//  Pods
//
//  Created by 吴志强 on 2018/7/16.
//

#import <Foundation/Foundation.h>
#import <WBasicLibrary/WBasicHeader.h>
#import "AFNetworking.h"

#define GET_METHOD @"GET"
#define POST_METHOD @"POST"

typedef void (^requestFaildBlock) (NSError *error);
typedef void (^requestSuccessBlock) (NSDictionary *respone);
typedef void (^DictionaryBlock) (NSDictionary * _Nullable responseDict);

typedef void (^progressBlock) (NSProgress * _Nonnull progress);
typedef void (^httpHeaderField) (NSMutableURLRequest * _Nonnull request);
typedef void (^AFHttpHeaderField) (AFHTTPRequestSerializer * _Nonnull request);


@interface WNetwork : NSObject
/**
 利用NSMutableURLRequest 实现的http请求

 @param urlString 请求的url或者action
 @param params post数据
 @param setHttpHeaderfield 设置http请求头
 @param success 成功回调
 @param faild 失败回调
 */
+(void)netWorkWithURL:(NSString *_Nullable)urlString
            urlMethod:(NSString *_Nullable)urlMethod
               params:(id _Nullable)params
   setHttpHeaderfield:(httpHeaderField _Nullable )setHttpHeaderfield
              success:(requestSuccessBlock _Nullable )success
                faild:(requestFaildBlock _Nullable )faild;


/**
 nsurl实现的http get请求

 @param urlString 访问的url
 @param params post数据
 @param setHttpHeaderfield 设置http请求头
 @param success 成功回调
 @param faild 失败回调
 */
+(void)getTaskWithURL:(NSString *_Nullable)urlString
               params:(id _Nullable)params
       setHttpHeaderfield:(httpHeaderField _Nullable )setHttpHeaderfield
               success:(requestSuccessBlock _Nullable )success
               faild:(requestFaildBlock _Nullable )faild;


/**
 nsurl实现的http post请求

 @param urlString 访问的url
 @param params post数据
 @param setHttpHeaderfield 设置http请求头
 @param success 成功回调
 @param faild 失败回调
 */
+(void)postTaskWithURL:(NSString *_Nullable)urlString
                params:(id _Nullable)params
    setHttpHeaderfield:(httpHeaderField _Nullable )setHttpHeaderfield
               success:(requestSuccessBlock _Nullable )success
                 faild:(requestFaildBlock _Nullable )faild;


#pragma mark - afnetworking封装的方法
/**
 创建一个单利

 @param HeaderfieldBlock 添加http请求头
 @return 返回单利
 */
+(AFHTTPSessionManager *_Nullable)sharedManagerWithHeaderfieldBlock:(AFHttpHeaderField _Nullable )HeaderfieldBlock;


/**
 afn封装的get方法

 @param urlString 请求地址
 @param params 发送数据
 @param setHttpHeaderfield 设置http请求头
 @param progress 下载进度
 @param success 成功回调
 @param faild 失败回调
 */
+(void)getRequestWithURL:(NSString *_Nullable)urlString
                 params:(NSDictionary *_Nullable)params
          setHttpHeaderfield:(AFHttpHeaderField _Nullable )setHttpHeaderfield
                progress:(progressBlock _Nullable)progress
                 success:(requestSuccessBlock _Nullable )success
                   faild:(requestFaildBlock _Nullable )faild;


/**
 afn封装的post方法

 @param urlString 请求地址
 @param params 发送数据
 @param setHttpHeaderfield 设置http请求头
 @param progress 下载进度
 @param success 成功回调
 @param faild 失败回调
 */
+(void)postRequestWithURL:(NSString *_Nullable)urlString
                   params:(NSDictionary *_Nullable)params
       setHttpHeaderfield:(AFHttpHeaderField _Nullable )setHttpHeaderfield
                 progress:(progressBlock _Nullable)progress
                  success:(requestSuccessBlock _Nullable )success
                    faild:(requestFaildBlock _Nullable )faild;
@end
