//
//  WNetwork.h
//  Pods
//
//  Created by 吴志强 on 2018/7/16.
//

#import <Foundation/Foundation.h>

typedef void(^requestSuccessBlock)();

@interface WNetwork : NSObject

/**
 nsurl实现的http get请求

 @param urlString 访问的url
 @param params post数据
 @param hostType 网络类型
 @param enableLoading 是否开启等待视图
 @param setHeaderfield 设置http请求头
 @param result 返回的结果
 */
+(void)getTaskWithURL:(NSString *_Nullable)urlString
               params:(id _Nullable)params
       setHeaderfield:(requestBlock _Nullable )setHeaderfield
               result:(Dictionary_ErrorBlock _Nullable )result;


/**
 nsurl实现的http post请求

 @param urlString 访问的url
 @param params post数据
 @param hostType 网络类型
 @param enableLoading 是否开启等待视图
 @param setHeaderfield 设置http请求头
 @param result 返回的结果
 */
+(void)postTaskWithURL:(NSString *_Nullable)urlString
                params:(id _Nullable)params
        setHeaderfield:(requestBlock _Nullable )setHeaderfield
                result:(Dictionary_ErrorBlock _Nullable )result;


/**
 利用NSMutableURLRequest 实现的http请求

 @param urlString 请求的url或者action
 @param params post数据
 @param setHeaderfield 设置请求头
 @param hostType 可能存在多个域名的情况
 @param enableLoading 是否添加等待视图
 @param result 返回的bolck
 */
+(void)netWorkWithURL:(NSString *_Nullable)urlString
            urlMethod:(NSString *_Nullable)urlMethod
               params:(id _Nullable)params
             hostType:(HostType)hostType
        enableLoading:(BOOL)enableLoading
       setHeaderfield:(requestBlock _Nullable )setHeaderfield
               result:(Dictionary_ErrorBlock _Nullable )result;


@end
