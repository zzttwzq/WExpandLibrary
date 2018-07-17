//
//  WNetwork.m
//  Pods
//
//  Created by 吴志强 on 2018/7/16.
//

#import "WNetwork.h"

@implementation WNetwork


#pragma mark - NSMutitablehttpRequest

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
             hostType:(HostType)hostType
        enableLoading:(BOOL)enableLoading
       setHeaderfield:(requestBlock _Nullable )setHeaderfield
               result:(Dictionary_ErrorBlock _Nullable )result;
{
    [WNetwork netWorkWithURL:urlString urlMethod:GET_METHOD params:params hostType:hostType enableLoading:enableLoading setHeaderfield:setHeaderfield result:result];
}


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
              hostType:(HostType)hostType
         enableLoading:(BOOL)enableLoading
        setHeaderfield:(requestBlock _Nullable )setHeaderfield
                result:(Dictionary_ErrorBlock _Nullable )result;
{
    [WNetwork netWorkWithURL:urlString urlMethod:POST_METHOD params:params hostType:hostType enableLoading:enableLoading setHeaderfield:setHeaderfield result:result];
}


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
{
    //1.处理url
    if (hostType == HostType_Main) {

        urlString = [NSString stringWithFormat:@"%@%@",MAIN_URL,urlString];
    }else if (hostType == HostType_NONE) {

    }

    //2.url地址编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];

    //3.使用设置来创建一个sesson
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    //4.创建request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.HTTPMethod = urlMethod;

    //5.设置数据
    if ([params isKindOfClass:[NSString class]]) {

        request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    }if ([params isKindOfClass:[NSDictionary class]]) {

        NSDictionary *postDic = params;

        if (postDic) {

            NSString *string = @"";
            for (NSString *key in postDic) {

                string = [string stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,postDic[key]]];
            }
            string = [string substringToIndex:string.length-1];
            string = [string stringByAppendingString:@"&type=JSON"];

            request.HTTPBody = [string dataUsingEncoding:NSUTF8StringEncoding];
        }
    }

    //6.设置类型
    if (setHeaderfield) {
        setHeaderfield(request);
    }
    [request setValue:@"application/json;text/html;" forHTTPHeaderField:@"Content-Type"];

    //7.添加等待视图
    if (enableLoading) {

        [MessageTool showLoading];
    }

    //8.由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                                            if (data) {

                                                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

                                                dispatch_async(dispatch_get_main_queue(), ^(){

                                                    [self handleSuccessWithObject:dic result:result];
                                                });
                                            }else{

                                                NSError *error = [NSError errorWithDomain:@"返回的数据为空！！！" code:0 userInfo:nil];
                                                [self handleErrorWithError:error result:result];
                                            }

                                            [MessageTool dismissLoading];
                                        }];
    //9.启动任务
    [task resume];
}

@end
